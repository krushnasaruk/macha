import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/identity/identity_provider.dart';
import '../../../../core/network/connectivity_service.dart';
import '../../../kitchen/data/datasources/kitchen_local_data_source.dart';
import '../../../kitchen/data/repositories/kitchen_repository_impl.dart';
import '../../../kitchen/domain/repositories/kitchen_repository.dart';
import '../../../kitchen/domain/services/kitchen_alert_service.dart';
import '../../../kitchen/domain/services/kitchen_realtime_service.dart';
import '../../data/datasources/orders_local_data_source.dart';
import '../../data/datasources/table_local_data_source.dart';
import '../../data/repositories/orders_repository_impl.dart';
import '../../data/repositories/table_repository_impl.dart';
import '../../domain/models/order_and_table_models.dart';
import '../../domain/repositories/orders_repository.dart';
import '../../domain/repositories/table_repository.dart';
import '../../domain/state_machine/order_lifecycle.dart';

// Tables Providers
final tableLocalDataSourceProvider = Provider<TableLocalDataSource>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return TableLocalDataSource(db);
});

final tableRepositoryProvider = Provider<TableRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  final local = ref.watch(tableLocalDataSourceProvider);
  return TableRepositoryImpl(db: db, localDataSource: local);
});

final tablesStreamProvider = StreamProvider<List<DiningTable>>((ref) {
  final identity = ref.watch(currentIdentityNotifier);
  final repo = ref.watch(tableRepositoryProvider);
  return repo.watchTables(identity.branch.id);
});

// Orders Providers
final ordersLocalDataSourceProvider = Provider<OrdersLocalDataSource>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return OrdersLocalDataSource(db);
});

final ordersRepositoryProvider = Provider<OrdersRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  final local = ref.watch(ordersLocalDataSourceProvider);
  return OrdersRepositoryImpl(db: db, localDataSource: local);
});

class OrdersFilterState {
  final OrderLifecycleStatus? statusFilter;
  final DateTime? fromDate;
  final DateTime? toDate;
  final String searchQuery;

  const OrdersFilterState({
    this.statusFilter,
    this.fromDate,
    this.toDate,
    this.searchQuery = '',
  });

  OrdersFilterState copyWith({
    OrderLifecycleStatus? statusFilter,
    DateTime? fromDate,
    DateTime? toDate,
    String? searchQuery,
    bool clearStatus = false,
  }) {
    return OrdersFilterState(
      statusFilter: clearStatus ? null : (statusFilter ?? this.statusFilter),
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

class OrdersFilterNotifier extends StateNotifier<OrdersFilterState> {
  OrdersFilterNotifier() : super(const OrdersFilterState());

  void setStatusFilter(OrderLifecycleStatus? status) {
    state = state.copyWith(statusFilter: status, clearStatus: status == null);
  }

  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void setDateRange(DateTime? from, DateTime? to) {
    state = state.copyWith(fromDate: from, toDate: to);
  }

  void clearFilters() {
    state = const OrdersFilterState();
  }
}

final ordersFilterProvider = StateNotifierProvider<OrdersFilterNotifier, OrdersFilterState>(
  (ref) => OrdersFilterNotifier(),
);

final ordersStreamProvider = StreamProvider<List<OrderSummary>>((ref) {
  final identity = ref.watch(currentIdentityNotifier);
  final repo = ref.watch(ordersRepositoryProvider);
  final filter = ref.watch(ordersFilterProvider);

  return repo.watchOrders(
    branchId: identity.branch.id,
    statusFilter: filter.statusFilter,
    fromDate: filter.fromDate,
    toDate: filter.toDate,
    searchQuery: filter.searchQuery,
  );
});

// Kitchen Providers
final kitchenLocalDataSourceProvider = Provider<KitchenLocalDataSource>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return KitchenLocalDataSource(db);
});

final kitchenRepositoryProvider = Provider<KitchenRepository>((ref) {
  final local = ref.watch(kitchenLocalDataSourceProvider);
  final ordersRepo = ref.watch(ordersRepositoryProvider);
  return KitchenRepositoryImpl(
    localDataSource: local,
    ordersRepository: ordersRepo,
  );
});

final selectedStationFilterProvider = StateProvider<String?>((ref) => null);

final kitchenStationsStreamProvider = StreamProvider<List<KitchenStation>>((ref) {
  final identity = ref.watch(currentIdentityNotifier);
  final repo = ref.watch(kitchenRepositoryProvider);
  return repo.watchStations(identity.branch.id);
});

final kitchenTicketsStreamProvider = StreamProvider<List<KitchenTicket>>((ref) {
  final identity = ref.watch(currentIdentityNotifier);
  final repo = ref.watch(kitchenRepositoryProvider);
  final stationId = ref.watch(selectedStationFilterProvider);

  return repo.watchTickets(
    branchId: identity.branch.id,
    stationId: stationId,
  );
});

final kitchenRealtimeServiceProvider = Provider<KitchenRealtimeService>((ref) {
  final connectivity = ref.watch(connectivityServiceProvider);
  final alertNotifier = ref.watch(kitchenAlertProvider.notifier);

  final service = KitchenRealtimeService(
    connectivity: connectivity,
    alertNotifier: alertNotifier,
  );

  ref.onDispose(() => service.dispose());
  return service;
});

import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../permissions/role_permissions.dart';
import 'identity_models.dart';

/// Contract for identity, tenant, branch, and role resolution (ADR-D4).
abstract class IdentityProvider {
  SessionIdentity get currentIdentity;
  Stream<SessionIdentity> get identityStream;

  Future<void> switchRole(UserRole role);
  Future<void> switchBranch(String branchId);
  List<Employee> get availableEmployees;
  List<Branch> get availableBranches;
}

/// Development identity provider seeded with demo tenant, two branches, and six roles.
class DevIdentityProvider implements IdentityProvider {
  static const Tenant demoTenant = Tenant(
    id: 'tenant_demo_001',
    name: 'Artisan Roast Café',
    currency: 'INR',
    timezone: 'Asia/Kolkata',
  );

  static const List<Branch> demoBranches = [
    Branch(
      id: 'branch_khd_01',
      tenantId: 'tenant_demo_001',
      name: 'Kharadi High Street',
      code: 'KHD',
      isDefault: true,
    ),
    Branch(
      id: 'branch_kp_02',
      tenantId: 'tenant_demo_001',
      name: 'Koregaon Park Lane 7',
      code: 'KP',
      isDefault: false,
    ),
  ];

  static const Map<UserRole, Employee> demoEmployees = {
    UserRole.owner: Employee(
      id: 'emp_owner_01',
      tenantId: 'tenant_demo_001',
      branchId: 'branch_khd_01',
      name: 'Arjun Sharma',
      email: 'arjun@artisanroast.com',
      role: UserRole.owner,
    ),
    UserRole.branchManager: Employee(
      id: 'emp_mgr_02',
      tenantId: 'tenant_demo_001',
      branchId: 'branch_khd_01',
      name: 'Priya Patel',
      email: 'priya@artisanroast.com',
      role: UserRole.branchManager,
    ),
    UserRole.cashier: Employee(
      id: 'emp_csh_03',
      tenantId: 'tenant_demo_001',
      branchId: 'branch_khd_01',
      name: 'Rohan Verma',
      email: 'rohan@artisanroast.com',
      role: UserRole.cashier,
    ),
    UserRole.waiter: Employee(
      id: 'emp_wtr_04',
      tenantId: 'tenant_demo_001',
      branchId: 'branch_khd_01',
      name: 'Sneha Joshi',
      email: 'sneha@artisanroast.com',
      role: UserRole.waiter,
    ),
    UserRole.kitchenStaff: Employee(
      id: 'emp_ktc_05',
      tenantId: 'tenant_demo_001',
      branchId: 'branch_khd_01',
      name: 'Chef Vikram Rao',
      email: 'vikram@artisanroast.com',
      role: UserRole.kitchenStaff,
    ),
    UserRole.inventoryManager: Employee(
      id: 'emp_inv_06',
      tenantId: 'tenant_demo_001',
      branchId: 'branch_khd_01',
      name: 'Anil Kulkarni',
      email: 'anil@artisanroast.com',
      role: UserRole.inventoryManager,
    ),
  };

  static const RegisteredDevice demoDevice = RegisteredDevice(
    id: 'device_pos_01',
    tenantId: 'tenant_demo_001',
    branchId: 'branch_khd_01',
    deviceSeries: 'A1',
    name: 'Counter Terminal 1',
  );

  late SessionIdentity _currentIdentity;
  final _controller = StreamController<SessionIdentity>.broadcast();

  DevIdentityProvider({UserRole initialRole = UserRole.owner}) {
    _currentIdentity = SessionIdentity(
      tenant: demoTenant,
      branch: demoBranches.first,
      employee: demoEmployees[initialRole]!,
      device: demoDevice,
    );
  }

  @override
  SessionIdentity get currentIdentity => _currentIdentity;

  @override
  Stream<SessionIdentity> get identityStream => _controller.stream;

  @override
  List<Employee> get availableEmployees => demoEmployees.values.toList();

  @override
  List<Branch> get availableBranches => demoBranches;

  @override
  Future<void> switchRole(UserRole role) async {
    final emp = demoEmployees[role]!;
    _currentIdentity = _currentIdentity.copyWith(
      employee: emp.copyWithBranch(_currentIdentity.branch.id),
    );
    _controller.add(_currentIdentity);
  }

  @override
  Future<void> switchBranch(String branchId) async {
    final branch = demoBranches.firstWhere(
      (b) => b.id == branchId,
      orElse: () => demoBranches.first,
    );
    _currentIdentity = _currentIdentity.copyWith(branch: branch);
    _controller.add(_currentIdentity);
  }

  void dispose() {
    _controller.close();
  }
}

extension on Employee {
  Employee copyWithBranch(String newBranchId) {
    return Employee(
      id: id,
      tenantId: tenantId,
      branchId: newBranchId,
      name: name,
      email: email,
      role: role,
    );
  }
}

// ----------------- Riverpod Providers -----------------

final identityProviderInstance = Provider<IdentityProvider>((ref) {
  final provider = DevIdentityProvider();
  ref.onDispose(provider.dispose);
  return provider;
});

final currentIdentityNotifier =
    StateNotifierProvider<CurrentIdentityNotifier, SessionIdentity>((ref) {
  final idProvider = ref.watch(identityProviderInstance);
  return CurrentIdentityNotifier(idProvider);
});

class CurrentIdentityNotifier extends StateNotifier<SessionIdentity> {
  final IdentityProvider _provider;
  StreamSubscription<SessionIdentity>? _sub;

  CurrentIdentityNotifier(this._provider) : super(_provider.currentIdentity) {
    _sub = _provider.identityStream.listen((newIdentity) {
      state = newIdentity;
    });
  }

  Future<void> switchRole(UserRole role) => _provider.switchRole(role);
  Future<void> switchBranch(String branchId) => _provider.switchBranch(branchId);

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}

/// Provider that checks if the active session possesses a specific permission key.
final canPermissionProvider = Provider.family<bool, String>((ref, permissionKey) {
  final identity = ref.watch(currentIdentityNotifier);
  return RolePermissions.hasPermission(identity.role, permissionKey);
});

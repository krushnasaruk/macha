import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import '../../../core/components/app_badge.dart';
import '../../../core/components/app_button.dart';
import '../../../core/components/app_card.dart';
import '../../../core/components/app_text_field.dart';
import '../../../core/components/state_indicators.dart';
import '../../../core/identity/identity_provider.dart';
import '../../../core/permissions/permission_keys.dart';
import '../../../core/permissions/role_permissions.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../domain/models/order_and_table_models.dart';
import 'controllers/orders_providers.dart';

class TablesScreen extends ConsumerStatefulWidget {
  const TablesScreen({super.key});

  @override
  ConsumerState<TablesScreen> createState() => _TablesScreenState();
}

class _TablesScreenState extends ConsumerState<TablesScreen> {
  TableFloorZone? _selectedZone;

  @override
  Widget build(BuildContext context) {
    final identity = ref.watch(currentIdentityNotifier);
    final canManage = RolePermissions.hasPermission(identity.role, AppPermissions.tablesManage);
    final tablesAsync = ref.watch(tablesStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dining Tables'),
        actions: [
          if (canManage)
            IconButton(
              icon: const Icon(Icons.add_rounded),
              tooltip: 'Add Table',
              onPressed: () => _showAddTableDialog(context, identity.branch.id, identity.tenant.id),
            ),
        ],
      ),
      body: Column(
        children: [
          _buildZoneFilter(),
          Expanded(
            child: tablesAsync.when(
              loading: () => const AppLoadingState(message: 'Loading tables...'),
              error: (err, stack) => AppErrorState(
                message: err.toString(),
                onRetry: () => ref.invalidate(tablesStreamProvider),
              ),
              data: (tables) {
                final filtered = _selectedZone == null
                    ? tables
                    : tables.where((t) => t.floorZone == _selectedZone).toList();

                if (filtered.isEmpty) {
                  return AppEmptyState(
                    icon: Icons.table_restaurant_outlined,
                    title: 'No Tables Found',
                    description: canManage
                        ? 'Tap the + icon to add your first dining table.'
                        : 'No tables available in this zone.',
                    actionLabel: canManage ? 'Add Table' : null,
                    onAction: canManage
                        ? () => _showAddTableDialog(context, identity.branch.id, identity.tenant.id)
                        : null,
                  );
                }

                return GridView.builder(
                  padding: AppSpacing.paddingLg,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 220,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.0,
                  ),
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final table = filtered[index];
                    return _TableCard(
                      table: table,
                      onTap: () => _handleTableTap(context, table, tables),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildZoneFilter() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          FilterChip(
            label: const Text('All Zones'),
            selected: _selectedZone == null,
            onSelected: (_) => setState(() => _selectedZone = null),
          ),
          const SizedBox(width: 8),
          ...TableFloorZone.values.map((zone) {
            final isSelected = _selectedZone == zone;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FilterChip(
                label: Text(zone.name.toUpperCase()),
                selected: isSelected,
                onSelected: (_) => setState(() => _selectedZone = zone),
              ),
            );
          }),
        ],
      ),
    );
  }

  void _handleTableTap(BuildContext context, DiningTable table, List<DiningTable> allTables) {
    if (table.status == TableStatus.vacant) {
      _showOpenSessionDialog(context, table);
    } else {
      _showOccupiedTableSheet(context, table, allTables);
    }
  }

  void _showOpenSessionDialog(BuildContext context, DiningTable table) {
    int guests = 2;
    final notesController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          title: Text('Open ${table.name}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Capacity: ${table.capacity} seats • Zone: ${table.floorZone.name.toUpperCase()}'),
              const SizedBox(height: 16),
              const Text('Number of Guests:', style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton.filledTonal(
                    icon: const Icon(Icons.remove),
                    onPressed: guests > 1 ? () => setDialogState(() => guests--) : null,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      '$guests',
                      style: AppTypography.headlineSmall.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton.filledTonal(
                    icon: const Icon(Icons.add),
                    onPressed: () => setDialogState(() => guests++),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              AppTextField(
                controller: notesController,
                label: 'Notes (optional)',
                hint: 'e.g. Birthday, window preference',
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel'),
            ),
            AppButton(
              label: 'Seat Guests',
              onPressed: () async {
                final identity = ref.read(currentIdentityNotifier);
                final repo = ref.read(tableRepositoryProvider);
                try {
                  await repo.openSession(
                    tableId: table.id,
                    guestCount: guests,
                    openedBy: identity.employee.name,
                    notes: notesController.text.trim().isEmpty ? null : notesController.text.trim(),
                  );
                  if (ctx.mounted) Navigator.pop(ctx);
                } catch (e) {
                  if (ctx.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showOccupiedTableSheet(BuildContext context, DiningTable table, List<DiningTable> allTables) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    table.name,
                    style: AppTypography.titleLarge.copyWith(fontWeight: FontWeight.bold),
                  ),
                  _statusBadge(table.status),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                'Zone: ${table.floorZone.name.toUpperCase()} • ${table.capacity} Seats',
                style: const TextStyle(color: Colors.grey),
              ),
              const Divider(height: 24),
              ListTile(
                leading: const Icon(Icons.point_of_sale_rounded, color: AppColors.primary),
                title: const Text('Open in POS'),
                subtitle: const Text('Take order or add items for this table'),
                onTap: () {
                  Navigator.pop(ctx);
                  context.go('/pos');
                },
              ),
              ListTile(
                leading: const Icon(Icons.swap_horiz_rounded, color: Colors.blue),
                title: const Text('Transfer Table'),
                subtitle: const Text('Move this session to another vacant table'),
                onTap: () {
                  Navigator.pop(ctx);
                  _showTransferDialog(context, table, allTables);
                },
              ),
              ListTile(
                leading: const Icon(Icons.call_merge_rounded, color: Colors.purple),
                title: const Text('Merge Table'),
                subtitle: const Text('Merge with another occupied table'),
                onTap: () {
                  Navigator.pop(ctx);
                  _showMergeDialog(context, table, allTables);
                },
              ),
              ListTile(
                leading: const Icon(Icons.qr_code_rounded, color: Colors.teal),
                title: const Text('Table QR Code'),
                subtitle: const Text('View customer digital ordering QR'),
                onTap: () {
                  Navigator.pop(ctx);
                  _showQrDialog(context, table);
                },
              ),
              ListTile(
                leading: const Icon(Icons.check_circle_outline_rounded, color: Colors.red),
                title: const Text('Close Session / Clear Table'),
                subtitle: const Text('Mark table as vacant'),
                onTap: () {
                  Navigator.pop(ctx);
                  _confirmCloseSession(context, table);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showTransferDialog(BuildContext context, DiningTable fromTable, List<DiningTable> allTables) {
    final vacantTables = allTables.where((t) => t.status == TableStatus.vacant && t.id != fromTable.id).toList();

    if (vacantTables.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No vacant tables available for transfer.')),
      );
      return;
    }

    String selectedTargetId = vacantTables.first.id;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          title: Text('Transfer ${fromTable.name}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Select target vacant table:'),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: selectedTargetId,
                items: vacantTables
                    .map(
                      (t) => DropdownMenuItem(
                        value: t.id,
                        child: Text('${t.name} (${t.capacity} seats, ${t.floorZone.name})'),
                      ),
                    )
                    .toList(),
                onChanged: (val) {
                  if (val != null) setDialogState(() => selectedTargetId = val);
                },
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
            AppButton(
              label: 'Transfer',
              onPressed: () async {
                final identity = ref.read(currentIdentityNotifier);
                final repo = ref.read(tableRepositoryProvider);
                try {
                  await repo.transferTable(
                    fromTableId: fromTable.id,
                    toTableId: selectedTargetId,
                    performedBy: identity.employee.name,
                  );
                  if (ctx.mounted) Navigator.pop(ctx);
                } catch (e) {
                  if (ctx.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showMergeDialog(BuildContext context, DiningTable sourceTable, List<DiningTable> allTables) {
    final occupiedTables = allTables
        .where((t) => t.status == TableStatus.occupied && t.id != sourceTable.id)
        .toList();

    if (occupiedTables.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No other occupied tables available to merge with.')),
      );
      return;
    }

    String selectedTargetId = occupiedTables.first.id;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          title: Text('Merge ${sourceTable.name}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Select target occupied table to merge into:'),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: selectedTargetId,
                items: occupiedTables
                    .map(
                      (t) => DropdownMenuItem(
                        value: t.id,
                        child: Text('${t.name} (${t.floorZone.name})'),
                      ),
                    )
                    .toList(),
                onChanged: (val) {
                  if (val != null) setDialogState(() => selectedTargetId = val);
                },
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
            AppButton(
              label: 'Merge',
              onPressed: () async {
                final identity = ref.read(currentIdentityNotifier);
                final repo = ref.read(tableRepositoryProvider);
                try {
                  await repo.mergeTables(
                    sourceTableId: sourceTable.id,
                    targetTableId: selectedTargetId,
                    performedBy: identity.employee.name,
                  );
                  if (ctx.mounted) Navigator.pop(ctx);
                } catch (e) {
                  if (ctx.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _confirmCloseSession(BuildContext context, DiningTable table) {
    if (table.currentSessionId == null) return;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Clear ${table.name}?'),
        content: const Text('This will close the active table session and mark the table as vacant.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          AppButton(
            label: 'Clear Table',
            onPressed: () async {
              final identity = ref.read(currentIdentityNotifier);
              final repo = ref.read(tableRepositoryProvider);
              try {
                await repo.closeSession(
                  tableId: table.id,
                  sessionId: table.currentSessionId!,
                  closedBy: identity.employee.name,
                );
                if (ctx.mounted) Navigator.pop(ctx);
              } catch (e) {
                if (ctx.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
                }
              }
            },
          ),
        ],
      ),
    );
  }

  void _showQrDialog(BuildContext context, DiningTable table) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('${table.name} — QR Ordering'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.qr_code_2_rounded, size: 100, color: Colors.black87),
                  const SizedBox(height: 8),
                  Text(
                    table.name,
                    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Token: ${table.qrToken}',
              style: const TextStyle(fontSize: 12, fontFamily: 'monospace', color: Colors.grey),
            ),
            const SizedBox(height: 8),
            const Text(
              'Customers scan this QR code to view the menu and place orders from their table.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showAddTableDialog(BuildContext context, String branchId, String tenantId) {
    final nameController = TextEditingController();
    int capacity = 4;
    TableFloorZone zone = TableFloorZone.indoor;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          title: const Text('Add New Dining Table'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppTextField(
                controller: nameController,
                label: 'Table Name / Number',
                hint: 'e.g. Table 12 or T-04',
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Text('Capacity: '),
                  const Spacer(),
                  IconButton.filledTonal(
                    icon: const Icon(Icons.remove),
                    onPressed: capacity > 1 ? () => setDialogState(() => capacity--) : null,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text('$capacity', style: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  IconButton.filledTonal(
                    icon: const Icon(Icons.add),
                    onPressed: () => setDialogState(() => capacity++),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<TableFloorZone>(
                value: zone,
                decoration: const InputDecoration(labelText: 'Floor Zone'),
                items: TableFloorZone.values
                    .map((z) => DropdownMenuItem(value: z, child: Text(z.name.toUpperCase())))
                    .toList(),
                onChanged: (val) {
                  if (val != null) setDialogState(() => zone = val);
                },
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
            AppButton(
              label: 'Create Table',
              onPressed: () async {
                final name = nameController.text.trim();
                if (name.isEmpty) return;

                final repo = ref.read(tableRepositoryProvider);
                final newTable = DiningTable(
                  id: const Uuid().v4(),
                  tenantId: tenantId,
                  branchId: branchId,
                  name: name,
                  capacity: capacity,
                  floorZone: zone,
                  status: TableStatus.vacant,
                  qrToken: const Uuid().v4().substring(0, 8),
                  createdAt: DateTime.now(),
                  updatedAt: DateTime.now(),
                );

                try {
                  await repo.saveTable(newTable);
                  if (ctx.mounted) Navigator.pop(ctx);
                } catch (e) {
                  if (ctx.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _statusBadge(TableStatus status) {
    switch (status) {
      case TableStatus.vacant:
        return AppBadge(label: 'Vacant', backgroundColor: Colors.green.shade100, textColor: Colors.green.shade900);
      case TableStatus.occupied:
        return AppBadge(label: 'Occupied', backgroundColor: Colors.amber.shade100, textColor: Colors.amber.shade900);
      case TableStatus.billed:
        return AppBadge(label: 'Billed', backgroundColor: Colors.blue.shade100, textColor: Colors.blue.shade900);
      case TableStatus.reserved:
        return AppBadge(label: 'Reserved', backgroundColor: Colors.purple.shade100, textColor: Colors.purple.shade900);
    }
  }
}

class _TableCard extends StatelessWidget {
  final DiningTable table;
  final VoidCallback onTap;

  const _TableCard({
    required this.table,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isOccupied = table.status == TableStatus.occupied;
    final isBilled = table.status == TableStatus.billed;

    Color iconColor;
    if (isOccupied) {
      iconColor = Colors.amber.shade800;
    } else if (isBilled) {
      iconColor = Colors.blue.shade700;
    } else if (table.status == TableStatus.reserved) {
      iconColor = Colors.purple.shade700;
    } else {
      iconColor = Colors.green.shade700;
    }

    return AppCard(
      onTap: onTap,
      isSelected: isOccupied,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                table.floorZone.name.toUpperCase(),
                style: const TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold),
              ),
              _statusDot(table.status),
            ],
          ),
          const Spacer(),
          Icon(Icons.table_restaurant_rounded, size: 36, color: iconColor),
          const SizedBox(height: 6),
          Text(
            table.name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            '${table.capacity} seats',
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const Spacer(),
          Text(
            table.status.name.toUpperCase(),
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: iconColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusDot(TableStatus status) {
    Color dotColor;
    switch (status) {
      case TableStatus.vacant:
        dotColor = Colors.green;
        break;
      case TableStatus.occupied:
        dotColor = Colors.amber.shade700;
        break;
      case TableStatus.billed:
        dotColor = Colors.blue;
        break;
      case TableStatus.reserved:
        dotColor = Colors.purple;
        break;
    }
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
    );
  }
}

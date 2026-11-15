/// Role enumeration for CaféOS employees.
enum UserRole {
  owner('Owner', 'Full access to all café operations, settings, and finances.'),
  branchManager('Branch Manager', 'Manages branch operations, staff, refunds, and inventory.'),
  cashier('Cashier', 'POS billing, cash drawer management, and order taking.'),
  waiter('Waiter / Server', 'Table management and dine-in order entry.'),
  kitchenStaff('Kitchen Staff', 'Kitchen Display System (KDS) order fulfillment.'),
  inventoryManager('Inventory Manager', 'Stock counts, purchasing, and recipe tracking.');

  final String title;
  final String description;
  const UserRole(this.title, this.description);
}

class Tenant {
  final String id;
  final String name;
  final String currency;
  final String timezone;

  const Tenant({
    required this.id,
    required this.name,
    this.currency = 'INR',
    this.timezone = 'Asia/Kolkata',
  });
}

class Branch {
  final String id;
  final String tenantId;
  final String name;
  final String code;
  final bool isDefault;

  const Branch({
    required this.id,
    required this.tenantId,
    required this.name,
    required this.code,
    this.isDefault = false,
  });
}

class Employee {
  final String id;
  final String tenantId;
  final String branchId;
  final String name;
  final String email;
  final UserRole role;

  const Employee({
    required this.id,
    required this.tenantId,
    required this.branchId,
    required this.name,
    required this.email,
    required this.role,
  });
}

class RegisteredDevice {
  final String id;
  final String tenantId;
  final String branchId;
  final String deviceSeries;
  final String name;

  const RegisteredDevice({
    required this.id,
    required this.tenantId,
    required this.branchId,
    required this.deviceSeries,
    required this.name,
  });
}

/// Active identity state describing the currently logged in employee and operating environment.
class SessionIdentity {
  final Tenant tenant;
  final Branch branch;
  final Employee employee;
  final RegisteredDevice device;

  const SessionIdentity({
    required this.tenant,
    required this.branch,
    required this.employee,
    required this.device,
  });

  UserRole get role => employee.role;

  SessionIdentity copyWith({
    Tenant? tenant,
    Branch? branch,
    Employee? employee,
    RegisteredDevice? device,
  }) {
    return SessionIdentity(
      tenant: tenant ?? this.tenant,
      branch: branch ?? this.branch,
      employee: employee ?? this.employee,
      device: device ?? this.device,
    );
  }
}

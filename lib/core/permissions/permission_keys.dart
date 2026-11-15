/// Canonical set of granular permission keys used across CaféOS.
abstract final class AppPermissions {
  // POS & Billing
  static const String posAccess = 'pos.access';
  static const String posOrderCreate = 'pos.order.create';
  static const String posOrderCancel = 'pos.order.cancel';
  static const String posDiscountApply = 'pos.discount.apply';
  static const String posDiscountOverrideMax = 'pos.discount.override_max';
  static const String posCashDrawerManage = 'pos.cash_drawer.manage';
  static const String posRefundIssue = 'pos.refund.issue';

  // Tables
  static const String tablesAccess = 'tables.access';
  static const String tablesManage = 'tables.manage';

  // Kitchen Display System (KDS)
  static const String kdsAccess = 'kds.access';
  static const String kdsStatusUpdate = 'kds.status.update';

  // Menu Management
  static const String menuView = 'menu.view';
  static const String menuManage = 'menu.manage';

  // Inventory
  static const String inventoryView = 'inventory.view';
  static const String inventoryManage = 'inventory.manage';
  static const String inventoryAdjustment = 'inventory.adjustment';

  // Staff & Attendance
  static const String staffView = 'staff.view';
  static const String staffManage = 'staff.manage';
  static const String staffAttendance = 'staff.attendance';

  // Reports & Financials
  static const String reportsView = 'reports.view';
  static const String financesView = 'finances.view';

  // Settings
  static const String settingsView = 'settings.view';
  static const String settingsManage = 'settings.manage';
}

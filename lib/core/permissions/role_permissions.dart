import '../identity/identity_models.dart';
import 'permission_keys.dart';

abstract final class RolePermissions {
  static const Map<UserRole, Set<String>> _matrix = {
    UserRole.owner: {
      AppPermissions.posAccess,
      AppPermissions.posOrderCreate,
      AppPermissions.posOrderCancel,
      AppPermissions.posDiscountApply,
      AppPermissions.posDiscountOverrideMax,
      AppPermissions.posCashDrawerManage,
      AppPermissions.posRefundIssue,
      AppPermissions.tablesAccess,
      AppPermissions.tablesManage,
      AppPermissions.kdsAccess,
      AppPermissions.kdsStatusUpdate,
      AppPermissions.menuView,
      AppPermissions.menuManage,
      AppPermissions.inventoryView,
      AppPermissions.inventoryManage,
      AppPermissions.inventoryAdjustment,
      AppPermissions.staffView,
      AppPermissions.staffManage,
      AppPermissions.staffAttendance,
      AppPermissions.reportsView,
      AppPermissions.financesView,
      AppPermissions.settingsView,
      AppPermissions.settingsManage,
    },
    UserRole.branchManager: {
      AppPermissions.posAccess,
      AppPermissions.posOrderCreate,
      AppPermissions.posOrderCancel,
      AppPermissions.posDiscountApply,
      AppPermissions.posDiscountOverrideMax,
      AppPermissions.posCashDrawerManage,
      AppPermissions.posRefundIssue,
      AppPermissions.tablesAccess,
      AppPermissions.tablesManage,
      AppPermissions.kdsAccess,
      AppPermissions.kdsStatusUpdate,
      AppPermissions.menuView,
      AppPermissions.menuManage,
      AppPermissions.inventoryView,
      AppPermissions.inventoryManage,
      AppPermissions.inventoryAdjustment,
      AppPermissions.staffView,
      AppPermissions.staffManage,
      AppPermissions.staffAttendance,
      AppPermissions.reportsView,
      AppPermissions.settingsView,
    },
    UserRole.cashier: {
      AppPermissions.posAccess,
      AppPermissions.posOrderCreate,
      AppPermissions.posOrderCancel,
      AppPermissions.posDiscountApply,
      AppPermissions.posCashDrawerManage,
      AppPermissions.tablesAccess,
      AppPermissions.menuView,
      AppPermissions.staffAttendance,
    },
    UserRole.waiter: {
      AppPermissions.posAccess,
      AppPermissions.posOrderCreate,
      AppPermissions.tablesAccess,
      AppPermissions.tablesManage,
      AppPermissions.menuView,
      AppPermissions.staffAttendance,
    },
    UserRole.kitchenStaff: {
      AppPermissions.kdsAccess,
      AppPermissions.kdsStatusUpdate,
      AppPermissions.menuView,
      AppPermissions.staffAttendance,
    },
    UserRole.inventoryManager: {
      AppPermissions.inventoryView,
      AppPermissions.inventoryManage,
      AppPermissions.inventoryAdjustment,
      AppPermissions.menuView,
      AppPermissions.staffAttendance,
    },
  };

  /// Returns whether a given [role] has the specified [permission].
  static bool hasPermission(UserRole role, String permission) {
    return _matrix[role]?.contains(permission) ?? false;
  }

  /// Returns the complete immutable set of permissions granted to [role].
  static Set<String> permissionsFor(UserRole role) {
    return _matrix[role] ?? const {};
  }
}

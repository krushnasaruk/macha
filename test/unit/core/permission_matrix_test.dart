import 'package:flutter_test/flutter_test.dart';
import 'package:cafe_os/core/identity/identity_models.dart';
import 'package:cafe_os/core/permissions/permission_keys.dart';
import 'package:cafe_os/core/permissions/role_permissions.dart';

void main() {
  group('Role Permissions Matrix', () {
    test('Owner has all permissions', () {
      expect(RolePermissions.hasPermission(UserRole.owner, AppPermissions.posAccess), isTrue);
      expect(RolePermissions.hasPermission(UserRole.owner, AppPermissions.posDiscountOverrideMax), isTrue);
      expect(RolePermissions.hasPermission(UserRole.owner, AppPermissions.financesView), isTrue);
      expect(RolePermissions.hasPermission(UserRole.owner, AppPermissions.settingsManage), isTrue);
      expect(RolePermissions.hasPermission(UserRole.owner, AppPermissions.kdsAccess), isTrue);
      expect(RolePermissions.hasPermission(UserRole.owner, AppPermissions.inventoryAdjustment), isTrue);
    });

    test('Cashier has POS access and basic discount, but not refund or finances or KDS', () {
      expect(RolePermissions.hasPermission(UserRole.cashier, AppPermissions.posAccess), isTrue);
      expect(RolePermissions.hasPermission(UserRole.cashier, AppPermissions.posOrderCreate), isTrue);
      expect(RolePermissions.hasPermission(UserRole.cashier, AppPermissions.posDiscountApply), isTrue);
      expect(RolePermissions.hasPermission(UserRole.cashier, AppPermissions.posDiscountOverrideMax), isFalse);
      expect(RolePermissions.hasPermission(UserRole.cashier, AppPermissions.posRefundIssue), isFalse);
      expect(RolePermissions.hasPermission(UserRole.cashier, AppPermissions.financesView), isFalse);
      expect(RolePermissions.hasPermission(UserRole.cashier, AppPermissions.kdsAccess), isFalse);
      expect(RolePermissions.hasPermission(UserRole.cashier, AppPermissions.inventoryManage), isFalse);
    });

    test('Kitchen staff has KDS access and status update, but no POS or finances', () {
      expect(RolePermissions.hasPermission(UserRole.kitchenStaff, AppPermissions.kdsAccess), isTrue);
      expect(RolePermissions.hasPermission(UserRole.kitchenStaff, AppPermissions.kdsStatusUpdate), isTrue);
      expect(RolePermissions.hasPermission(UserRole.kitchenStaff, AppPermissions.posAccess), isFalse);
      expect(RolePermissions.hasPermission(UserRole.kitchenStaff, AppPermissions.financesView), isFalse);
      expect(RolePermissions.hasPermission(UserRole.kitchenStaff, AppPermissions.tablesManage), isFalse);
    });

    test('Waiter can access tables and create orders, but cannot manage settings or finances', () {
      expect(RolePermissions.hasPermission(UserRole.waiter, AppPermissions.posAccess), isTrue);
      expect(RolePermissions.hasPermission(UserRole.waiter, AppPermissions.tablesManage), isTrue);
      expect(RolePermissions.hasPermission(UserRole.waiter, AppPermissions.posDiscountApply), isFalse);
      expect(RolePermissions.hasPermission(UserRole.waiter, AppPermissions.financesView), isFalse);
      expect(RolePermissions.hasPermission(UserRole.waiter, AppPermissions.settingsManage), isFalse);
    });

    test('Inventory Manager has inventory management and adjustments, but not POS billing', () {
      expect(RolePermissions.hasPermission(UserRole.inventoryManager, AppPermissions.inventoryView), isTrue);
      expect(RolePermissions.hasPermission(UserRole.inventoryManager, AppPermissions.inventoryAdjustment), isTrue);
      expect(RolePermissions.hasPermission(UserRole.inventoryManager, AppPermissions.posOrderCreate), isFalse);
      expect(RolePermissions.hasPermission(UserRole.inventoryManager, AppPermissions.posCashDrawerManage), isFalse);
    });
  });
}

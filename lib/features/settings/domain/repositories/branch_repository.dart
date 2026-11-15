import '../../../../core/database/app_database.dart';

abstract class BranchRepository {
  Future<List<BranchesTableData>> getBranches(String tenantId);
  Stream<List<BranchesTableData>> watchBranches(String tenantId);
  Future<BranchesTableData?> getBranch(String branchId);
  Future<void> saveBranch({
    required String id,
    required String tenantId,
    required String name,
    required String code,
    String? address,
    String? phone,
    bool isDefault = false,
  });
  Future<void> syncBranches(String tenantId);
}

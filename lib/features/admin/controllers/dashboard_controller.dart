import 'package:alarm_sales_guide/data/local/db_helper.dart';
import 'package:alarm_sales_guide/data/models/ad_template_group_model.dart';
import 'package:alarm_sales_guide/data/models/ad_template_model.dart';
import 'package:alarm_sales_guide/data/models/call_script_group_model.dart';
import 'package:alarm_sales_guide/data/models/call_script_model.dart';
import 'package:alarm_sales_guide/routes/routes.dart';
import 'package:alarm_sales_guide/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

import 'package:alarm_sales_guide/routes/routes.dart';

class DashboardController extends GetxController {
  final isLoading = true.obs;
  final selectedTabIndex = 0.obs;

  final totalGroups = 0.obs;
  final totalScripts = 0.obs;
  final recentUpdates = 0.obs;
  final scriptGroups = <CallScriptGroupModel>[].obs;
  final callScripts = <CallScriptModel>[].obs;
  final adTemplateGroups = <AdTemplateGroupModel>[].obs;
  final adTemplates = <AdTemplateModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadStats();
  }

  Future<void> loadStats() async {
    try {
      isLoading.value = true;

      final db = await DatabaseHelper.instance.database;

      final groupsResult = await db.rawQuery(
        'SELECT COUNT(*) as count FROM call_script_groups',
      );
      final scriptsResult = await db.rawQuery(
        'SELECT COUNT(*) as count FROM call_scripts',
      );
      final adGroupsResult = await db.rawQuery(
        'SELECT COUNT(*) as count FROM ad_template_groups',
      );

      int cGroups = Sqflite.firstIntValue(groupsResult) ?? 0;
      int cAdGroups = Sqflite.firstIntValue(adGroupsResult) ?? 0;

      totalGroups.value = cGroups + cAdGroups;
      final cScripts = Sqflite.firstIntValue(scriptsResult) ?? 0;
      final adTemplatesCount =
          Sqflite.firstIntValue(
            await db.rawQuery('SELECT COUNT(*) as count FROM ad_templates'),
          ) ??
          0;
      totalScripts.value = cScripts + adTemplatesCount;
      // Mock recent updates
      recentUpdates.value = 4;
      scriptGroups.assignAll(
        await DatabaseHelper.instance.getCallScriptGroups(),
      );
      callScripts.assignAll(await DatabaseHelper.instance.getAllCallScripts());
      adTemplateGroups.assignAll(
        await DatabaseHelper.instance.getAdTemplateGroups(),
      );
      adTemplates.assignAll(await DatabaseHelper.instance.getAllAdTemplates());
    } catch (e) {
      Get.snackbar('Error', 'Failed to load dashboard stats');
    } finally {
      isLoading.value = false;
    }
  }

  void setTabIndex(int index) {
    selectedTabIndex.value = index;
  }

  Future<bool> createGroup({
    required String title,
    required String titleAm,
    required String icon,
  }) async {
    if (title.trim().isEmpty || titleAm.trim().isEmpty || icon.trim().isEmpty) {
      THelperFunctions.showSnackBar(
        'Validation',
        'Please fill all group fields',
        isError: true,
      );
      return false;
    }

    try {
      await DatabaseHelper.instance.createCallScriptGroup(
        title: title.trim(),
        titleAm: titleAm.trim(),
        icon: icon.trim(),
      );
      await loadStats();
      THelperFunctions.showSnackBar('Success', 'Group created successfully');
      return true;
    } catch (e) {
      THelperFunctions.showSnackBar(
        'Error',
        'Failed to create group',
        isError: true,
      );
      return false;
    }
  }

  Future<bool> updateGroup({
    required int id,
    required String title,
    required String titleAm,
    required String icon,
  }) async {
    if (title.trim().isEmpty || titleAm.trim().isEmpty || icon.trim().isEmpty) {
      THelperFunctions.showSnackBar(
        'Validation',
        'Please fill all group fields',
        isError: true,
      );
      return false;
    }

    try {
      await DatabaseHelper.instance.updateCallScriptGroup(
        id: id,
        title: title.trim(),
        titleAm: titleAm.trim(),
        icon: icon.trim(),
      );
      await loadStats();
      THelperFunctions.showSnackBar('Success', 'Group updated successfully');
      return true;
    } catch (e) {
      THelperFunctions.showSnackBar(
        'Error',
        'Failed to update group',
        isError: true,
      );
      return false;
    }
  }

  Future<void> deleteGroup(int id) async {
    try {
      await DatabaseHelper.instance.deleteCallScriptGroup(id);
      await loadStats();
      THelperFunctions.showSnackBar('Success', 'Group deleted successfully');
    } catch (e) {
      THelperFunctions.showSnackBar(
        'Error',
        'Failed to delete group',
        isError: true,
      );
    }
  }

  Future<bool> createScript({
    required int groupId,
    required String bodyAm,
    required String tag,
  }) async {
    if (bodyAm.trim().isEmpty) {
      THelperFunctions.showSnackBar(
        'Validation',
        'Script body is required',
        isError: true,
      );
      return false;
    }

    try {
      await DatabaseHelper.instance.createCallScript(
        groupId: groupId,
        bodyAm: bodyAm.trim(),
        tag: tag.trim(),
      );
      await loadStats();
      THelperFunctions.showSnackBar('Success', 'Script added successfully');
      return true;
    } catch (e) {
      THelperFunctions.showSnackBar(
        'Error',
        'Failed to add script',
        isError: true,
      );
      return false;
    }
  }

  Future<bool> updateScript({
    required int id,
    required int groupId,
    required String bodyAm,
    required String tag,
  }) async {
    if (bodyAm.trim().isEmpty) {
      THelperFunctions.showSnackBar(
        'Validation',
        'Script body is required',
        isError: true,
      );
      return false;
    }

    try {
      await DatabaseHelper.instance.updateCallScript(
        id: id,
        groupId: groupId,
        bodyAm: bodyAm.trim(),
        tag: tag.trim(),
      );
      await loadStats();
      THelperFunctions.showSnackBar('Success', 'Script updated successfully');
      return true;
    } catch (e) {
      THelperFunctions.showSnackBar(
        'Error',
        'Failed to update script',
        isError: true,
      );
      return false;
    }
  }

  Future<void> deleteScript(int id) async {
    try {
      await DatabaseHelper.instance.deleteCallScript(id);
      await loadStats();
      THelperFunctions.showSnackBar('Success', 'Script deleted successfully');
    } catch (e) {
      THelperFunctions.showSnackBar(
        'Error',
        'Failed to delete script',
        isError: true,
      );
    }
  }

  Future<bool> createAdGroup({
    required String name,
    required String description,
  }) async {
    if (name.trim().isEmpty || description.trim().isEmpty) {
      THelperFunctions.showSnackBar(
        'Validation',
        'Please fill all ad group fields',
        isError: true,
      );
      return false;
    }

    try {
      await DatabaseHelper.instance.createAdTemplateGroup(
        name: name.trim(),
        description: description.trim(),
      );
      await loadStats();
      THelperFunctions.showSnackBar('Success', 'Ad group created successfully');
      return true;
    } catch (e) {
      THelperFunctions.showSnackBar(
        'Error',
        'Failed to create ad group',
        isError: true,
      );
      return false;
    }
  }

  Future<bool> updateAdGroup({
    required int id,
    required String name,
    required String description,
  }) async {
    if (name.trim().isEmpty || description.trim().isEmpty) {
      THelperFunctions.showSnackBar(
        'Validation',
        'Please fill all ad group fields',
        isError: true,
      );
      return false;
    }

    try {
      await DatabaseHelper.instance.updateAdTemplateGroup(
        id: id,
        name: name.trim(),
        description: description.trim(),
      );
      await loadStats();
      THelperFunctions.showSnackBar('Success', 'Ad group updated successfully');
      return true;
    } catch (e) {
      THelperFunctions.showSnackBar(
        'Error',
        'Failed to update ad group',
        isError: true,
      );
      return false;
    }
  }

  Future<void> deleteAdGroup(int id) async {
    try {
      await DatabaseHelper.instance.deleteAdTemplateGroup(id);
      await loadStats();
      THelperFunctions.showSnackBar('Success', 'Ad group deleted successfully');
    } catch (e) {
      THelperFunctions.showSnackBar(
        'Error',
        'Failed to delete ad group',
        isError: true,
      );
    }
  }

  Future<bool> createAdTemplate({
    required int groupId,
    required int dayNumber,
    required String bodyAm,
  }) async {
    if (bodyAm.trim().isEmpty) {
      THelperFunctions.showSnackBar(
        'Validation',
        'Template body is required',
        isError: true,
      );
      return false;
    }

    try {
      await DatabaseHelper.instance.createAdTemplate(
        groupId: groupId,
        dayNumber: dayNumber,
        bodyAm: bodyAm.trim(),
      );
      await loadStats();
      THelperFunctions.showSnackBar(
        'Success',
        'Ad template created successfully',
      );
      return true;
    } catch (e) {
      THelperFunctions.showSnackBar(
        'Error',
        'Failed to create ad template',
        isError: true,
      );
      return false;
    }
  }

  Future<bool> updateAdTemplate({
    required int id,
    required int groupId,
    required int dayNumber,
    required String bodyAm,
  }) async {
    if (bodyAm.trim().isEmpty) {
      THelperFunctions.showSnackBar(
        'Validation',
        'Template body is required',
        isError: true,
      );
      return false;
    }

    try {
      await DatabaseHelper.instance.updateAdTemplate(
        id: id,
        groupId: groupId,
        dayNumber: dayNumber,
        bodyAm: bodyAm.trim(),
      );
      await loadStats();
      THelperFunctions.showSnackBar(
        'Success',
        'Ad template updated successfully',
      );
      return true;
    } catch (e) {
      THelperFunctions.showSnackBar(
        'Error',
        'Failed to update ad template',
        isError: true,
      );
      return false;
    }
  }

  Future<void> deleteAdTemplate(int id) async {
    try {
      await DatabaseHelper.instance.deleteAdTemplate(id);
      await loadStats();
      THelperFunctions.showSnackBar(
        'Success',
        'Ad template deleted successfully',
      );
    } catch (e) {
      THelperFunctions.showSnackBar(
        'Error',
        'Failed to delete ad template',
        isError: true,
      );
    }
  }

  void logout() {
    // Admin logout from dashboard: just redirect to the call guide.
    // (No auth/session clearing here per requested behavior.)
    Get.offAllNamed(AppRoutes.callGuide);
  }
}

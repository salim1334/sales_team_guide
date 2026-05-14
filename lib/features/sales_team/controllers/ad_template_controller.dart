import 'package:get/get.dart';
import 'package:alarm_sales_guide/data/local/db_helper.dart';
import 'package:alarm_sales_guide/data/models/ad_template_group_model.dart';
import 'package:alarm_sales_guide/data/models/ad_template_model.dart';

class AdTemplateController extends GetxController {
  
  final isLoading = true.obs;
  
  // All groups
  final adGroups = <AdTemplateGroupModel>[].obs;
  
  // Currently selected group index
  final selectedGroupIndex = 0.obs;
  
  // Templates for the selected group
  final currentTemplates = <AdTemplateModel>[].obs;
  
  @override
  void onInit() {
    super.onInit();
    loadAdTemplates();
  }

  Future<void> loadAdTemplates() async {
    try {
      isLoading.value = true;
      
      // Load groups
      final groups = await DatabaseHelper.instance.getAdTemplateGroups();
      adGroups.assignAll(groups);
      
      if (groups.isNotEmpty) {
        await loadTemplatesForSelectedGroup();
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load ad templates');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadTemplatesForSelectedGroup() async {
    if (adGroups.isEmpty) return;
    
    final currentGroupId = adGroups[selectedGroupIndex.value].id!;
    final templates = await DatabaseHelper.instance.getAdTemplatesForGroup(currentGroupId);
    currentTemplates.assignAll(templates);
  }

  void selectGroup(int index) {
    if (index != selectedGroupIndex.value && index >= 0 && index < adGroups.length) {
      selectedGroupIndex.value = index;
      loadTemplatesForSelectedGroup();
    }
  }
}

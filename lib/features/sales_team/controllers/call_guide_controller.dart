import 'package:get/get.dart';
import 'package:alarm_sales_guide/data/local/db_helper.dart';
import 'package:alarm_sales_guide/data/models/call_script_group_model.dart';
import 'package:alarm_sales_guide/data/models/call_script_model.dart';

class CallGuideController extends GetxController {
  
  final isLoading = true.obs;
  
  // List of all groups
  final scriptGroups = <CallScriptGroupModel>[].obs;
  
  // Map of group ID to its scripts
  final scriptsByGroup = <int, List<CallScriptModel>>{}.obs;
  
  // Keep track of which group is expanded
  final Map<int, RxBool> expandedState = {};

  @override
  void onInit() {
    super.onInit();
    loadCallGuides();
  }

  Future<void> loadCallGuides() async {
    try {
      isLoading.value = true;
      
      // Load groups
      final groups = await DatabaseHelper.instance.getCallScriptGroups();
      scriptGroups.assignAll(groups);
      
      // Load scripts for each group
      for (var group in groups) {
        final scripts = await DatabaseHelper.instance.getCallScriptsForGroup(group.id!);
        scriptsByGroup[group.id!] = scripts;
        
        // Initialize expanded state for the UI, default first to true
        expandedState[group.id!] = (group.sortOrder == 1).obs;
      }
      
    } catch (e) {
      Get.snackbar('Error', 'Failed to load call scripts');
    } finally {
      isLoading.value = false;
    }
  }
  
  void setExpansion(int groupId, bool isExpanded) {
    if (!expandedState.containsKey(groupId)) return;

    if (isExpanded) {
      for (final entry in expandedState.entries) {
        entry.value.value = entry.key == groupId;
      }
      return;
    }

    expandedState[groupId]!.value = false;
  }
}

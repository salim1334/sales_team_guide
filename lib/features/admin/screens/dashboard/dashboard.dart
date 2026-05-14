import 'package:alarm_sales_guide/common/widgets/app_bar/custom_app_bar.dart';
import 'package:alarm_sales_guide/data/models/ad_template_group_model.dart';
import 'package:alarm_sales_guide/data/models/ad_template_model.dart';
import 'package:alarm_sales_guide/data/models/call_script_group_model.dart';
import 'package:alarm_sales_guide/data/models/call_script_model.dart';
import 'package:alarm_sales_guide/features/admin/controllers/dashboard_controller.dart';
import 'package:alarm_sales_guide/routes/routes.dart';
import 'package:alarm_sales_guide/utils/constants/sizes.dart';
import 'package:alarm_sales_guide/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AdminDashboard extends StatelessWidget {
  AdminDashboard({super.key});

  final controller = Get.put(DashboardController());

  Future<void> _confirmDelete(
    BuildContext context, {
    required String title,
    required String message,
    required VoidCallback onConfirm,
  }) async {
    await Get.dialog(
      AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(onPressed: Get.back, child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              Get.back();
              onConfirm();
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: CustomAppBar(
        title: AppTexts.dashboard,
        actions: [
          IconButton(
            onPressed: () => controller.logout(),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        switch (controller.selectedTabIndex.value) {
          case 1:
            return _buildScriptsTab(context);
          case 2:
            return _buildSettingsTab(context);
          case 0:
          default:
            return _buildGroupsTab(context);
        }
      }),
      bottomNavigationBar: Obx(
        () => NavigationBar(
          selectedIndex: controller.selectedTabIndex.value,
          onDestinationSelected: controller.setTabIndex,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.folder_open),
              label: 'Groups',
            ),
            NavigationDestination(
              icon: Icon(Iconsax.document_text),
              label: 'Scripts',
            ),
            NavigationDestination(
              icon: Icon(Icons.settings_outlined),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGroupsTab(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSizes.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Live Call Guide Groups',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: AppSizes.spaceBtwItems),
          _buildActionCard(
            context,
            'Create Live Call Group',
            Icons.create_new_folder_outlined,
            () => _showCreateGroupDialog(context),
          ),
          const SizedBox(height: AppSizes.spaceBtwSections),
          ...controller.scriptGroups.map(
            (group) => Card(
              child: ListTile(
                leading: CircleAvatar(child: Text(group.icon)),
                title: Text(group.title),
                subtitle: Text(group.titleAm),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () => _showEditGroupDialog(context, group),
                      icon: const Icon(Icons.edit_outlined),
                    ),
                    IconButton(
                      onPressed: () => _confirmDelete(
                        context,
                        title: 'Delete Group',
                        message:
                            'Are you sure you want to delete "${group.title}"? This cannot be undone.',
                        onConfirm: () => controller.deleteGroup(group.id!),
                      ),
                      icon: const Icon(Icons.delete_outline),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSizes.spaceBtwSections),
          Text(
            'Ad Template Groups',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: AppSizes.spaceBtwItems),
          _buildActionCard(
            context,
            'Create Ad Template Group',
            Icons.add_box_outlined,
            () => _showCreateAdGroupDialog(context),
          ),
          const SizedBox(height: AppSizes.spaceBtwSections),
          ...controller.adTemplateGroups.map(
            (group) => Card(
              child: ListTile(
                leading: const CircleAvatar(
                  child: Icon(Icons.campaign_outlined),
                ),
                title: Text(group.name),
                subtitle: Text(group.description),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () => _showEditAdGroupDialog(context, group),
                      icon: const Icon(Icons.edit_outlined),
                    ),
                    IconButton(
                      onPressed: () => _confirmDelete(
                        context,
                        title: 'Delete Ad Group',
                        message:
                            'Are you sure you want to delete "${group.name}"? This cannot be undone.',
                        onConfirm: () => controller.deleteAdGroup(group.id!),
                      ),
                      icon: const Icon(Icons.delete_outline),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScriptsTab(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSizes.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Manage Scripts',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: AppSizes.spaceBtwItems),
          _buildActionCard(
            context,
            'Add Live Call Script',
            Icons.add_circle_outline,
            () => _showCreateScriptDialog(context),
          ),
          const SizedBox(height: AppSizes.sm),
          _buildActionCard(
            context,
            'Add Ad Template Script',
            Icons.playlist_add_outlined,
            () => _showCreateAdTemplateDialog(context),
          ),
          const SizedBox(height: AppSizes.spaceBtwSections),
          _buildStatCard(
            context,
            'Total Groups',
            controller.totalGroups.value.toString(),
            Icons.folder_open,
          ),
          const SizedBox(height: AppSizes.sm),
          _buildStatCard(
            context,
            'Total Scripts',
            controller.totalScripts.value.toString(),
            Iconsax.document_text,
          ),
          const SizedBox(height: AppSizes.spaceBtwSections),
          Text(
            'Scripts by Category and Group',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: AppSizes.sm),
          _buildCallGuideScriptHierarchy(context),
          const SizedBox(height: AppSizes.sm),
          _buildAdTemplateHierarchy(context),
        ],
      ),
    );
  }

  Widget _buildCallGuideScriptHierarchy(BuildContext context) {
    final grouped = <int, List<CallScriptModel>>{};
    for (final script in controller.callScripts) {
      grouped.putIfAbsent(script.groupId, () => []).add(script);
    }

    return Card(
      child: ExpansionTile(
        title: const Text('Live Call Guide'),
        initiallyExpanded: true,
        children: controller.scriptGroups.map((group) {
          final scripts = grouped[group.id] ?? const <CallScriptModel>[];
          return ExpansionTile(
            title: Text(group.title),
            subtitle: Text(group.titleAm),
            children: scripts.isEmpty
                ? const [
                    Padding(
                      padding: EdgeInsets.fromLTRB(16, 0, 16, 12),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('No scripts in this group'),
                      ),
                    ),
                  ]
                : scripts
                      .map(
                        (script) => ListTile(
                          title: Text(
                            script.bodyAm,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(
                            script.tag.isEmpty ? 'No tag' : script.tag,
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () =>
                                    _showEditScriptDialog(context, script),
                                icon: const Icon(Icons.edit_outlined),
                              ),
                              IconButton(
                                onPressed: () => _confirmDelete(
                                  context,
                                  title: 'Delete Script',
                                  message:
                                      'Are you sure you want to delete this script? This cannot be undone.',
                                  onConfirm: () =>
                                      controller.deleteScript(script.id!),
                                ),
                                icon: const Icon(Icons.delete_outline),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildAdTemplateHierarchy(BuildContext context) {
    final grouped = <int, List<AdTemplateModel>>{};
    for (final template in controller.adTemplates) {
      grouped.putIfAbsent(template.groupId, () => []).add(template);
    }

    return Card(
      child: ExpansionTile(
        title: const Text('Ad Templates'),
        initiallyExpanded: true,
        children: controller.adTemplateGroups.map((group) {
          final templates = grouped[group.id] ?? const <AdTemplateModel>[];
          return ExpansionTile(
            title: Text(group.name),
            subtitle: Text(group.description),
            children: templates.isEmpty
                ? const [
                    Padding(
                      padding: EdgeInsets.fromLTRB(16, 0, 16, 12),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('No templates in this group'),
                      ),
                    ),
                  ]
                : templates
                      .map(
                        (template) => ListTile(
                          title: Text(
                            template.bodyAm,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text('Day ${template.dayNumber}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () => _showEditAdTemplateDialog(
                                  context,
                                  template,
                                ),
                                icon: const Icon(Icons.edit_outlined),
                              ),
                              IconButton(
                                onPressed: () =>
                                    controller.deleteAdTemplate(template.id!),
                                icon: const Icon(Icons.delete_outline),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSettingsTab(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSizes.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Settings',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: AppSizes.spaceBtwItems),
          Card(
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Icon(Icons.settings),
              ),
              title: const Text('Open Shared Settings'),
              subtitle: const Text(
                'Use the same settings screen for admin and user',
              ),
              trailing: TextButton.icon(
                onPressed: () => Get.toNamed(AppRoutes.settings),
                icon: const Icon(Icons.open_in_new),
                label: const Text('Open'),
              ),
            ),
          ),
          const SizedBox(height: AppSizes.sm),
          Card(
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Icon(Icons.logout),
              ),
              title: const Text('Logout'),
              subtitle: const Text('Sign out from admin'),
              trailing: TextButton(
                onPressed: controller.logout,
                child: const Text('Logout'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showCreateGroupDialog(BuildContext context) async {
    final titleController = TextEditingController();
    final titleAmController = TextEditingController();
    final iconController = TextEditingController();
    // Auto-generate next icon (A, B, C...) based on how many groups already exist.
    final nextIconChar = String.fromCharCodes([
      'A'.codeUnitAt(0) + (controller.scriptGroups.length % 26),
    ]);
    iconController.text = nextIconChar;

    await Get.dialog(
      AlertDialog(
        title: const Text('Create Group'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: titleAmController,
                decoration: const InputDecoration(labelText: 'Title (Amharic)'),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: iconController,
                decoration: const InputDecoration(labelText: 'Icon Character'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: Get.back, child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              final success = await controller.createGroup(
                title: titleController.text,
                titleAm: titleAmController.text,
                icon: iconController.text,
              );
              if (success) {
                Get.back();
                await Future.delayed(Duration.zero);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  Future<void> _showEditGroupDialog(
    BuildContext context,
    CallScriptGroupModel group,
  ) async {
    final titleController = TextEditingController(text: group.title);
    final titleAmController = TextEditingController(text: group.titleAm);
    final iconController = TextEditingController(text: group.icon);

    await Get.dialog(
      AlertDialog(
        title: const Text('Edit Group'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: titleAmController,
                decoration: const InputDecoration(labelText: 'Title (Amharic)'),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: iconController,
                decoration: const InputDecoration(labelText: 'Icon Character'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: Get.back, child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              final success = await controller.updateGroup(
                id: group.id!,
                title: titleController.text,
                titleAm: titleAmController.text,
                icon: iconController.text,
              );
              if (success) {
                Get.back();
                await Future.delayed(Duration.zero);
              }
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  Future<void> _showCreateScriptDialog(BuildContext context) async {
    final bodyController = TextEditingController();
    final tagController = TextEditingController();
    final selectedGroupId =
        (controller.scriptGroups.isNotEmpty
                ? controller.scriptGroups.first.id
                : null)
            .obs;

    await Get.dialog(
      AlertDialog(
        title: const Text('Add Script'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(
                () => DropdownButtonFormField<int>(
                  initialValue: selectedGroupId.value,
                  decoration: const InputDecoration(labelText: 'Group'),
                  items: controller.scriptGroups
                      .where((group) => group.id != null)
                      .map(
                        (group) => DropdownMenuItem<int>(
                          value: group.id!,
                          child: Text(group.title),
                        ),
                      )
                      .toList(),
                  onChanged: (value) => selectedGroupId.value = value,
                ),
              ),
              TextField(
                controller: tagController,
                decoration: const InputDecoration(labelText: 'Tag'),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: bodyController,
                decoration: const InputDecoration(labelText: 'Script Body'),
                minLines: 3,
                maxLines: 5,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: Get.back, child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              if (selectedGroupId.value == null) return;
              final success = await controller.createScript(
                groupId: selectedGroupId.value!,
                bodyAm: bodyController.text,
                tag: tagController.text,
              );
              if (success) Get.back();
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  Future<void> _showEditScriptDialog(
    BuildContext context,
    CallScriptModel script,
  ) async {
    final bodyController = TextEditingController(text: script.bodyAm);
    final tagController = TextEditingController(text: script.tag);
    final selectedGroupId = script.groupId.obs;

    await Get.dialog(
      AlertDialog(
        title: const Text('Edit Script'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(
                () => DropdownButtonFormField<int>(
                  initialValue: selectedGroupId.value,
                  decoration: const InputDecoration(labelText: 'Group'),
                  items: controller.scriptGroups
                      .where((group) => group.id != null)
                      .map(
                        (group) => DropdownMenuItem<int>(
                          value: group.id!,
                          child: Text(group.title),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value != null) selectedGroupId.value = value;
                  },
                ),
              ),
              TextField(
                controller: tagController,
                decoration: const InputDecoration(labelText: 'Tag'),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: bodyController,
                decoration: const InputDecoration(labelText: 'Script Body'),
                minLines: 3,
                maxLines: 5,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: Get.back, child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              final success = await controller.updateScript(
                id: script.id!,
                groupId: selectedGroupId.value,
                bodyAm: bodyController.text,
                tag: tagController.text,
              );
              if (success) Get.back();
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  Future<void> _showCreateAdGroupDialog(BuildContext context) async {
    final nameController = TextEditingController();
    final descriptionController = TextEditingController();

    await Get.dialog(
      AlertDialog(
        title: const Text('Create Ad Template Group'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Group Name'),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: Get.back, child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              final success = await controller.createAdGroup(
                name: nameController.text,
                description: descriptionController.text,
              );
              if (success) Get.back();
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  Future<void> _showEditAdGroupDialog(
    BuildContext context,
    AdTemplateGroupModel group,
  ) async {
    final nameController = TextEditingController(text: group.name);
    final descriptionController = TextEditingController(
      text: group.description,
    );

    await Get.dialog(
      AlertDialog(
        title: const Text('Edit Ad Template Group'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Group Name'),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: Get.back, child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              final success = await controller.updateAdGroup(
                id: group.id!,
                name: nameController.text,
                description: descriptionController.text,
              );
              if (success) Get.back();
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  Future<void> _showCreateAdTemplateDialog(BuildContext context) async {
    final bodyController = TextEditingController();
    final dayController = TextEditingController(text: '1');
    final selectedGroupId =
        (controller.adTemplateGroups.isNotEmpty
                ? controller.adTemplateGroups.first.id
                : null)
            .obs;

    await Get.dialog(
      AlertDialog(
        title: const Text('Add Ad Template Script'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(
                () => DropdownButtonFormField<int>(
                  initialValue: selectedGroupId.value,
                  decoration: const InputDecoration(labelText: 'Ad Group'),
                  items: controller.adTemplateGroups
                      .where((group) => group.id != null)
                      .map(
                        (group) => DropdownMenuItem<int>(
                          value: group.id!,
                          child: Text(group.name),
                        ),
                      )
                      .toList(),
                  onChanged: (value) => selectedGroupId.value = value,
                ),
              ),
              TextField(
                controller: dayController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Day Number'),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: bodyController,
                decoration: const InputDecoration(labelText: 'Template Body'),
                minLines: 3,
                maxLines: 5,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: Get.back, child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              if (selectedGroupId.value == null) return;
              final dayNumber = int.tryParse(dayController.text.trim()) ?? 1;
              final success = await controller.createAdTemplate(
                groupId: selectedGroupId.value!,
                dayNumber: dayNumber,
                bodyAm: bodyController.text,
              );
              if (success) Get.back();
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  Future<void> _showEditAdTemplateDialog(
    BuildContext context,
    AdTemplateModel template,
  ) async {
    final bodyController = TextEditingController(text: template.bodyAm);
    final dayController = TextEditingController(
      text: template.dayNumber.toString(),
    );
    final selectedGroupId = template.groupId.obs;

    await Get.dialog(
      AlertDialog(
        title: const Text('Edit Ad Template Script'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(
                () => DropdownButtonFormField<int>(
                  initialValue: selectedGroupId.value,
                  decoration: const InputDecoration(labelText: 'Ad Group'),
                  items: controller.adTemplateGroups
                      .where((group) => group.id != null)
                      .map(
                        (group) => DropdownMenuItem<int>(
                          value: group.id!,
                          child: Text(group.name),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value != null) selectedGroupId.value = value;
                  },
                ),
              ),
              TextField(
                controller: dayController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Day Number'),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: bodyController,
                decoration: const InputDecoration(labelText: 'Template Body'),
                minLines: 3,
                maxLines: 5,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: Get.back, child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              final dayNumber =
                  int.tryParse(dayController.text.trim()) ?? template.dayNumber;
              final success = await controller.updateAdTemplate(
                id: template.id!,
                groupId: selectedGroupId.value,
                dayNumber: dayNumber,
                bodyAm: bodyController.text,
              );
              if (success) Get.back();
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String title,
    String value,
    IconData icon, {
    Color? color,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final accentColor = color ?? colorScheme.primary;
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
        side: BorderSide(color: colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.md),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(icon, color: accentColor, size: AppSizes.iconMd),
                Text(
                  value,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: accentColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSizes.xs),
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      elevation: 0,
      color: colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, color: colorScheme.primary),
        title: Text(title, style: Theme.of(context).textTheme.titleMedium),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }
}

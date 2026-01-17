import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';
import 'package:zegen_test_app/app/modules/search/search_controller.dart';
import 'package:zegen_test_app/app/utils/app_colors.dart';
import 'package:zegen_test_app/app/utils/app_toast.dart';
import 'package:zegen_test_app/app/widgets/custom_input.dart';
import 'package:zegen_test_app/app/widgets/custom_search.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SearchPageController controller = Get.find<SearchPageController>();
    final TextEditingController inputCtrl = TextEditingController();

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: CustomInput(
                      controller: inputCtrl,
                      hintText: "Search products...",
                      prefixIcon: FontAwesomeIcons.search,
                      hintSize: 18,
                      backgroundColor: AppColors.background,
                      onChanged: (val) => controller.searchQuery.value = val,
                      onSubmitted: (v) {
                        final q = v?.trim() ?? '';
                        if (q.isEmpty) {
                          showToastification(
                            context: context,
                            type: ToastificationType.warning,
                            title: 'Validation',
                            description: 'Please enter a search term.',
                            style: ToastificationStyle.flatColored,
                          );
                          return;
                        }
                        controller.submitSearch(q);
                        inputCtrl.clear();
                      },
                      onSuffixTap: () {
                        final q = inputCtrl.text.trim();
                        if (q.isEmpty) {
                          showToastification(
                            context: context,
                            type: ToastificationType.warning,
                            title: 'Validation',
                            description: 'Please enter a search term.',
                            style: ToastificationStyle.flatColored,
                          );
                          return;
                        }
                        controller.submitSearch(q);
                        inputCtrl.clear();
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Recent Searches",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () => controller.clearHistory(),
                    child: const Text(
                      "Clear All",
                      style: TextStyle(color: Colors.redAccent),
                    ),
                  ),
                ],
              ),

              Expanded(
                child: Obx(() {
                  if (controller.searchHistory.isEmpty) {
                    return _buildEmptyState();
                  }
                  return ListView.builder(
                    itemCount: controller.searchHistory.length,
                    itemBuilder: (context, index) {
                      final title = controller.searchHistory[index];
                      return HistoryTile(
                        title: title,
                        onTap: () => controller.submitSearch(title),
                        onDelete: () => controller.removeHistoryItem(index),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(
            FontAwesomeIcons.magnifyingGlassMinus,
            size: 80,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 16),
          Text(
            "No recent searches",
            style: TextStyle(color: Colors.grey[400], fontSize: 16),
          ),
        ],
      ),
    );
  }
}

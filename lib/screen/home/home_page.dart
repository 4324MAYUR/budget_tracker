import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/all_category_component.dart';
import '../../components/all_spending_component.dart';
import '../../components/category_component.dart';
import '../../components/spending_component.dart';
import '../../controllers/navigation_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    NavigationController controller = Get.put(NavigationController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("BUDGET TRACKER"),
        centerTitle: true,
      ),
      body: PageView(
        controller: controller.pageController,
        onPageChanged: (index) {
          controller.getNavigationIndex(index: index);
        },
        children: const [
          AllSpendingComponents(),
          SpendingComponents(),
          AllCategoryComponents(),
          CategoryComponents(),
        ],
      ),
      bottomNavigationBar: Obx(
        () {
          return NavigationBar(
            selectedIndex: controller.navigationIndex.value,
            onDestinationSelected: (index) {
              controller.getNavigationIndex(index: index);
              controller.changePageView(index: index);
            },
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.price_check),
                label: "All Spending",
              ),
              NavigationDestination(
                icon: Icon(Icons.attach_money),
                label: "Spending",
              ),
              NavigationDestination(
                icon: Icon(Icons.receipt_long),
                label: "All Category",
              ),
              NavigationDestination(
                icon: Icon(Icons.category),
                label: "Category",
              ),
            ],
          );
        },
      ),
    );
  }
}

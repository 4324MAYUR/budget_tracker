import 'package:flutter/cupertino.dart';
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
    NavigationController controller = Get.put(
      NavigationController(),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("BUDGET TRACKER",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        ),
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
                icon: Icon(CupertinoIcons.creditcard),
                label: "All Spending",
              ),
              NavigationDestination(
                icon: Icon(CupertinoIcons.chart_bar),
                label: "Spending",
              ),
              NavigationDestination(
                icon: Icon(CupertinoIcons.list_bullet),
                label: "All Category",
              ),
              NavigationDestination(
                icon: Icon(Icons.category_sharp),
                label: "Category",
              ),
            ],
          );
        },
      ),
    );
  }
}

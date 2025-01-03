import 'package:budget_tracker/helper/db_helper.dart';
import 'package:budget_tracker/modal/category_modal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  RxInt navigationIndex = 0.obs;
  PageController pageController = PageController(initialPage: 0);

  NavigationController() {
    fetchCategoryData();
  }

  void getNavigationIndex({required int index}) {
    navigationIndex.value = index;
  }

  void changePageView({required int index}) {
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );
    update();
  }

  // Category
  int? categoryIndex;

  void getCategoryIndex({required int index}) {
    categoryIndex = index;
    update();
  }

  void assignDefaultVal() {
    categoryIndex = null;
    update();
  }

  // List AllCategory Data
  Future<List<CategoryModel>>? allCategory;

  void fetchCategoryData() {
    allCategory = DBHelper.dbHelper.fetchData();
  }
  // Search Category

  void searchCategory({required String value}) {
    allCategory = DBHelper.dbHelper.liveSearchCategory(search: value);
    update();
  }

  List<String> categoryImages = [
    "assets/images/bill.png",
    "assets/images/cash.png",
    "assets/images/communication.png",
    "assets/images/deposit.png",
    "assets/images/food.png",
    "assets/images/gift.png",
    "assets/images/health.png",
    "assets/images/movie.png",
    "assets/images/rupee.png",
    "assets/images/salary.png",
    "assets/images/shopping.png",
    "assets/images/transport.png",
    "assets/images/wallet.png",
    "assets/images/withdraw.png",
    "assets/images/other.png",
  ];
}

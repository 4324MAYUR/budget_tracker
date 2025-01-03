import 'package:budget_tracker/controllers/navigation_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../helper/db_helper.dart';

TextEditingController categoryName = TextEditingController();
GlobalKey<FormState> formKey = GlobalKey<FormState>();

class CategoryComponents extends StatelessWidget {
  const CategoryComponents({super.key});

  @override
  Widget build(BuildContext context) {
    NavigationController controller = Get.put(NavigationController());

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                "Choice Your a Category",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.normal,
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: categoryName,
              validator: (val) =>
                  val!.isEmpty ? "Category name is required" : null,
              decoration: InputDecoration(
                labelText: "Category Name",
                hintText: "Enter your category",
                labelStyle: const TextStyle(color: Colors.deepPurple),
                hintStyle: const TextStyle(color: Colors.grey),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Colors.deepPurple,
                    width: 3,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.red),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.red),
                ),
              ),
            ),
            const SizedBox(height: 25),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemCount: controller.categoryImages.length,
                itemBuilder: (child, index) => GetBuilder<NavigationController>(
                  builder: (context) {
                    return GestureDetector(
                      onTap: () {
                        controller.getCategoryIndex(index: index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: (controller.categoryIndex == index)
                                ? Colors.green
                                : Colors.transparent,
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: AssetImage(
                              controller.categoryImages[index],
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  style: ButtonStyle(
                    padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: 10, vertical: 1)),
                    elevation: WidgetStateProperty.all(1),
                    backgroundColor: const WidgetStatePropertyAll(Colors.blue),
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  label: const Text(
                    "Add Category",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      height: 4,
                      color: Colors.black,
                    ),
                  ),
                  onPressed: ()async {
                    if (formKey.currentState!.validate() &&
                        controller.categoryIndex != null) {
                      String name = categoryName.text;
                      String assetPath =
                      controller.categoryImages[controller.categoryIndex!];
                      ByteData byteData = await rootBundle.load(assetPath);
                      Uint8List image = byteData.buffer.asUint8List();
                      int? res = await DBHelper.dbHelper
                          .insertCategory(name: name, image: image);
                      if (res != null) {
                        Get.snackbar(
                          "Success",
                          "Category added successfully! ID: $res",
                          colorText: Colors.white,
                          backgroundColor: Colors.green,
                        );
                      } else {
                        Get.snackbar(
                          "Failed",
                          "Failed to add category.",
                          colorText: Colors.white,
                          backgroundColor: Colors.red,
                        );
                      }
                      categoryName.clear();
                      controller.assignDefaultVal();
                    } else {
                      Get.snackbar(
                        "Required",
                        "Please category name and image select.",
                        colorText: Colors.white,
                        backgroundColor: Colors.redAccent,
                      );
                    }
                    controller.fetchCategoryData();
                  },
                  icon: const Icon(
                    CupertinoIcons.add_circled_solid,
                    color: Colors.black,
                    size: 32,
                  ),
                ),
               ],
            ),
          ],
        ),
      ),
    );
  }
}

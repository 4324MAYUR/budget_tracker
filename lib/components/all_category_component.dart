import 'package:budget_tracker/controllers/navigation_controller.dart';
import 'package:budget_tracker/modal/category_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllCategoryComponents extends StatelessWidget {
  const AllCategoryComponents({super.key});

  @override
  Widget build(BuildContext context) {
    NavigationController controller = Get.put(
      NavigationController(),
    );

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: TextFormField(
              onChanged: (val) async {
                controller.searchCategory(value: val);
              },
              decoration: InputDecoration(
                prefixIcon: const Icon(CupertinoIcons.search,
                    color: Colors.deepPurpleAccent),
                labelText: "Search Category",
                hintText: "Search by Category name",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                    color: Colors.deepPurpleAccent,
                    width: 2,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                    color: Colors.redAccent,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                    color: Colors.redAccent,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: GetBuilder<NavigationController>(
              builder: (context) {
                return FutureBuilder(
                  future: controller.allCategory,
                  builder: (context, snapShot) {
                    if (snapShot.hasError) {
                      return Center(
                        child: Text("ERROR: ${snapShot.error}"),
                      );
                    } else if (snapShot.hasData) {
                      List<CategoryModel> allCategoryData = snapShot.data ?? [];

                      return (allCategoryData.isNotEmpty)
                          ? ListView.builder(
                              itemCount: allCategoryData.length,
                              itemBuilder: (context, index) {
                                CategoryModel data = CategoryModel(
                                  id: allCategoryData[index].id,
                                  name: allCategoryData[index].name,
                                  image: allCategoryData[index].image,
                                );
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: ListTile(
                                      contentPadding: const EdgeInsets.all(12),
                                      leading: CircleAvatar(
                                        radius: 30,
                                        backgroundColor: CupertinoColors.white,
                                        backgroundImage:
                                            MemoryImage(data.image),
                                      ),
                                      title: Text(
                                        data.name,
                                        style: const TextStyle(
                                          color: CupertinoColors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      trailing: const Icon(
                                        CupertinoIcons.chevron_forward,
                                        color: Colors.deepPurpleAccent,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            )
                          : const Center(
                              child: Text(
                                "No Category Data Available",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

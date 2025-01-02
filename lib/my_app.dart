 import 'package:flutter/material.dart';
 import 'package:get/get.dart';

import 'routes/app_routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: GetPages.pages,
      initialRoute: GetPages.home,
    );
   }
}
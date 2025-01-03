import 'package:budget_tracker/screen/home/home_page.dart';
import 'package:get/get.dart';

class GetPages {
  static String home = '/home';

  static List<GetPage> pages = [
    GetPage(
      name: home,
      page: () => const HomePage(),
    ),
  ];
}

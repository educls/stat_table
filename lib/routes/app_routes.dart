import 'package:get/get.dart';
import 'package:stat_table/screens/home_page.dart';

class AppRoutes {
  static const String initialRoute = '/home';
  static final List<GetPage> routes = [
    GetPage(
      name: '/home',
      page: () => HomePage(),
    ),
  ];
}
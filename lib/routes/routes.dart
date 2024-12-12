import 'package:DsenHome/pages/personal/personal_page.dart';
import 'package:get/get.dart';
import '../pages/home_page.dart';
import '../pages/lamp_page.dart';
import '../pages/not_found_page.dart';

final RoutePages = [
        GetPage(name: "/", page: () => const HomePage()),
        GetPage(name: "/lamp", page: () => LampPage()),
        GetPage(name: "/personal", page: () => const PersonalPage(), maintainState: false),
        GetPage(name: "/:path", page: () => const NotFoundPage()),
      ];
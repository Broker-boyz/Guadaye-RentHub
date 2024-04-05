import 'package:get/get.dart';
import 'package:gojo_renthub/mapService/screen/permissio_screen.dart';
import 'package:gojo_renthub/views/screens/login_and_register_pages/forgottenpasswordpage.dart';
import 'package:gojo_renthub/views/screens/login_and_register_pages/login_or_register_page.dart';

class RouteClass {
  static String homePage = '/';
  static String forgottenPasswordPage = '/forgotten-password-page';
  static String mapPermissionPage = '/map-permission-page';

  static String getHomeRoute() => homePage;
  static String getMapPermission() => mapPermissionPage;
  static String getForgottenPasswordRoute() => forgottenPasswordPage;

  static List<GetPage> routes = [
    GetPage(
      name: forgottenPasswordPage,
      page: () => const ForgottenPasswordPage(),
      transition: Transition.fade,
      transitionDuration: const Duration(seconds: 1),
    ),
    GetPage(
      name: homePage,
      page: () => const  LoginOrRegisterPage(),
      transition:Transition.fadeIn,
      transitionDuration: const Duration(seconds: 1),
    ),
    GetPage(
        name: mapPermissionPage,
        page: () => const MapPermissionPage(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(seconds: 1)),
  ];
}

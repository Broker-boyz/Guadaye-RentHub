import 'package:get/get.dart';
import 'package:gojo_renthub/mapService/screen/permission_screen.dart';
import 'package:gojo_renthub/otp/otp_registration_page.dart';
import 'package:gojo_renthub/views/screens/home_and%20_details_page/property_detail_page.dart';
import 'package:gojo_renthub/views/screens/login_and_register_pages/confirm_email_verification_screen.dart';
import 'package:gojo_renthub/views/screens/login_and_register_pages/forgottenpasswordpage.dart';
import 'package:gojo_renthub/views/screens/login_and_register_pages/login_or_register_page.dart';
import 'package:gojo_renthub/views/screens/login_and_register_pages/phone_auth_screen.dart';
import 'package:gojo_renthub/views/screens/login_and_register_pages/verify_email_screen.dart';
import 'package:gojo_renthub/views/subscreens/setting_old.dart';
import 'package:gojo_renthub/views/subscreens/terms_and_conditions.dart';
import 'package:gojo_renthub/views/subscreens/update_profile_screen.dart';

class RouteClass {
  static String homePage = '/';
  static String forgottenPasswordPage = '/forgotten-password-page';
  static String mapPermissionPage = '/map-permission-page';
  static String updateProfilePage = '/update-profile-page';
  static String settingsPage = '/settings-page';
  static String termsAndConditionsPage = '/terms-and-conditions-page';
  static String propertyDetailPage = '/property-detail-page';
  static String phoneAuthentication = '/phone-authentication';
  static String confirmEmail = '/confirm-email';
  static String verifyEmail = '/verify-email';
  static String otp = '/verify-otp';

  static String getHomeRoute() => homePage;
  static String getMapPermission() => mapPermissionPage;
  static String getPropertyDetail() => propertyDetailPage;
  static String getForgottenPasswordRoute() => forgottenPasswordPage;
  static String getUpdateProfilePage() => updateProfilePage;
  static String getSettingsPage() => settingsPage;
  static String getTermsAndConditionsPage() => termsAndConditionsPage;
  static String getPhoneAuthentication() => phoneAuthentication;
  static String getConfirmEmail() => confirmEmail;
  static String getVerifyEmail() => verifyEmail;
  static String getOtp() => otp;

  static List<GetPage> routes = [
    GetPage(
      name: forgottenPasswordPage,
      page: () => const ForgottenPasswordPage(),
      transition: Transition.fade,
      transitionDuration: const Duration(seconds: 1),
    ),
    GetPage(
      name: otp,
      page: () => const OtpRegistrationPage(),
      transition: Transition.fade,
      transitionDuration: const Duration(seconds: 1),
    ),
    GetPage(
      name: verifyEmail,
      page: () =>  VerifyEmailScreen(accountType: 'Tenant',),
      transition: Transition.fade,
      transitionDuration: const Duration(seconds: 1),
    ),
    GetPage(
      name: confirmEmail,
      page: () => const ConfirmEmailScreen(accoutType: 'Tenant',),
      transition: Transition.fade,
      transitionDuration: const Duration(seconds: 1),
    ),
    GetPage(
      name: phoneAuthentication,
      page: () => const PhoneAuthScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(seconds: 1),
    ),
    GetPage(
      name: homePage,
      page: () => const LoginOrRegisterPage(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(seconds: 1),
    ),
    GetPage(
      name: mapPermissionPage,
      page: () => const MapPermissionPage(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(seconds: 1),
    ),
    GetPage(
      name: updateProfilePage,
      page: () => UpdateProfileScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(seconds: 1),
    ),
    GetPage(
      name: settingsPage,
      page: () => SettingsPage(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(seconds: 1),
    ),
    GetPage(
      name: termsAndConditionsPage,
      page: () => const TermsAndConditionsPage(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(seconds: 1),
    ),
    GetPage(
        name: propertyDetailPage,
        page: () => PropertyDetailPage(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(seconds: 1)),
  ];
}

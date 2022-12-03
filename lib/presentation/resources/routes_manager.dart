import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:labanda/presentation/admin/admin_layout.dart';
import 'package:labanda/presentation/checkout_screens/summry.dart';
import 'package:labanda/presentation/home_layout/search_screen.dart';

import '../admin/details_order_screen.dart';
import '../checkout_screens/checkout_screen.dart';
import '../home_layout/edit_profile.dart';
import '../home_layout/home_layout.dart';
import '../home_layout/setting_screen.dart';
import '../product_screens/all_product.dart';
import '../show_screens/onboarding_screen.dart';
import '../show_screens/splash_screen.dart';
import '../users_screens/forget_password_screen.dart';
import '../users_screens/login_screen.dart';
import '../users_screens/register_screen.dart';

class Routes {
  static const String splashRoute = '/';
  static const String onBoardingRoute = '/onBoardingRoute';
  static const String loginRoute = '/loginRoute';
  static const String registerRoute = '/registerRoute';
  static const String forgetPasswordRoute = '/forgetPasswordRoute';
  static const String homeScreenLayoutRoute = '/homeScreenLayoutRoute';
  static const String adminHomeRoute = '/adminHomeRoute';
  static const String searchScreenRoute = '/searchScreenRoute';
  static const String settingsScreenRoute = '/settingsScreenRoute';
  static const String allProduct = '/allProduct';
  static const String editProfile = '/editProfile';
  static const String checkOutScreen = '/checkOutScreen';
  static const String summaryScreen = '/SummaryScreen';
  static const String detailsScreen = '/detailsScreen';
}

class RouteGenerator {
  static Route<dynamic>? getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (_) => OnBoardingScreen());
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case Routes.registerRoute:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case Routes.forgetPasswordRoute:
        return MaterialPageRoute(builder: (_) => ForgetPasswordScreen());
      case Routes.homeScreenLayoutRoute:
        return MaterialPageRoute(builder: (_) => HomeScreenLayout());
      case Routes.adminHomeRoute:
        return MaterialPageRoute(builder: (_) => AdminHome());
      case Routes.searchScreenRoute:
        return MaterialPageRoute(builder: (_) => SearchScreen());
      case Routes.allProduct:
        return MaterialPageRoute(builder: (_) => AllProduct());
      case Routes.editProfile:
        return MaterialPageRoute(builder: (_) => EditProfile());
      case Routes.settingsScreenRoute:
        return MaterialPageRoute(builder: (_) => SettingsScreen());
      case Routes.checkOutScreen:
        return MaterialPageRoute(builder: (_) => CheckOutScreen());
      case Routes.summaryScreen:
        return MaterialPageRoute(builder: (_) => SummaryScreen());
      case Routes.detailsScreen:
        return MaterialPageRoute(builder: (_) => DetailsOrder());
    }
  }
}

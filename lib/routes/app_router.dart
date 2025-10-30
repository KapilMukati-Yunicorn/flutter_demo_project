import 'package:bloc_project/data/models/get_user_model.dart';
import 'package:bloc_project/presentation/add_address/add_address_screen.dart';
import 'package:bloc_project/presentation/bottom_nav/bottom_nav_screen.dart';
import 'package:bloc_project/presentation/cache_reel/cache_reel_screen.dart';
import 'package:bloc_project/presentation/delivery_address/delivery_address_screen.dart';
import 'package:bloc_project/presentation/edit_profile/edit_profile_screen.dart';
import 'package:bloc_project/presentation/notifications/notification_screen.dart';
import 'package:bloc_project/presentation/order_history/order_history_screen.dart';
import 'package:bloc_project/presentation/product_detail/product_detail_screen.dart';
import 'package:bloc_project/presentation/search_screen/dummy.dart';
import 'package:bloc_project/presentation/search_screen/new_serarch.dart';
import 'package:bloc_project/presentation/search_screen/search_screen.dart';
import 'package:bloc_project/presentation/setting/setting_screen.dart';
import 'package:bloc_project/presentation/signup/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:bloc_project/presentation/splash/splash_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/models/get_product_model.dart';
import '../logic/person/person_bloc.dart';
import '../presentation/login/login_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String bottomNav = '/bottom_nav';
  static const String home = '/home';
  static const String productDetail = '/product_detail';
  static const String editProfile = '/edit_profile';
  static const String orderHistory = '/order_history';
  static const String setting = '/setting';
  static const String notifications = '/notifications';
  static const String deliveryAddress = '/delivery_address';
  static const String addAddress = '/add_address';
  static const String cacheReel = '/cache_reel';
  static const String searchScreen = '/search_screen';

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case splash:
        // return MaterialPageRoute(builder: (_) => const SplashScreen());
        return MaterialPageRoute(builder: (_) => BottomNavScreen());

      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case signup:
        return MaterialPageRoute(builder: (_) => SignUpScreen());
      case bottomNav:
        return MaterialPageRoute(builder: (_) => BottomNavScreen());
      case productDetail:
        if (args is Product) {
          return MaterialPageRoute(
            builder: (_) => ProductDetailScreen(product: args),
          );
        } else {
          return _errorRoutes('Need to pass product detail...');
        }

      case home:
      // return MaterialPageRoute(
      //   builder: (_) => HomeScreen(
      //     username: (args as Map)['username'],
      //   ),
      // );

      case editProfile:
        if (args is UserModel) {
          return MaterialPageRoute(
            builder: (_) => EditProfileScreen(userModel: args),
          );
        } else {
          return _errorRoutes('Need to pass user data detail...');
        }
      case orderHistory:
        return MaterialPageRoute(builder: (_) => OrderHistoryScreen());
      case cacheReel:
        return MaterialPageRoute(builder: (_) => CacheReelScreen());
      case setting:
        return MaterialPageRoute(builder: (_) => SettingScreen());
      case notifications:
        return MaterialPageRoute(builder: (_) => NotificationScreen());
      case deliveryAddress:
        return MaterialPageRoute(builder: (_) => DeliveryAddressScreen());
      case addAddress:
        return MaterialPageRoute(builder: (_) => AddAddressScreen());

      case searchScreen:
        // return MaterialPageRoute(builder: (_) => SearchScreen());
        // return MaterialPageRoute(builder: (_) => SearchProductsScreen());
        return MaterialPageRoute(builder: (_) => NewSearchScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }

  static MaterialPageRoute _errorRoutes(String errorMassage) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        body: Center(child: Text('No route defined for $errorMassage')),
      ),
    );
  }
}

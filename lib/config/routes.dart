import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import '../presentation/screens/auth/login_screen.dart';
import '../presentation/screens/auth/signup_screen.dart';
import '../presentation/screens/onboarding/pet_onboarding_screen.dart';
import '../presentation/screens/home/home_screen.dart';
import '../presentation/screens/products/product_list_screen.dart';
import '../presentation/screens/products/product_detail_screen.dart';
import '../presentation/screens/cart/cart_screen.dart';
import '../presentation/screens/cart/checkout_screen.dart';
import '../presentation/screens/orders/orders_screen.dart';
import '../presentation/screens/orders/order_detail_screen.dart';
import '../presentation/screens/profile/profile_screen.dart';
import '../presentation/screens/profile/pet_profile_screen.dart';
import '../core/utils/storage_helper.dart';

class AppRouter {
  static GoRouter router = GoRouter(
    initialLocation: '/',
    redirect: (context, state) async {
      final token = await StorageHelper.getToken();
      final isLoggedIn = token != null;
      final isOnAuthPage = state.matchedLocation == '/login' ||
          state.matchedLocation == '/signup';

      // If not logged in and trying to access protected route
      if (!isLoggedIn && !isOnAuthPage && state.matchedLocation != '/') {
        return '/login';
      }

      // If logged in and on auth page, redirect to home
      if (isLoggedIn && isOnAuthPage) {
        return '/';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: '/pet-onboarding',
        builder: (context, state) => const PetOnboardingScreen(),
      ),
      GoRoute(
        path: '/products',
        builder: (context, state) => const ProductListScreen(),
      ),
      GoRoute(
        path: '/product/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return ProductDetailScreen(productId: id);
        },
      ),
      GoRoute(
        path: '/cart',
        builder: (context, state) => const CartScreen(),
      ),
      GoRoute(
        path: '/checkout',
        builder: (context, state) => const CheckoutScreen(),
      ),
      GoRoute(
        path: '/orders',
        builder: (context, state) => const OrdersScreen(),
      ),
      GoRoute(
        path: '/order/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return OrderDetailScreen(orderId: id);
        },
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: '/pet-profile',
        builder: (context, state) => const PetProfileScreen(),
      ),
    ],
  );
}

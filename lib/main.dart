import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'config/app_theme.dart';
import 'config/routes.dart';
import 'core/utils/storage_helper.dart';
import 'data/services/api_service.dart';
import 'data/repositories/auth_repository.dart';
import 'data/repositories/pet_repository.dart';
import 'data/repositories/product_repository.dart';
import 'data/repositories/cart_repository.dart';
import 'providers/auth_provider.dart';
import 'providers/pet_provider.dart';
import 'providers/product_provider.dart';
import 'providers/cart_provider.dart';
import 'data/repositories/order_repository.dart';
import 'providers/order_provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize storage
  await StorageHelper.init();

  // Initialize API service
  final apiService = ApiService();

  runApp(MyApp(apiService: apiService));
}

class MyApp extends StatelessWidget {
  final ApiService apiService;

  const MyApp({Key? key, required this.apiService}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Repositories
        Provider<AuthRepository>(
          create: (_) => AuthRepository(apiService),
        ),
        Provider<PetRepository>(
          create: (_) => PetRepository(apiService),
        ),
        Provider<ProductRepository>(
          create: (_) => ProductRepository(apiService),
        ),
        Provider<CartRepository>(
          create: (_) => CartRepository(apiService),
        ),
        Provider<OrderRepository>(
          create: (_) => OrderRepository(apiService),
        ),
        ChangeNotifierProvider<OrderProvider>(
          create: (context) => OrderProvider(
            context.read<OrderRepository>(),
          ),
        ),


        // Providers
        ChangeNotifierProvider<AuthProvider>(
          create: (context) => AuthProvider(
            context.read<AuthRepository>(),
          )..checkAuthStatus(),
        ),
        ChangeNotifierProvider<PetProvider>(
          create: (context) => PetProvider(
            context.read<PetRepository>(),
          ),
        ),
        ChangeNotifierProvider<ProductProvider>(
          create: (context) => ProductProvider(
            context.read<ProductRepository>(),
          )..fetchFeaturedProducts(),
        ),
        ChangeNotifierProvider<CartProvider>(
          create: (context) => CartProvider(
            context.read<CartRepository>(),
          ),
        ),
      ],
      child: MaterialApp.router(
        title: 'CURAA',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        routerConfig: AppRouter.router,
      ),
    );
  }
}

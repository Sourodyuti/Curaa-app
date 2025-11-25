import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/router/app_router.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'CURAA Pet Care',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2E7D32), // Primary Green from your CSS
          primary: const Color(0xFF2E7D32),
          secondary: const Color(0xFFF9A825), // Accent Yellow
        ),
        useMaterial3: true,
        textTheme: GoogleFonts.interTextTheme(), // Matches your Inter font
      ),
      routerConfig: router,
    );
  }
}
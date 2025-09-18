// main.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

// Importera mina sidor och temat
import 'page1.dart';
import 'page2.dart';
import 'ThemeProvider.dart';

/// Startpunkten för applikationen.
/// Den sätter upp "Provider"-paketet för att hantera tematillståndet
/// och ger tillgång till det i hela appen.
void main() => runApp(
  ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    child: const MyApp(),
  ),
);

/// Router-konfigurationen för navigering.
/// Den definierar sökvägar (routes) för varje sida i appen
/// med hjälp av "go_router"-paketet.
final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const Page1();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'page2',
          builder: (BuildContext context, GoRouterState state) {
            return const Page2();
          },
        ),
      ],
    ),
  ],
);

/// Huvudwidgeten som bygger upp appens struktur.
/// Den konfigurerar det övergripande temat och kopplar det till routern
/// för att hantera navigeringen.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Får tillgång till ThemeProvider-instansen för att kunna
    // läsa av det aktuella temat (mörkt eller ljust).
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp.router(
      routerConfig: _router,
      title: 'Sol & Måne App',
      themeMode: themeProvider.themeMode, // Sätter temat baserat på providerns tillstånd
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple, brightness: Brightness.dark),
      ),
    );
  }
}
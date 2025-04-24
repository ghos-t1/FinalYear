import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// Import all screen modules
import 'package:final_year_project/auth_screen.dart';
import 'package:final_year_project/home_page.dart';
import 'package:final_year_project/splash_screen.dart';
import 'package:final_year_project/bookings_screen.dart';
import 'package:final_year_project/profile_screen.dart';
import 'package:final_year_project/help_screen.dart';
import 'package:final_year_project/settings_screen.dart';
import 'package:final_year_project/chat_support_screen.dart';
import 'package:final_year_project/providers/booking_provider.dart';
import 'package:final_year_project/providers/chat_provider.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';



// Entry point of the application
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BookingProvider()),
        ChangeNotifierProvider(create: (_) => ChatProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

// Root widget that sets up the application structure
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Start with the splash screen for onboarding
      initialRoute: '/',
      // Define named routes for navigation
      routes: {
        '/': (context) => const SplashScreen(),
        '/auth': (context) => const AuthScreen(),
        '/home': (context) => const HomePage(),
        '/bookings': (context) => const BookingsScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/help': (context) => const HelpScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/chat': (context) => const ChatSupportScreen(),
      },
    );
  }
}

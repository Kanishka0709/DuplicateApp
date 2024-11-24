import 'package:flutter/material.dart';
import 'dart:async'; // For Timer functionality
import 'navigation_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/foundation.dart' show kIsWeb;


Future<void> main() async {
  await dotenv.load(fileName: "assets/.env");
  runApp(RailwayNavigationApp());
}

Future<void> loadEnvFile() async {
  if (kIsWeb) {
    await dotenv.load(fileName: "assets/.env");
  } else {
    await dotenv.load(fileName: ".env");
  }
}

class RailwayNavigationApp extends StatelessWidget {
  const RailwayNavigationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Railway Navigation',
      theme: ThemeData(
        brightness: Brightness.dark,
        cardColor: const Color.fromARGB(255, 70, 3, 255),
        fontFamily: 'CourierPrime',
      ),
      home: const SplashScreen(), // Set SplashScreen as the home
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );

    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const NavigationMainPage()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 255, 255, 255),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ScaleTransition(
                scale: _animation,
                child: const Text(
                  'PRAVAAH',
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 20, 199),
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'CourierPrime',
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Welcome to Railway Navigator',
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 20, 199),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'CourierPrime',
                ),
              ),
              const SizedBox(height: 30),
              const CircularProgressIndicator(
                color: Color.fromARGB(255, 70, 3, 255),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Main Page with Navigation Bar

// Add the rest of your pages such as ChatbotPage, EmergencyContactsPage, EmergencyEmailsPage,
// WelcomePage, SearchPage, ProfilePage, LoginPage, and SignUpPage below.




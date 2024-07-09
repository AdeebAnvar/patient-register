import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:novindus_mechine_test/logic/splah_screen_logic.dart';
import 'package:novindus_mechine_test/presentation/screens/auth/login.dart';
import 'package:novindus_mechine_test/presentation/screens/home_screen.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashScreenProvider splashScreenProvider = SplashScreenProvider();
  @override
  void initState() {
    splashScreenProvider = Provider.of<SplashScreenProvider>(context, listen: false);
    initialize();
    super.initState();
  }

  initialize() {
    splashScreenProvider.initializeApp().then((v) {
      if (!splashScreenProvider.isInitialized) {
        context.goNamed(LoginScreen.route);
      } else {
        context.goNamed(HomeScreen.route);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(
              'assets/images/png/splsh_img.png',
            ),
          ),
        ),
      ),
    );
  }
}

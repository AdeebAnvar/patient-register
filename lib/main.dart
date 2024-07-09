import 'package:flutter/material.dart';
import 'package:novindus_mechine_test/constatnts/app_colors.dart';
import 'package:novindus_mechine_test/logic/login_screen_logic.dart';
import 'package:novindus_mechine_test/logic/splah_screen_logic.dart';
import 'package:provider/provider.dart';
import 'presentation/routes/app_router.dart' as route;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SplashScreenProvider()),
        ChangeNotifierProvider(create: (context) => LoginScreenProvider()),
      ],
      child: MaterialApp.router(
        routerConfig: route.router,
        title: 'Novindus Tech',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Color(0xFFF9F9F9),
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
          useMaterial3: true,
        ),
      ),
    );
  }
}

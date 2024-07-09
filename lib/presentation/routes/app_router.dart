import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:novindus_mechine_test/presentation/screens/auth/login.dart';
import 'package:novindus_mechine_test/presentation/screens/home_screen.dart';
import 'package:novindus_mechine_test/presentation/screens/register_patient.dart';
import 'package:novindus_mechine_test/presentation/screens/splash_screen.dart';

GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: '/',
      pageBuilder: (context, state) => getCustomTransition(
        state,
        SplashScreen(),
      ),
    ),
    GoRoute(
      path: LoginScreen.route,
      name: LoginScreen.route,
      pageBuilder: (context, state) => getCustomTransition(
        state,
        LoginScreen(),
      ),
    ),
    GoRoute(
      path: HomeScreen.route,
      name: HomeScreen.route,
      pageBuilder: (context, state) => getCustomTransition(
        state,
        HomeScreen(),
      ),
    ),
    GoRoute(
      path: RegisterPatient.route,
      name: RegisterPatient.route,
      pageBuilder: (context, state) => getCustomTransition(
        state,
        RegisterPatient(),
      ),
    ),
  ],
);

getCustomTransition(GoRouterState state, Widget child) {
  return CustomTransitionPage<dynamic>(
    transitionDuration: const Duration(milliseconds: 400),
    key: state.pageKey,
    child: child,
    transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
      return CupertinoPageTransition(
        primaryRouteAnimation: animation,
        secondaryRouteAnimation: secondaryAnimation,
        linearTransition: true,
        child: child,
      );
    },
  );
}

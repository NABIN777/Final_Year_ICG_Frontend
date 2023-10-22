import '../../features/splash/presentation/view/splash_view.dart';

class AppRoute {
  AppRoute._();

  static const String splashRoute = '/splash';
  static const String homeRoute = '/home';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String otpRoute = '/otp';
  static const String dashRoute = '/dash';

  static getApplicationRoute() {
    return {
      splashRoute: (context) => const SplashView(),
      // loginRoute: (context) => const LoginView(),
      // homeRoute: (context) => const DashboardView(),
      // registerRoute: (context) => const RegisterView(),
      // otpRoute: (context) => const OTP(),
      // dashRoute: (context) => const DashboardView(),
    };
  }
}

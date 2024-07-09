import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:novindus_mechine_test/constatnts/app_colors.dart';
import 'package:novindus_mechine_test/constatnts/enums.dart';
import 'package:novindus_mechine_test/constatnts/jwt_authorizer.dart';
import 'package:novindus_mechine_test/constatnts/styles.dart';
import 'package:novindus_mechine_test/data/network/service_provider/login_service_provider.dart';
import 'package:novindus_mechine_test/data/network/service_provider/token_service_provider.dart';
import 'package:novindus_mechine_test/data/network/repository/login_repository.dart';
import 'package:novindus_mechine_test/data/network/repository/token_repository.dart';
import 'package:novindus_mechine_test/presentation/screens/home_screen.dart';

class LoginScreenProvider extends ChangeNotifier {
  LoginRepository loginRepository = LoginServiceProvider();
  TokenRepository tokenRepository = TokenServiceProvider();
  Future<void> login(BuildContext context, {required String userName, required String passWord}) async {
    await loadingDialogue(context);
    var res = await loginRepository.login(userName: userName, passWord: passWord);
    if (res.status == ApiResponseStatus.success) {
      final DateTime? expirationDateTime = getExpirationDateOfToken(res.data!.token.toString());
      if (expirationDateTime != null) {
        await tokenRepository.saveToken(token: res.data!.token!, expirationDateTime: expirationDateTime).then((v) {
          context.pop();
          context.goNamed(HomeScreen.route);
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            res.message!,
            style: AppStyles.getMediumStyle(fontSize: 16, fontColor: Colors.white),
          ),
          backgroundColor: AppColors.primary,
        ),
      );
      context.pop();
    }
  }

  loadingDialogue(BuildContext c) {
    showDialog(
        barrierDismissible: false,
        barrierColor: Colors.black26,
        context: c,
        builder: (ctx) {
          return AlertDialog(
            backgroundColor: Colors.transparent,
            content: SpinKitFadingCircle(
              color: AppColors.primary,
              size: 50.0,
            ),
          );
        });
  }
}

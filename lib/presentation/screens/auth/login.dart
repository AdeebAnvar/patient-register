import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:novindus_mechine_test/constatnts/styles.dart';
import 'package:novindus_mechine_test/logic/login_screen_logic.dart';
import 'package:novindus_mechine_test/presentation/screens/home_screen.dart';
import 'package:novindus_mechine_test/widgets/textfield_with_label.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  static String route = '/login';
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey();

    TextEditingController emailController = TextEditingController();
    TextEditingController passWordController = TextEditingController();
    return Consumer<LoginScreenProvider>(builder: (context, np, child) {
      return Scaffold(
        body: CustomScrollView(
          slivers: [
            const SliverAppBar(
              toolbarHeight: 217,
              stretch: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: [
                    Image(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/png/login_cover.png'),
                    ),
                    Align(
                      child: Image(
                        height: 84,
                        width: 80,
                        image: AssetImage('assets/images/png/logo.png'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Login or register to book your appointments',
                          style: AppStyles.getSemiBoldStyle(fontSize: 24),
                        ),
                        const SizedBox(height: 30),
                        Form(
                            key: formKey,
                            child: Column(
                              children: [
                                TextFieldWithLabel(
                                  controller: emailController,
                                  hint: 'Enter your email',
                                  label: 'Email',
                                  validator: (v) {
                                    if (v!.length <= 3) {
                                      return 'Enter a valid email';
                                    }
                                  },
                                ),
                                SizedBox(height: 26),
                                TextFieldWithLabel(
                                  obscureText: true,
                                  controller: passWordController,
                                  hint: 'Enter password',
                                  label: 'Password',
                                  validator: (v) {
                                    if (v!.length <= 3) {
                                      return 'Enter a valid password';
                                    }
                                  },
                                ),
                              ],
                            )),
                        SizedBox(height: 80),
                        TextButton(
                          onPressed: () {
                            if (!formKey.currentState!.validate()) {
                              return;
                            }
                            np.login(context, userName: emailController.text, passWord: passWordController.text);
                          },
                          style: AppStyles.filledButton.copyWith(
                            padding: WidgetStatePropertyAll(EdgeInsets.all(10)),
                            fixedSize: WidgetStatePropertyAll(
                              Size(MediaQuery.sizeOf(context).width, 50),
                            ),
                          ),
                          child: Text('Login'),
                        ),
                        SizedBox(height: 80),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: RichText(
                            text: TextSpan(
                              style: AppStyles.getLightStyle(fontSize: 12),
                              text: 'By creating or logging into an account you are agreeing with our',
                              children: [
                                TextSpan(
                                  text: 'Terms and Conditions and Privacy Policy.',
                                  style: AppStyles.getBoldStyle(fontSize: 12, fontColor: Colors.blue.shade700),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}

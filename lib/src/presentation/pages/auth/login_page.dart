import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list_app_bts/src/data/auth_datasource.dart';

import 'package:todo_list_app_bts/src/presentation/misc/constant.dart';
import 'package:todo_list_app_bts/src/presentation/misc/methods.dart';
import 'package:todo_list_app_bts/src/presentation/misc/navigator_helper.dart';
import 'package:todo_list_app_bts/src/presentation/misc/style.dart';
import 'package:todo_list_app_bts/src/presentation/misc/validator.dart';
import 'package:todo_list_app_bts/src/presentation/pages/auth/register_page.dart';
import 'package:todo_list_app_bts/src/presentation/pages/home/home_page.dart';
import 'package:todo_list_app_bts/src/presentation/widgets/button.dart';
import 'package:todo_list_app_bts/src/presentation/widgets/textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

bool isObscure = true;
bool isLoadingLogin = false;

TextEditingController usenameLoginController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class _LoginPageState extends State<LoginPage> {
  final AuthDatasource _authDataSource = AuthDatasource();

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () {
      checkUser();
      setState(() {});
    });
    super.initState();
  }

  Future<void> checkUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    if (token != null) {
      setState(() {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: ListView(
        children: [
          verticalSpace(50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Login',
                  style: blackSemiBoldTextStyle.copyWith(fontSize: 20),
                ),
                verticalSpace(50),
                KTextField(
                  label: 'Username',
                  maxLines: 1,
                  minLines: 1,
                  controller: usenameLoginController,
                  borderColor: Colors.black,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: Validator.emailValidator.call,
                  placeholder: 'Enter your email',
                ),
                verticalSpace(10),
                KTextField(
                  label: 'Password',
                  maxLines: 1,
                  minLines: 1,
                  borderColor: Colors.black,
                  obscure: isObscure,
                  controller: passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.next,
                  validator: Validator.emailValidator.call,
                  placeholder: 'Enter your password',
                  suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        isObscure = !isObscure;
                      });
                    },
                    child: isObscure
                        ? const Icon(Icons.visibility_off)
                        : const Icon(Icons.visibility),
                  ),
                ),
                verticalSpace(30),
                Button(
                  isLoading: isLoadingLogin,
                  isDisabled: isLoadingLogin,
                  onPressed: () async {
                    setState(() {
                      isLoadingLogin = true;
                    });
                    var result = await _authDataSource.login(
                      username: usenameLoginController.text,
                      password: passwordController.text,
                    );

                    result.fold(
                      (l) {
                        AnimatedSnackBar.material(l,
                                type: AnimatedSnackBarType.error)
                            .show(context);
                        setState(() {
                          isLoadingLogin = false;
                        });
                      },
                      (r) {
                        AnimatedSnackBar.material('Success register account',
                                type: AnimatedSnackBarType.success)
                            .show(context);
                        setState(() {
                          isLoadingLogin = false;
                        });
                        NavigatorHelper.pushAndRemoveUntil(
                          context,
                          const HomePage(),
                          (route) => false,
                        );
                      },
                    );
                  },
                  child: Center(
                    child: Text(
                      'Login',
                      style: whiteMediumTextStyle.copyWith(fontSize: 14),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Forgot Password ?',
                      style: blackMediumTextStyle.copyWith(fontSize: 14),
                    ),
                  ),
                ),
                verticalSpace(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account yet? ",
                      style: blackMediumTextStyle.copyWith(fontSize: 14),
                    ),
                    InkWell(
                      onTap: () {
                        NavigatorHelper.push(context, const RegisterPage());
                      },
                      child: Text(
                        "Register now",
                        style: blackMediumTextStyle.copyWith(
                          fontSize: 14,
                          color: saffron,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

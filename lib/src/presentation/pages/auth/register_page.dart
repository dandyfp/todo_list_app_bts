import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_app_bts/src/data/auth_datasource.dart';
import 'package:todo_list_app_bts/src/presentation/misc/constant.dart';
import 'package:todo_list_app_bts/src/presentation/misc/methods.dart';
import 'package:todo_list_app_bts/src/presentation/misc/style.dart';
import 'package:todo_list_app_bts/src/presentation/misc/validator.dart';
import 'package:todo_list_app_bts/src/presentation/widgets/button.dart';
import 'package:todo_list_app_bts/src/presentation/widgets/textfield.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

TextEditingController nameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

bool isObscure = true;
bool isLoadingRegister = false;

AuthDatasource _authDataSource = AuthDatasource();

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: whiteColor,
        elevation: 0.0,
      ),
      backgroundColor: whiteColor,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              children: [
                verticalSpace(100),
                Text(
                  'Register',
                  style: blackSemiBoldTextStyle.copyWith(fontSize: 20),
                ),
                verticalSpace(30),
                KTextField(
                  label: 'Username',
                  maxLines: 1,
                  minLines: 1,
                  controller: nameController,
                  borderColor: Colors.black,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  validator: Validator.emailValidator.call,
                  placeholder: 'Enter your name',
                ),
                verticalSpace(10),
                KTextField(
                  label: 'Email',
                  maxLines: 1,
                  minLines: 1,
                  controller: emailController,
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
                  isLoading: isLoadingRegister,
                  isDisabled: isLoadingRegister,
                  onPressed: () async {
                    setState(() {
                      isLoadingRegister = true;
                    });
                    var result = await _authDataSource.register(
                      email: emailController.text,
                      password: passwordController.text,
                      username: nameController.text,
                    );

                    result.fold(
                      (l) {
                        AnimatedSnackBar.material(l,
                                type: AnimatedSnackBarType.error)
                            .show(context);
                        setState(() {
                          isLoadingRegister = false;
                        });
                      },
                      (r) {
                        nameController.clear();
                        emailController.clear();
                        passwordController.clear();
                        AnimatedSnackBar.material('Success register account',
                                type: AnimatedSnackBarType.success)
                            .show(context);
                        setState(() {
                          isLoadingRegister = false;
                        });
                      },
                    );
                  },
                  child: Center(
                    child: Text(
                      'Register',
                      style: whiteMediumTextStyle.copyWith(fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
          ),
          verticalSpace(10),
        ],
      ),
    );
  }
}

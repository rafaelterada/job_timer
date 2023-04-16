import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:job_timer/app/core/ui/asuka_snack_bar.dart';
import 'package:job_timer/app/modules/login/controller/login_controller.dart';

class LoginPage extends StatelessWidget {
  final LoginController controller;

  const LoginPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginController, LoginState>(
      listenWhen: (previous, current) => previous.status != current.status,
      bloc: controller,
      listener: (context, state) {
        if (state.status == LoginStatus.error) {
          AsukaSnackbar.warning(state.errorMessage!).show();
        }
      },
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Color(0xFFED4C5C),
              Color(0xFF5c0c14),
            ],
          )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  'assets/images/logoJT.png',
                  width: MediaQuery.of(context).size.width * .7,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .1,
              ),
              SignInButton(
                Buttons.Google,
                text: 'Sign in with Google',
                padding: const EdgeInsets.all(8),
                elevation: 5,
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
                onPressed: () {
                  controller.signIn();
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .05,
              ),
              BlocSelector<LoginController, LoginState, bool>(
                bloc: controller,
                selector: (state) => state.status == LoginStatus.loading,
                builder: (context, show) {
                  return Visibility(
                    visible: show,
                    child: const Center(
                      child: CircularProgressIndicator.adaptive(
                        backgroundColor: Colors.white,
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

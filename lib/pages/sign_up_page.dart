import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/pages/cubits/sign_up_cubit/sign_up_cubit.dart';
import 'package:chat_app/widget/custoum_sign_elveted_buttoun.dart';
import 'package:chat_app/widget/custoum_text_field.dart';
import 'package:chat_app/widget/divider.dart';
import 'package:chat_app/widget/gradient_background.dart';
import 'package:chat_app/widget/sign_buttoun.dart';
import 'package:chat_app/widget/snackbar.dart';
import 'package:chat_app/widget/social_log_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignUpPage extends StatelessWidget {
  String? email;
  String? password;
  String? userName;
  String? phoneNumber;
  bool isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey();

  SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state is SignUpLoading) {
          isLoading = true;
        } else if (state is SignUpSucsses) {
          isLoading = false;
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => ChatPage()),
            (route) => false,
          );
        } else if (state is SignUpFailure) {
          isLoading = false;
          showSnackBar(context, state.errorMessage);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Chat App'),
              flexibleSpace: GradientBackground(),
              elevation: 0.2,
              titleTextStyle: const TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
              iconTheme: const IconThemeData(color: Colors.white),
            ),

            body: Stack(
              children: [
                Positioned.fill(child: GradientBackground()),
                Center(
                  child: Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 24,
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 28,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.85),
                            borderRadius: BorderRadius.circular(28),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                blurRadius: 24,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                height: 100,
                                child: Center(
                                  child: Image.asset('assets/images/logo.png'),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                'Hi,Create an account 👋',
                                style:
                                    Theme.of(
                                      context,
                                    ).textTheme.titleLarge?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF1A237E),
                                      fontFamily: 'Poppins',
                                    ) ??
                                    const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF1A237E),
                                      fontFamily: 'Poppins',
                                      fontSize: 24,
                                    ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 18),
                              CustoumTextField(
                                labelText: 'Username',
                                prefixIcon: Icon(Icons.person),
                                keyboardType: TextInputType.name,
                                onChanged: (data) {
                                  userName = data;
                                },
                              ),
                              CustoumTextField(
                                labelText: 'Phone Number',
                                prefixIcon: Icon(Icons.phone),
                                keyboardType: TextInputType.phone,
                                onChanged: (data) {
                                  phoneNumber = data;
                                },
                              ),
                              CustoumTextField(
                                onChanged: (data) {
                                  email = data;
                                },
                                labelText: 'Email',
                                prefixIcon: Icon(Icons.mail),
                                keyboardType: TextInputType.emailAddress,
                              ),
                              CustoumTextField(
                                onChanged: (data) {
                                  password = data;
                                },
                                labelText: 'Password',
                                prefixIcon: Icon(Icons.password),
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: true,
                              ),
                              CustoumSignElvetedButtoun(
                                text: 'Sign Up',
                                onTap: () async {
                                  if (formKey.currentState!.validate()) {
                                    BlocProvider.of<SignUpCubit>(
                                      context,
                                    ).signUpUser(
                                      email: email!,
                                      password: password!,
                                    );
                                  }
                                },
                              ),

                              const SizedBox(height: 18),
                              CustoumDivider(),
                              const SizedBox(height: 18),
                              SocialLogIn(),
                              const SizedBox(height: 24),
                              SignButtoun(
                                title: 'already have an account ? ',
                                subTitle: 'Sign In',
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Future<void> signUpUser() async {
  //   UserCredential user = await FirebaseAuth.instance
  //       .createUserWithEmailAndPassword(email: email!, password: password!);
  // }
}

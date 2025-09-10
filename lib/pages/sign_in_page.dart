import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/pages/sign_up_page.dart';
import 'package:chat_app/widget/custoum_sign_elveted_buttoun.dart';
import 'package:chat_app/widget/custoum_text_field.dart';
import 'package:chat_app/widget/divider.dart';
import 'package:chat_app/widget/forget_password.dart';
import 'package:chat_app/widget/gradient_background.dart';
import 'package:chat_app/widget/sign_buttoun.dart';
import 'package:chat_app/widget/snackbar.dart';
import 'package:chat_app/widget/social_log_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  String? email;
  String? password;
  bool isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
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
                            'Hi, Welcome Back! 👋',
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
                          ForgetPassword(),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 0,
                              vertical: 8,
                            ),
                            child: Builder(
                              builder: (scaffoldContext) =>
                                  CustoumSignElvetedButtoun(
                                    text: 'Sign In',
                                    onTap: () async {
                                      if (formKey.currentState!.validate()) {
                                        isLoading = true;
                                        setState(() {});

                                        try {
                                          await signInUser();
                                          showSnackBar(
                                            scaffoldContext,
                                            'Sucssessfully signed in $email',
                                          );
                                          Navigator.of(
                                            context,
                                          ).pushAndRemoveUntil(
                                            MaterialPageRoute(
                                              builder: (context) => ChatPage(),
                                            ),
                                            (route) => false,
                                          );
                                        } on FirebaseAuthException catch (e) {
                                          if (e.code == 'user-not-found') {
                                            showSnackBar(
                                              scaffoldContext,
                                              'No user found for that email.',
                                            );
                                          } else if (e.code ==
                                              'wrong-password') {
                                            showSnackBar(
                                              scaffoldContext,
                                              'Wrong password provided for that user.',
                                            );
                                          }
                                        } catch (e) {
                                          showSnackBar(
                                            scaffoldContext,
                                            e.toString(),
                                          );
                                        }
                                        isLoading = false;
                                        setState(() {});
                                      } else {}
                                    },
                                  ),
                            ),
                          ),
                          const SizedBox(height: 18),
                          CustoumDivider(),
                          const SizedBox(height: 18),
                          SocialLogIn(),
                          const SizedBox(height: 24),
                          SignButtoun(
                            title: 'Don’t have an account ? ',
                            subTitle: 'Sign Up',
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignUpPage(),
                                ),
                              );
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
  }

  Future<void> signInUser() async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}

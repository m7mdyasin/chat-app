import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}

class SocialLogIn extends StatelessWidget {
  const SocialLogIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton.icon(
          onPressed: () async {
            try {
              final userCredential = await signInWithGoogle();
              if (userCredential.user != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'مرحبًا ${userCredential.user!.displayName ?? ''}',
                    ),
                  ),
                );
                // يمكنك هنا التوجيه للصفحة الرئيسية أو صفحة الدردشة
              }
            } catch (e) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('فشل تسجيل الدخول بجوجل')));
            }
          },
          icon: Image.asset('assets/images/google.png', height: 24, width: 24),
          label: const Text(
            'Google',
            style: TextStyle(
              color: Colors.black87,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: Colors.grey),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          ),
        ),
        const SizedBox(width: 18),
        ElevatedButton.icon(
          onPressed: () {},
          icon: Image.asset(
            'assets/images/facebook.png',
            height: 24,
            width: 24,
          ),
          label: const Text(
            'Facebook',
            style: TextStyle(
              color: Color(0xFF1877F3),
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: Color(0xFF1877F3)),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          ),
        ),
      ],
    );
  }
}

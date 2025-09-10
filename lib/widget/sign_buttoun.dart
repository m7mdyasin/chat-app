import 'package:flutter/material.dart';

class SignButtoun extends StatelessWidget {
  const SignButtoun({
    super.key,
    required this.title,
    required this.subTitle,
    required this.onTap,
  });

  final String title;
  final String subTitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'Poppins',
            color: Colors.black54,
            fontWeight: FontWeight.w500,
          ),
        ),
        GestureDetector(
          onTap: onTap, // ✅ لا تستدعي الدالة هنا
          child: Text(
            subTitle,
            style: const TextStyle(
              fontFamily: 'Poppins',
              color: Color(0xFF1A237E),
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}

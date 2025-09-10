import 'package:flutter/material.dart';

class CustoumDivider extends StatelessWidget {
  const CustoumDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Divider(
            thickness: 1.2,
            indent: 30,
            endIndent: 10,
            color: Colors.grey[400],
          ),
        ),
        const Text(
          'or with',
          style: TextStyle(
            color: Colors.grey,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
        ),
        Expanded(
          child: Divider(
            thickness: 1.2,
            indent: 10,
            endIndent: 30,
            color: Colors.grey[400],
          ),
        ),
      ],
    );
  }
}

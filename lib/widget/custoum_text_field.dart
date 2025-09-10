import 'package:flutter/material.dart';

class CustoumTextField extends StatefulWidget {
  const CustoumTextField({
    super.key,
    required this.labelText,
    required this.prefixIcon,
    this.onChanged,
    this.keyboardType,
    this.obscureText,
  });
  final String labelText;
  final Widget prefixIcon;
  final Function(String)? onChanged;
  final bool? obscureText;
  final TextInputType? keyboardType;

  @override
  State<CustoumTextField> createState() => _CustoumTextFieldState();
}

class _CustoumTextFieldState extends State<CustoumTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, left: 20, right: 20),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'This field cannot be empty';
          }
          return null;
        },
        obscureText: _obscureText,
        onChanged: widget.onChanged,
        keyboardType: widget.keyboardType ?? TextInputType.text,
        decoration: InputDecoration(
          prefixIcon: widget.prefixIcon,
          labelText: widget.labelText,
          labelStyle: const TextStyle(
            color: Color(0xFF1A237E),
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
          filled: false,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFF1A237E), width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFF1A237E), width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 18,
            horizontal: 20,
          ),
          // زر إظهار/إخفاء الباسورد
          suffixIcon: (widget.obscureText == true)
              ? IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: Color(0xFF1A237E),
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                )
              : null,
        ),
        cursorColor: Color(0xFF1A237E),
      ),
    );
  }
}

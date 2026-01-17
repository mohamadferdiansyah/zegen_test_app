import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zegen_test_app/app/utils/app_colors.dart';

class CustomInput extends StatefulWidget {
  final String hintText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixTap;
  final Color? backgroundColor;
  final double? hintSize;
  final bool isPassword;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final Function(String)? onChanged;
  final ValueChanged<String>? onSubmitted;

  const CustomInput({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixTap,
    this.isPassword = false,
    this.backgroundColor = AppColors.white,
    this.hintSize = 14,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.onSubmitted,
  });

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextField(
        controller: widget.controller,
        obscureText: _obscureText,
        keyboardType: widget.keyboardType,
        onChanged: widget.onChanged,
        onSubmitted: widget.onSubmitted,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: AppColors.grey,
            fontSize: widget.hintSize,
          ),

          prefixIcon: widget.prefixIcon != null
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Icon(
                    widget.prefixIcon,
                    color: AppColors.primary,
                    size: 20,
                  ),
                )
              : null,
          prefixIconConstraints: const BoxConstraints(minWidth: 40),

          suffixIcon: widget.isPassword
              ? Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    icon: FaIcon(
                      _obscureText
                          ? FontAwesomeIcons.solidEyeSlash
                          : FontAwesomeIcons.solidEye,
                      color: AppColors.grey,
                      size: 18,
                    ),
                  ),
                )
              : (widget.suffixIcon != null
                    ? IconButton(
                        onPressed: widget.onSuffixTap,
                        icon: FaIcon(
                          widget.suffixIcon,
                          color: AppColors.grey,
                          size: 18,
                        ),
                      )
                    : null),

          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 18,
            horizontal: 20,
          ),
        ),
      ),
    );
  }
}

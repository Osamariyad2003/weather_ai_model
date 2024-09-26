import 'package:flutter/material.dart';
import 'package:weather_tennis_ai_model/core/utilies/main_colors.dart';

class MyFormField extends StatelessWidget {
  final double radius;
  final String? title;
  final bool? readOnly;
  final String hint;
  final int? maxLines;
  final TextStyle? hintStyle;
  final TextInputType type;
  final VoidCallback? suffixIconPressed;
  final IconData? suffixIcon;
  final Widget? widget;
  final TextEditingController? controller;
  final dynamic validation;
  final bool isPassword;
  final   Color? fill;

  const MyFormField(
      {super.key,
        this.isPassword = false,
        this.radius = 15,
        required this.type,
        required this.hint,
        required this.maxLines,
        this.suffixIcon,
        this.readOnly=false,
        this.suffixIconPressed,
        this.widget,
        this.controller,
        this.hintStyle,
        this.title="",
         this.validation,
        this.fill,
        });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title!,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),

          ),
          child: TextFormField(
            style: TextStyle(color: Colors.white),
            readOnly: readOnly!,
            obscureText: isPassword,
            controller: controller,
            keyboardType: type,
            maxLines: maxLines,
            // Allow for dynamic expansion
            decoration: InputDecoration(
              filled: true,

              fillColor:fill ,
              helperStyle: TextStyle(color: Colors.white),
              focusColor: Colors.white,
              hintText: hint,
              hintStyle: hintStyle,
              border:  OutlineInputBorder(
                borderRadius: BorderRadius?.circular(20),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:  BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(15),


              ),
              suffixIcon: suffixIcon != null
                  ? IconButton(
                onPressed: () {
                  suffixIconPressed!();
                },
                icon: Icon(
                  suffixIcon,
                  color: Colors.blue,
                ),
              )
                  : null,
            ),
            validator: validation,
          ),
        ),
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:weather_tennis_ai_model/core/utilies/main_colors.dart';

class PublicButton extends StatelessWidget {
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback function;
  final double width;
  final double height;
  final double borderRadius;
  final String text;

  const PublicButton({
    super.key,
    required this.backgroundColor,
    required this.function,
    this.width = double.infinity,
    required this.text,
    this.borderRadius = 5,
    this.height = 52,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: MaterialButton(
        height: height,
        color: backgroundColor,
        onPressed: function,
        child: Text(
          text,
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }
}


Widget defaultTextButton({
  required  function,
  required String text,
  required Color color,

}) =>
    TextButton(
      onPressed: function,
      child: Text(
        text.toUpperCase(),
        style: TextStyle(color:color ),
      ),
    );


Widget defaultTextField({
  required TextEditingController controller,
  required TextInputType type,
  onSubmit,
  onChange,
  onTap,
  bool isPassword = false,
  required  validate,
  required String label,
  IconData? prefix,
  IconData? suffix,
  VoidCallback? suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        hintText: label,



        hintStyle: TextStyle(color: MainColors.mainColor.withOpacity(0.6)),
        filled: true,
        prefixIcon: Icon(
            prefix,
            color: MainColors.mainColor
        ),
        suffixIcon: suffix != null
            ? IconButton(
          onPressed: suffixPressed,
          icon: Icon(
            suffix,
          ),
        )
            : null,
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: MainColors.mainColor,width: 1),
        ),
        fillColor: Colors.white,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: MainColors.mainColor,width: 2),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: MainColors.mainColor,width: 2),
        ),
      ),
    );
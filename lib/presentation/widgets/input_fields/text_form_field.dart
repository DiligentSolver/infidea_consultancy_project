import 'package:flutter/material.dart';
import 'package:infidea_consultancy_app/core/utils/helpers/helper_functions.dart';
import '../../../core/utils/constants/colors.dart';
import '../../../core/utils/constants/sizes.dart';
import '../../../core/utils/text_styles/text_styles.dart';

class MYInputField extends StatefulWidget {
  final TextEditingController? controller;
  final TextCapitalization textCapitalization;
  final FormFieldSetter<String>? onSaved;
  final ValueChanged<String>? onFieldSubmitted, onChanged;
  final void Function()? onTap;
  final bool isPasswordField;
  final Widget? suffixIcon, prefixIcon;
  final String? hintText, labelText;
  final TextInputType keyboardType;
  final Color? prefixIconColor, suffixIconColor;
  final FormFieldValidator<String>? validator;
  final bool readOnly, autofocus;
  final TextInputAction? textInputAction;
  final int? maxLength, maxLines;

  const MYInputField({
    super.key,
    this.prefixIcon,
    this.suffixIcon,
    this.hintText,
    this.labelText,
    this.prefixIconColor,
    this.suffixIconColor,
    this.validator,
    this.readOnly = false,
    this.onSaved,
    this.onChanged,
    this.controller,
    this.onFieldSubmitted,
    this.isPasswordField = false,
    this.autofocus = false,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.keyboardType = TextInputType.text, this.maxLength, this.maxLines, this.onTap,
  });

  @override
  State<MYInputField> createState() => _MYInputFieldState();
}

class _MYInputFieldState extends State<MYInputField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.isPasswordField ? _obscureText : false,
      validator: widget.validator,
      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon,
        prefixIconColor: widget.prefixIconColor,
        suffixIcon: widget.isPasswordField
            ? GestureDetector(
          onTap: () => setState(() => _obscureText = !_obscureText),
          child: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
        )
            : widget.suffixIcon,
        suffixIconColor: widget.suffixIconColor,
        hintText: widget.hintText,
        labelText: widget.labelText,
        counterText: ''
      ),
      cursorColor: MYAppHelperFunctions.isDarkMode(context) ? MYColors.white : Colors.black,
      textInputAction: widget.textInputAction,
      keyboardType: widget.keyboardType,
      textCapitalization: widget.textCapitalization,
      style: MYAppTextStyles.titleSmall(fontWeight: FontWeight.bold),
      cursorWidth: 3,
      cursorHeight: MySizes.titleSmall,
      cursorOpacityAnimates: true,
      autovalidateMode: AutovalidateMode.disabled,
      autofocus: widget.autofocus,
      readOnly: widget.readOnly,
      onSaved: widget.onSaved,
      onFieldSubmitted: widget.onFieldSubmitted,
      onChanged: widget.onChanged,
      maxLength: widget.maxLength,
      maxLines: widget.maxLines,
      onTap: widget.onTap,
    );
  }
}

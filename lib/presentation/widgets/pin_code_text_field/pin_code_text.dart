import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../core/utils/constants/colors.dart';
import '../../../core/utils/constants/sizes.dart';
import '../../../core/utils/text_styles/text_styles.dart';

class MYOtpField extends StatefulWidget {
  final double width;
  final int length;
  final ValueChanged<String>? onChanged;

  const MYOtpField({
    super.key,
    required this.width,
    this.length = 4, // Default OTP length
    this.onChanged,
  });

  @override
  State<MYOtpField> createState() => _MYOtpFieldState();
}

class _MYOtpFieldState extends State<MYOtpField> {
  String _otp = '';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: PinCodeTextField(
        keyboardType: TextInputType.number,
        textStyle: MYAppTextStyles.labelLarge(),
        appContext: context,
        length: widget.length,
        animationType: AnimationType.slide,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(MySizes.borderRadiusMd),
          fieldHeight: 50,
          fieldWidth: 50,
          activeColor: MYColors.secondaryLightColor,
          inactiveColor: MYColors.secondarylighterColor,
          selectedColor: MYColors.secondaryLightColor,
        ),
        onChanged: (value) {
          setState(() {
            _otp = value;
          });
          if (widget.onChanged != null) {
            widget.onChanged!(value);
          }
        },
      ),
    );
  }
}

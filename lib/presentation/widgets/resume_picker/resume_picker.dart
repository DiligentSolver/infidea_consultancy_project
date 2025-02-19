import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:infidea_consultancy_app/core/utils/constants/colors.dart';
import 'package:infidea_consultancy_app/core/utils/constants/sizes.dart';
import 'package:infidea_consultancy_app/core/utils/text_styles/text_styles.dart';
import 'package:infidea_consultancy_app/presentation/widgets/buttons/elevated_button.dart';

import '../../../core/utils/constants/texts.dart';

class ResumeUploadWidget extends StatelessWidget {
  final String? resumePath;
  final VoidCallback onPickResume;
  final VoidCallback onRemoveResume;

  const ResumeUploadWidget({
    super.key,
    required this.resumePath,
    required this.onPickResume,
    required this.onRemoveResume,
  });



  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            MYTexts.resumeLabel,
            style: MYAppTextStyles.labelLarge(),
          ),
        ),
        Container(
          padding: EdgeInsets.all(MySizes.spaceBtwItems.r),
          decoration: BoxDecoration(
            border: Border.all(color: MYColors.secondaryColor),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (resumePath != null) ...[
                Row(
                  children: [
                    const Icon(Icons.description),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        resumePath!.split('/').last,
                        style: const TextStyle(fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: onRemoveResume,
                    ),
                  ],
                ),
              ] else
                Row(
                  children: [
                    const Icon(FontAwesomeIcons.filePdf),
                    horizontalSpace(MySizes.sm.r),
                    Text(
                      MYTexts.uploadResumeButton,
                      style: MYAppTextStyles.titleMedium(),
                    ),
                    const Spacer(),
                    MYElevatedButton(
                      onPressed: onPickResume,
                      height: MySizes.xxl.r,
                      width: MySizes.xxl.r,
                      child: const Icon(FontAwesomeIcons.upload),
                    ),
                  ],
                ),
              verticalSpace(MySizes.spaceBtwItems.r),
              Text(
                MYTexts.supportedFormatsText,
                style: MYAppTextStyles.bodyMedium(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

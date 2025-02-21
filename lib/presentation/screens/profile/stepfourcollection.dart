import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:infidea_consultancy_app/core/utils/constants/colors.dart';
import 'package:infidea_consultancy_app/core/utils/constants/sizes.dart';
import 'package:infidea_consultancy_app/core/utils/helpers/bars.dart';
import 'package:infidea_consultancy_app/core/utils/text_styles/text_styles.dart';
import 'package:infidea_consultancy_app/presentation/widgets/avatar_image/circle_avatar_image.dart';
import '../../../core/utils/constants/texts.dart';
import '../../../logic/blocs/form/form_bloc.dart';
import '../../../logic/blocs/form/form_event.dart';
import '../../../logic/blocs/form/form_state.dart';
import '../../widgets/buttons/elevated_button.dart';
import '../../widgets/linear_indicator/custom_linear_indicator.dart';
import '../../widgets/resume_picker/resume_picker.dart';

class StepFourCollection extends StatefulWidget {
  const StepFourCollection({super.key});

  @override
  StepFourCollectionState createState() => StepFourCollectionState();
}

class StepFourCollectionState extends State<StepFourCollection> {
  final _formKey4 = GlobalKey<FormState>();

  Future<void> _pickResume() async {
    final formBloc = context.read<FormBloc>();
    final formState = formBloc.state;

    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'png'],
      );

      if (result != null) {
        formBloc.add(UpdateFormEvent(resumeFile: File(result.files.single.path!)));
      }
    } catch (e) {
     Bars.showCustomToast(context: context, message: MYTexts.uploadFailedResume);
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<FormBloc>().add(LoadFormData());
  }

  void _validateAndProceed() {
    final formBloc = context.read<FormBloc>();
    final formState = formBloc.state;
    if (formState.isStepFourValid()) {
      // Add your logic to handle the files
      context.read<FormBloc>().add(SubmitForm());
      Navigator.pushNamed(context, '/stepFiveCollection');
    } else {
     Bars.showCustomToast(context: context, message: 'Upload Resume & Pic');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<FormBloc,UserFormState>(
        listener: (context,formState){
          context.read<FormBloc>().add(UpdateFormEvent(imageFile: formState.imageFile));
          context.read<FormBloc>().add(UpdateFormEvent(resumeFile: formState.resumeFile));
        },
        builder:(context,formState){
          final formBloc = context.read<FormBloc>();
          return Scaffold(
          appBar: AppBar(
              title: Row(
                children: [
                  Expanded(child: CustomLinearProgressIndicator(progress: formState.calculateProgress())),
                  horizontalSpace(MySizes.spaceBtwItems.r),
                  const Text("Page: 4/5"),
                ],
              )
          ),
          bottomNavigationBar: BottomAppBar(
            child: MYElevatedButton(
              onPressed: () => _validateAndProceed(),
              child: const Text(MYTexts.next),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: MySizes.defaultSpace.r),
              child: Center(
                child: Form(
                  key: _formKey4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Profile Picture Section
                      verticalSpace(MySizes.defaultSpace.r),
                      MYEditableProfileImage(defaultImage: formState.imageFile,onImageSelected: (profileImage){
                     formBloc.add(UpdateFormEvent(imageFile: profileImage));
                      }),
                      verticalSpace(MySizes.spaceBtwItems.r),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Profile Image',
                          style: MYAppTextStyles.titleMedium(
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      verticalSpace(MySizes.spaceBtwSectionsLg.r),
                      // Resume Section
                      ResumeUploadWidget(
                        resumePath: formState.resumeFile?.path.split('/').last,
                        onPickResume: _pickResume,
                        onRemoveResume: () {
                           formBloc.add(UpdateFormEvent(resumeFile:null));
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );}
      ),
    );
  }
}

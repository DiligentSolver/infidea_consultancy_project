import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:infidea_consultancy_app/core/utils/constants/colors.dart';
import 'package:infidea_consultancy_app/core/utils/constants/sizes.dart';
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
  File? _imageFile;
  File? _resumeFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickResume() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'png'],
      );

      if (result != null) {
        setState(() {
          _resumeFile = File(result.files.single.path!);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(MYTexts.uploadFailedResume),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<FormBloc>().add(LoadFormData());
  }

  void _validateAndProceed() {
    if (_imageFile != null && _resumeFile != null) {
      // Add your logic to handle the files
      context.read<FormBloc>().add(SubmitForm());
      Navigator.pushNamed(context, '/stepFiveCollection');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(MYTexts.uploadRequiredError),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<FormBloc,UserFormState>(
        builder:(context,formState){return Scaffold(
          appBar: AppBar(
            title: CustomLinearProgressIndicator(progress: formState.calculateProgress())
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
                      MYEditableProfileImage(onImageSelected: (profileImage){
                        _imageFile=profileImage;
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
                        resumePath: _resumeFile?.path.split('/').last,
                        onPickResume: _pickResume,
                        onRemoveResume: () {
                          setState(() {
                            _resumeFile = null;
                          });
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

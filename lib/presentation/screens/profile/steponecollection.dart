import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infidea_consultancy_app/core/utils/constants/sizes.dart';
import 'package:infidea_consultancy_app/core/utils/helpers/bars.dart';
import 'package:infidea_consultancy_app/core/utils/text_styles/text_styles.dart';
import 'package:infidea_consultancy_app/presentation/widgets/input_fields/text_form_field.dart';
import '../../../core/utils/constants/texts.dart';
import '../../../logic/blocs/form/form_bloc.dart';
import '../../../logic/blocs/form/form_event.dart';
import '../../../logic/blocs/form/form_state.dart';
import '../../widgets/buttons/elevated_button.dart';
import '../../widgets/chips/choice_chip_list.dart';
import '../../widgets/dob_picker/dob_picker.dart';
import '../../widgets/linear_indicator/custom_linear_indicator.dart';

class StepOneCollection extends StatefulWidget {
  const StepOneCollection({super.key});

  @override
  StepOneCollectionState createState() => StepOneCollectionState();
}

class StepOneCollectionState extends State<StepOneCollection> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController fatherNameController;
  late TextEditingController emailController;
  late TextEditingController mobileController;

  final List<String> genderOptions = [
    MYTexts.male,
    MYTexts.female,
    MYTexts.ratherNotToSay
  ];

  final List<String> experienceOptions = [
    MYTexts.haveExperience,
    MYTexts.fresher
  ];

  @override
  void initState() {
    super.initState();
    final formState = context.read<FormBloc>().state;

    // Initialize controllers with existing values
    firstNameController = TextEditingController(text: formState.firstName ?? "");
    lastNameController = TextEditingController(text: formState.lastName ?? "");
    fatherNameController = TextEditingController(text: formState.fatherName ?? "");
    emailController = TextEditingController(text: formState.email ?? "");
    mobileController = TextEditingController(text: formState.mobile ?? "");

    // Load form data from backend or local storage
    context.read<FormBloc>().add(LoadFormData());
  }

  void _validateAndProceed(BuildContext context) {
    final formBloc = context.read<FormBloc>();
    final formState = formBloc.state;

    if (_formKey.currentState!.validate() && formState.isStepOneValid()) {
      formBloc.add(SubmitForm());
      Navigator.pushNamed(context, '/stepTwoCollection');
    } else {
      Bars.showCustomToast(context: context, message: 'All fields are required');
    }
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    fatherNameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<FormBloc, UserFormState>(
        listener: (context, formState) {

         var check =  formState.copyWith(
            firstName: formState.firstName,
            lastName: formState.lastName,
            fatherName: formState.fatherName,
            mobile: formState.mobile,
            email: formState.email,
            dob: formState.dob,
            gender: formState.gender,
            experience: formState.experience,
          );

         print(check);

          firstNameController.text = formState.firstName ?? "";
          lastNameController.text = formState.lastName ?? "";
          fatherNameController.text = formState.fatherName ?? "";
          emailController.text = formState.email ?? "";
          mobileController.text = formState.mobile ?? "";

        },
        builder: (context, formState) {
          return Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  Expanded(
                    child: CustomLinearProgressIndicator(
                      progress: formState.calculateProgress(),
                    ),
                  ),
                  horizontalSpace(MySizes.spaceBtwItems.r),
                  const Text("Page: 1/5"),
                ],
              ),
            ),
            bottomNavigationBar: BottomAppBar(
              child: MYElevatedButton(
                onPressed: () => _validateAndProceed(context),
                child: const Text(MYTexts.next),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: MySizes.defaultSpace.r),
                child: Center(
                  child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        verticalSpace(MySizes.spaceBtwItems.r),
                        Text(
                          'Personal Details (1/2)',
                          style: MYAppTextStyles.titleLarge(fontWeight: FontWeight.bold),
                        ),
                        verticalSpace(MySizes.spaceBtwSections.r),

                        Row(
                          children: [
                            Expanded(
                              child: MYInputField(
                                prefixIcon: const Icon(Icons.person),
                                hintText: MYTexts.enterFirstName,
                                maxLines: 1,
                                maxLength: 32,
                                labelText: 'First Name',
                                controller: firstNameController,
                                textInputAction: TextInputAction.next,
                                textCapitalization: TextCapitalization.words,
                                onChanged: (value) {
                                  context.read<FormBloc>().add(UpdateFormEvent(firstName: value));
                                },
                              ),
                            ),
                            horizontalSpace(MySizes.spaceBtwItemsSm.r),
                            Expanded(
                              child: MYInputField(
                                prefixIcon: const Icon(Icons.person),
                                hintText: MYTexts.enterLastName,
                                maxLines: 1,
                                maxLength: 32,
                                labelText: 'Last Name',
                                controller: lastNameController,
                                textInputAction: TextInputAction.next,
                                textCapitalization: TextCapitalization.words,
                                onChanged: (value) {
                                  context.read<FormBloc>().add(UpdateFormEvent(lastName: value));
                                },
                              ),
                            ),
                          ],
                        ),

                        verticalSpace(MySizes.spaceBtwItems.r),
                        MYInputField(
                          prefixIcon: const Icon(Icons.person_2),
                          hintText: MYTexts.fatherFirstName,
                          maxLines: 1,
                          maxLength: 32,
                          labelText: "Father's Name",
                          controller: fatherNameController,
                          textInputAction: TextInputAction.next,
                          textCapitalization: TextCapitalization.words,
                          onChanged: (value) {
                            context.read<FormBloc>().add(UpdateFormEvent(fatherName: value));
                          },
                        ),

                        verticalSpace(MySizes.spaceBtwItems.r),
                        MYInputField(
                          controller: mobileController,
                          readOnly: true,
                          prefixIcon: const Icon(Icons.phone),
                          keyboardType: TextInputType.number,
                        ),

                        verticalSpace(MySizes.spaceBtwItems.r),
                        MYInputField(
                          prefixIcon: const Icon(Icons.email),
                          hintText: MYTexts.enterEmail,
                          labelText: 'Email Address',
                          maxLines: 1,
                          maxLength: 64,
                          controller: emailController,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) {
                            context.read<FormBloc>().add(UpdateFormEvent(email: value));
                          },
                        ),

                        verticalSpace(MySizes.spaceBtwItems.r),
                        DateOfBirthPicker(
                          selectedDate: formState.dob,
                          onDateSelected: (date) {
                            context.read<FormBloc>().add(UpdateFormEvent(dob: date));
                          },
                        ),

                        verticalSpace(MySizes.spaceBtwSections.r),
                        CustomChoiceChipList(
                          question: MYTexts.gender,
                          options: genderOptions,
                          groupValue: formState.gender,
                          onChanged: (value) {
                            context.read<FormBloc>().add(UpdateFormEvent(gender: value));
                          },
                        ),

                        verticalSpace(MySizes.spaceBtwSections.r),
                        CustomChoiceChipList(
                          question: MYTexts.workExperience,
                          options: experienceOptions,
                          groupValue: formState.experience,
                          onChanged: (value) {
                            context.read<FormBloc>().add(UpdateFormEvent(experience: value));
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

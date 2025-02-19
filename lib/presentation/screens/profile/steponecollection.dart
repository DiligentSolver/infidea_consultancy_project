import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infidea_consultancy_app/core/utils/constants/sizes.dart';
import 'package:infidea_consultancy_app/core/utils/helpers/bars.dart';
import 'package:infidea_consultancy_app/core/utils/text_styles/text_styles.dart';
import 'package:infidea_consultancy_app/presentation/widgets/buttons/elevated_button.dart';
import 'package:infidea_consultancy_app/presentation/widgets/input_fields/text_form_field.dart';
import 'package:infidea_consultancy_app/presentation/widgets/linear_indicator/custom_linear_indicator.dart';
import '../../../core/utils/constants/texts.dart';
import '../../../logic/blocs/form/form_bloc.dart';
import '../../../logic/blocs/form/form_event.dart';
import '../../../logic/blocs/form/form_state.dart';
import '../../widgets/chips/choice_chip_list.dart';
import '../../widgets/dob_picker/dob_picker.dart';

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
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    fatherNameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    context.read<FormBloc>().add(LoadFormData());
    // Initialize controllers with empty values
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    fatherNameController = TextEditingController();
    emailController = TextEditingController();
  }

  void _validateAndProceed(BuildContext context) {
    final formBloc = context.read<FormBloc>();
    final formState = formBloc.state;

    if (_formKey.currentState!.validate() && formState.isStepOneValid()) {
      formBloc.add(SubmitForm());
      Navigator.pushNamed(context, '/stepTwoCollection');
    } else {
      Bars.showCustomToast(
          context: context, message: 'All fields are required');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<FormBloc, UserFormState>(
        listener: (BuildContext context, formState) {
          firstNameController.text = formState.firstName ?? "";
          lastNameController.text = formState.lastName ?? "";
          fatherNameController.text = formState.fatherName ?? "";
          emailController.text = formState.email ?? "";
        },
        builder: (BuildContext context, formState) {
          return Scaffold(
            appBar: AppBar(
              title: CustomLinearProgressIndicator(progress: formState.calculateProgress()),
            ),
            bottomNavigationBar: BottomAppBar(
              child: MYElevatedButton(
                onPressed: () => _validateAndProceed(context),
                child: const Text(MYTexts.next),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: MySizes.defaultSpace.r),
                child: Center(
                  child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        verticalSpace(MySizes.spaceBtwItems.r),
                        Text(
                          'Personal Details',
                          style: MYAppTextStyles.titleLarge(
                              fontWeight: FontWeight.bold),
                        ),
                        verticalSpace(MySizes.spaceBtwItems.r),
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
                                  context.read<FormBloc>().add(
                                        UpdateFormEvent(firstName: value),
                                      );
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
                                  context.read<FormBloc>().add(
                                        UpdateFormEvent(lastName: value),
                                      );
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
                            context.read<FormBloc>().add(
                                  UpdateFormEvent(fatherName: value),
                                );
                          },
                        ),
                        verticalSpace(MySizes.spaceBtwItems.r),
                        MYInputField(
                          controller:
                              TextEditingController(text: formState.mobile),
                          readOnly: true,
                          prefixIcon: const Icon(Icons.phone),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            formState.copyWith(mobile: value);
                          },
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
                            context.read<FormBloc>().add(
                                  UpdateFormEvent(email: value),
                                );
                          },
                        ),
                        verticalSpace(MySizes.spaceBtwItems.r),
                        BlocBuilder<FormBloc, UserFormState>(
                            builder: (context, formState) {
                          return DateOfBirthPicker(
                            selectedDate: formState.dob,
                            onDateSelected: (date) {
                              context.read<FormBloc>().add(
                                    UpdateFormEvent(dob: date),
                                  );
                            },
                          );
                        }),
                        verticalSpace(MySizes.spaceBtwSections.r),
                        BlocBuilder<FormBloc, UserFormState>(
                          builder: (context, formState) {
                            return CustomChoiceChipList(
                              question: MYTexts.gender,
                              options: genderOptions,
                              groupValue: formState.gender,
                              onChanged: (value) {
                                context
                                    .read<FormBloc>()
                                    .add(UpdateFormEvent(gender: value));
                              },
                            );
                          },
                        ),
                        verticalSpace(MySizes.spaceBtwSections.r),
                        BlocBuilder<FormBloc, UserFormState>(
                          builder: (context, formState) {
                            return CustomChoiceChipList(
                                question: MYTexts.workExperience,
                                options: experienceOptions,
                                groupValue: formState.experience,
                                onChanged: (value) {
                                  context
                                      .read<FormBloc>()
                                      .add(UpdateFormEvent(experience: value));
                                });
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

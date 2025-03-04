import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/widgets/dob_picker.dart';
import '../../core/widgets/multi_custom_dropdown.dart';
import '../../core/widgets/question_input.dart';
import '../../core/widgets/custom_radio_button.dart';

class FormScreen1 extends StatefulWidget {
  const FormScreen1({super.key});

  @override
  _FormScreen1State createState() => _FormScreen1State();
}

class _FormScreen1State extends State<FormScreen1> {
  final _formKey = GlobalKey<FormState>(); // Key for Form Validation
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController fatherFirstNameController =
      TextEditingController();
  final TextEditingController fatherLastNameController =
      TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController yearsOfExperienceController =
      TextEditingController();
  final TextEditingController monthsOfExperienceController =
      TextEditingController();

  final List<String> experienceYears = [
    "0","1", "2", "3", "4", "5", "6", "7", "8", "9", "11", "12",
    "13", "14", "15", "16", "17", "18", "19", "20", "21", "22",
    "23", "24", "25"
  ];
  final List<String> experienceMonths = [
    "0","1", "2", "3", "4", "5", "6", "7", "8", "9", "11"
  ];

  DateTime? selectedDOB;
  String? selectedGender;
  String? selectedExperience;
  String? yearsExperience;
  String? monthsExperience;
  final List<String> genderOptions = [AppStrings.male, AppStrings.female];

  final List<String> experienceOptions = [
    AppStrings.haveExperience,
    AppStrings.fresher
  ];

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    fatherFirstNameController.dispose();
    fatherLastNameController.dispose();
    emailController.dispose();
    yearsOfExperienceController.dispose();
    monthsOfExperienceController.dispose();
    super.dispose();
  }

  void _validateAndProceed() {
    if (_formKey.currentState!.validate() &&
        selectedDOB != null &&
        selectedGender != null &&
        selectedExperience != null) {
      Navigator.pushNamed(context, '/formScreen2');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(AppStrings.fillAllFieldsError),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.formExample)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                children: [
                  Expanded(
                    child: QuestionInput(
                      question: AppStrings.firstName,
                      hint: AppStrings.enterFirstName,
                      controller: firstNameController,
                      validator: (value) =>
                          value!.isEmpty ? AppStrings.nameRequired : null,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: QuestionInput(
                      question: AppStrings.lastName,
                      hint: AppStrings.enterLastName,
                      controller: lastNameController,
                      validator: (value) =>
                          value!.isEmpty ? AppStrings.lastNameRequired : null,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: QuestionInput(
                      question: AppStrings.fatherFirstName,
                      hint: AppStrings.enterFatherFirstName,
                      controller: fatherFirstNameController,
                      validator: (value) =>
                          value!.isEmpty ? AppStrings.fatherNameRequired : null,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: QuestionInput(
                      question: AppStrings.fatherLastName,
                      hint: AppStrings.enterFatherLastName,
                      controller: fatherLastNameController,
                      validator: (value) => value!.isEmpty
                          ? AppStrings.fatherLastNameRequired
                          : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              QuestionInput(
                question: 'What is your email?',
                hint: 'Enter your email address',
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) =>
                    value!.contains('@') ? null : AppStrings.invalidEmail,
              ),
              const SizedBox(height: 20),
              const Text(AppStrings.gender,
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Wrap(
                spacing: 10,
                children: genderOptions.map((option) {
                  return CustomRadioButton<String>(
                    label: option,
                    value: option,
                    groupValue: selectedGender,
                    onChanged: (value) {
                      setState(() {
                        selectedGender = value;
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              DateOfBirthPicker(
                label: AppStrings.selectDateOfBirth,
                selectedDate: selectedDOB,
                onDateSelected: (date) {
                  setState(() {
                    selectedDOB = date;
                  });
                },
              ),
              const SizedBox(height: 20),
              const Text(AppStrings.workExperience,
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Wrap(
                spacing: 10,
                children: experienceOptions.map((option) {
                  return CustomRadioButton<String>(
                    label: option,
                    value: option,
                    groupValue: selectedExperience,
                    onChanged: (value) {
                      setState(() {
                        selectedExperience = value;
                      });
                    },
                  );
                }).toList(),
              ),
              if (selectedExperience == AppStrings.haveExperience) ...[
                const SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start, // Prevents overlap issues
                  children: [
                    Expanded(
                      child: MultiCustomDropdown(
                        label: AppStrings.experienceYears,
                        items: experienceYears,
                        selectedItemSingle: yearsExperience,
                        onSingleSelectionChanged: (selected) {
                          setState(() {
                            yearsExperience = selected;
                          });
                        },
                        maxSelection: 1,
                        isMultiSelect: false,
                      ),
                    ),
                    const SizedBox(width: 10), // Ensures proper spacing
                    Expanded(
                      child: MultiCustomDropdown(
                        label: AppStrings.experienceMonths,
                        items: experienceMonths,
                        selectedItemSingle: monthsExperience,
                        onSingleSelectionChanged: (selected) {
                          setState(() {
                            monthsExperience = selected;
                          });
                        },
                        maxSelection: 1,
                        isMultiSelect: false,
                      ),
                    ),
                  ],
                )

              ],
                const SizedBox(height: 20),
                Center(
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.secondary,
                        foregroundColor: AppColors.background,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: _validateAndProceed,
                      child: const Text(
                        AppStrings.next,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
            ]),
          ),
        ),
      ),
    );
  }
}
// Expanded(
//   child: QuestionInput(
//     question: 'Years of Experience',
//     hint: 'Enter years of experience',
//     controller: yearsOfExperienceController,
//     keyboardType: TextInputType.number,
//     validator: (value) {
//       if (value!.isEmpty) {
//         return 'Please enter years of experience';
//       }
//       if (int.tryParse(value) == null) {
//         return 'Enter a valid number';
//       }
//       return null;
//     },
//   ),
// ),
// Expanded(
//   child: QuestionInput(
//     question: 'Months of Experience',
//     hint: 'Enter months of experience',
//     controller: monthsOfExperienceController,
//     keyboardType: TextInputType.number,
//     validator: (value) {
//       if (value!.isEmpty) {
//         return 'Please enter months of experience';
//       }
//       if (int.tryParse(value) == null) {
//         return 'Enter a valid number';
//       }
//       return null;
//     },
//   ),
// )
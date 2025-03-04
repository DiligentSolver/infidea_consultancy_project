import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/widgets/custom_dropdown.dart';
import '../../core/widgets/multi_custom_dropdown.dart';
import '../../core/widgets/question_input.dart';

class FormScreen2 extends StatefulWidget {
  const FormScreen2({super.key});

  @override
  _FormScreen2State createState() => _FormScreen2State();
}

class _FormScreen2State extends State<FormScreen2> {
  final _formKey2 = GlobalKey<FormState>(); // Key for Form Validation
  final TextEditingController addressController = TextEditingController();
  String? currentCity;
  List<String> selectedLanguages = []; // Store multiple selected languages
  List<String> selectedPrefCities = []; // Store multiple cities

  final List<String> cities = [
    "Indore", "Mumbai", "Delhi", "Bangalore", "Chennai", "Kolkata",
    "Hyderabad", "Pune", "Jaipur", "Ahmedabad"
  ];

  final List<String> languages = [
    "Hindi","German","Oriya","French","Parsi","Sindhi", "English", "Tamil", "Telugu", "Marathi",
    "Gujarati", "Bengali", "Punjabi", "Kannada", "Malayalam"
  ];

  @override
  void initState() {
    super.initState();
    // Add listeners to update the UI when text changes
    addressController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    // Dispose controllers to prevent memory leaks
    addressController.dispose();
    super.dispose();
  }

  void _validateAndProceed() {
    if (_formKey2.currentState!.validate() &&
        selectedPrefCities.isNotEmpty &&
        selectedLanguages.isNotEmpty &&
        currentCity != null) {
      Navigator.pushNamed(context, '/formScreen3'); // Navigate to next form screen
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
      appBar: AppBar(title: const Text(AppStrings.formScreen2Title)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey2,
            autovalidateMode: AutovalidateMode.onUserInteraction, // Enables real-time validation
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [


                // CustomDropdown(
                //   label: AppStrings.selectCity,
                //   value: currentCity,
                //   items: cities,
                //   onChanged: (value) {
                //     setState(() {
                //       currentCity = value;
                //     });
                //   },
                // ),
                MultiCustomDropdown(
                  label: AppStrings.selectCity,
                  items: cities,
                  selectedItemSingle: currentCity,
                  onSingleSelectionChanged: (selected) {
                    setState(() {
                      currentCity = selected;
                    });
                  },
                  maxSelection: 1, isMultiSelect: false,
                ),
                const SizedBox(height: 20),
                QuestionInput(
                  question: AppStrings.whatIsYourLocalAddress,
                  hint: AppStrings.enterAddress,
                  controller: addressController,
                  validator: (value) => value!.isEmpty ? AppStrings.addressRequired : null,
                ),
                const SizedBox(height: 20),
                MultiCustomDropdown(
                  label: AppStrings.selectUpTo3Cities,
                  items: cities,
                  selectedItemMulti: selectedPrefCities,
                  onMultiSelectionChanged: (List<String> newSelection) {
                    setState(() {
                      selectedPrefCities = newSelection;
                    });
                  },
                  maxSelection: 3, isMultiSelect: true,
                ),
                const SizedBox(height: 20),
                MultiCustomDropdown(
                  label: AppStrings.selectUpTo5Languages,
                  items: languages,
                  selectedItemMulti: selectedLanguages,
                  onMultiSelectionChanged: (List<String> newSelection) {
                    setState(() {
                      selectedLanguages = newSelection;
                    });
                  },
                  maxSelection: 5, isMultiSelect: true,
                ),
                const SizedBox(height: 20),
                Center(
                  child: SizedBox(
                    width: double.infinity, // Makes it wide
                    height: 50, // Adjust height for rectangle shape
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.secondary, // Orange
                        foregroundColor: AppColors.background, // White text
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12), // Smooth rectangle edges
                        ),
                      ),
                      onPressed: _validateAndProceed,
                      child: const Text(
                        AppStrings.next,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
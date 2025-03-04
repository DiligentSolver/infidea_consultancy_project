import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/widgets/question_input.dart';
import '../../core/widgets/custom_radio_button.dart';
import '../../core/widgets/multi_custom_dropdown.dart';

class FormScreen3 extends StatefulWidget {
  const FormScreen3({super.key});

  @override
  _FormScreen3State createState() => _FormScreen3State();
}

class _FormScreen3State extends State<FormScreen3> {
  final _formKey = GlobalKey<FormState>();

  bool? isCurrentlyStudying;
  String? selectedEducation;
  final List<String> educationOptions = [
    AppStrings.below10th,
    AppStrings.pass10th,
    AppStrings.pass12th,
    AppStrings.diploma,
    AppStrings.graduate,
    AppStrings.postGraduate
  ];

  final List<String> collegeNames = ["Harvard", "MIT", "Stanford", "Oxford", "Cambridge"];
  final List<String> degreeNames =[
    // Engineering Degrees
    "Bachelor of Technology (B.Tech)",
    "Bachelor of Engineering (B.E.)",
    "Master of Technology (M.Tech)",
    "Master of Engineering (M.E.)",
    "Diploma in Engineering",

    // Medical Degrees
    "Bachelor of Medicine, Bachelor of Surgery (MBBS)",
    "Bachelor of Dental Surgery (BDS)",
    "Bachelor of Ayurvedic Medicine and Surgery (BAMS)",
    "Bachelor of Unani Medicine and Surgery (BUMS)",
    "Bachelor of Veterinary Science (B.V.Sc.)",
    "Bachelor of Physiotherapy (BPT)",
    "Bachelor of Occupational Therapy (BOT)",
    "Master of Surgery (MS)",
    "Doctor of Medicine (MD)",
    "Master of Dental Surgery (MDS)",
    "Doctor of Veterinary Medicine (DVM)",

    // Science Degrees
    "Bachelor of Science (B.Sc.)",
    "Master of Science (M.Sc.)",
    "Integrated M.Sc.",
    "Doctor of Philosophy (Ph.D.)",

    // Arts & Humanities Degrees
    "Bachelor of Arts (B.A.)",
    "Master of Arts (M.A.)",
    "Bachelor of Fine Arts (BFA)",
    "Master of Fine Arts (MFA)",

    // Commerce & Management Degrees
    "Bachelor of Commerce (B.Com.)",
    "Master of Commerce (M.Com.)",
    "Bachelor of Business Administration (BBA)",
    "Master of Business Administration (MBA)",
    "Executive MBA",

    // Law Degrees
    "Bachelor of Laws (LLB)",
    "Master of Laws (LLM)",
    "Integrated BA LLB",
    "Integrated BBA LLB",
    "Integrated B.Com LLB",

    // Computer Science & IT Degrees
    "Bachelor of Computer Applications (BCA)",
    "Master of Computer Applications (MCA)",


    // Design & Fashion Degrees
    "Bachelor of Design (B.Des.)",
    "Master of Design (M.Des.)",
    "Bachelor of Fashion Technology (B.FTech)",
    "Master of Fashion Technology (M.FTech)",

    // Hotel & Hospitality Management Degrees
    "Bachelor of Hotel Management (BHM)",
    "Master of Hotel Management (MHM)",

    // Agriculture & Forestry Degrees
    "Bachelor of Science in Agriculture (B.Sc Ag.)",
    "Master of Science in Agriculture (M.Sc Ag.)",
    "Bachelor of Fisheries Science (B.F.Sc.)",
    "Bachelor of Horticulture (B.Sc Horticulture)",

    // Mass Communication & Journalism Degrees


    // Pharmacy Degrees
    "Bachelor of Pharmacy (B.Pharm.)",
    "Master of Pharmacy (M.Pharm.)",
    "Doctor of Pharmacy (Pharm.D)",

    // Architecture Degrees
    "Bachelor of Architecture (B.Arch.)",
    "Master of Architecture (M.Arch.)",

    // Teaching & Education Degrees
    "Bachelor of Education (B.Ed.)",
    "Master of Education (M.Ed.)",
    "Diploma in Elementary Education (D.El.Ed)",
    "Bachelor of Physical Education (B.P.Ed.)",

    // Aviation Degrees
    "Bachelor of Aviation",
    "Commercial Pilot License (CPL)",

    // Paramedical Degrees
    "Bachelor of Science in Nursing (B.Sc Nursing)",
    "Master of Science in Nursing (M.Sc Nursing)",
    "Diploma in Medical Laboratory Technology (DMLT)",

    // Social Work & Psychology Degrees
    "Bachelor of Social Work (BSW)",
    "Master of Social Work (MSW)",
    "Bachelor of Psychology",
    "Master of Psychology",

    // Event Management & Performing Arts
    "Bachelor of Event Management",
    "Master of Event Management",
    "Bachelor of Performing Arts (BPA)",
    "Master of Performing Arts (MPA)"
  ];
  final List<String> years = List.generate(71, (index) => (1980 + index).toString());

  String? graduateCollege;
  String? graduateDegree;
  String? graduateStartYear;
  String? graduateEndYear;

  String? postGraduateCollege;
  String? postGraduateDegree;
  String? postGraduateStartYear;
  String? postGraduateEndYear;

  void _validateAndProceed() {
    if (_formKey.currentState!.validate()) {
      if (isCurrentlyStudying == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(AppStrings.studyStatusRequired),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      if (isCurrentlyStudying == true && selectedEducation == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(AppStrings.currentStudyLevelRequired),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      Navigator.pushNamed(context, '/formScreen4');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(AppStrings.fillAllFieldsError),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Widget _buildDegreeDetailsSection({
    required String degreeType,
    required String? selectedCollege,
    required String? selectedDegree,
    required String? selectedStartYear,
    required String? selectedEndYear,
    required Function(String) onCollegeChanged,
    required Function(String) onDegreeChanged,
    required Function(String) onStartYearChanged,
    required Function(String) onEndYearChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text(
          "$degreeType Details",
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: AppColors.primary,
              fontStyle: FontStyle.italic),
        ),
        MultiCustomDropdown(
          label: AppStrings.collegeName,
          items: collegeNames,
          selectedItemSingle: selectedCollege,
          onSingleSelectionChanged: onCollegeChanged,
          maxSelection: 1,
          isMultiSelect: false,
        ),
        MultiCustomDropdown(
          label: AppStrings.degreeNameLabel,
          items: degreeNames,
          selectedItemSingle: selectedDegree,
          onSingleSelectionChanged: onDegreeChanged,
          maxSelection: 1,
          isMultiSelect: false,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: MultiCustomDropdown(
                label: AppStrings.graduateStartYear,
                items: years,
                selectedItemSingle: selectedStartYear,
                onSingleSelectionChanged: onStartYearChanged,
                maxSelection: 1,
                isMultiSelect: false,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: MultiCustomDropdown(
                label: AppStrings.graduateEndYear,
                items: years,
                selectedItemSingle: selectedEndYear,
                onSingleSelectionChanged: onEndYearChanged,
                maxSelection: 1,
                isMultiSelect: false,
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.currentStudyTitle)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(AppStrings.areYouCurrentlyStudying,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: AppColors.primary)),
                Row(
                  children: [
                    CustomRadioButton<bool>(
                      label: AppStrings.yes,
                      value: true,
                      groupValue: isCurrentlyStudying,
                      onChanged: (value) {
                        setState(() {
                          isCurrentlyStudying = value;
                        });
                      },
                    ),
                    CustomRadioButton<bool>(
                      label: AppStrings.no,
                      value: false,
                      groupValue: isCurrentlyStudying,
                      onChanged: (value) {
                        setState(() {
                          isCurrentlyStudying = value;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(AppStrings.education,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: AppColors.primary)),
                Wrap(
                  spacing: 10,
                  children: educationOptions.map((option) {
                    return CustomRadioButton<String>(
                      label: option,
                      value: option,
                      groupValue: selectedEducation,
                      onChanged: (value) {
                        setState(() {
                          selectedEducation = value;
                        });
                      },
                    );
                  }).toList(),
                ),
                if (selectedEducation == AppStrings.graduate ||
                    selectedEducation == AppStrings.postGraduate) ...[
                  _buildDegreeDetailsSection(
                    degreeType: "Graduate",
                    selectedCollege: graduateCollege,
                    selectedDegree: graduateDegree,
                    selectedStartYear: graduateStartYear,
                    selectedEndYear: graduateEndYear,
                    onCollegeChanged: (val) => setState(() => graduateCollege = val),
                    onDegreeChanged: (val) => setState(() => graduateDegree = val),
                    onStartYearChanged: (val) => setState(() => graduateStartYear = val),
                    onEndYearChanged: (val) => setState(() => graduateEndYear = val),
                  ),
                ],
                if (selectedEducation == AppStrings.postGraduate) ...[
                  _buildDegreeDetailsSection(
                    degreeType: "Post Graduate",
                    selectedCollege: postGraduateCollege,
                    selectedDegree: postGraduateDegree,
                    selectedStartYear: postGraduateStartYear,
                    selectedEndYear: postGraduateEndYear,
                    onCollegeChanged: (val) => setState(() => postGraduateCollege = val),
                    onDegreeChanged: (val) => setState(() => postGraduateDegree = val),
                    onStartYearChanged: (val) => setState(() => postGraduateStartYear = val),
                    onEndYearChanged: (val) => setState(() => postGraduateEndYear = val),
                  ),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

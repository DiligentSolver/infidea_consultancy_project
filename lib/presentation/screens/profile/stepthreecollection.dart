import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infidea_consultancy_app/core/utils/constants/sizes.dart';
import 'package:infidea_consultancy_app/core/utils/constants/texts.dart';
import 'package:infidea_consultancy_app/logic/blocs/form/form_bloc.dart';
import 'package:infidea_consultancy_app/logic/blocs/form/form_state.dart';
import 'package:infidea_consultancy_app/presentation/widgets/drop_down_button/single_drop_down.dart';
import '../../../core/utils/text_styles/text_styles.dart';
import '../../../logic/blocs/form/form_event.dart';
import '../../widgets/buttons/elevated_button.dart';
import '../../widgets/chips/choice_chip_list.dart';
import '../../widgets/drop_down_button/row_drop_down.dart';
import '../../widgets/linear_indicator/custom_linear_indicator.dart';


class StepThreeCollection extends StatefulWidget {
  const StepThreeCollection({super.key});

  @override
  StepThreeCollectionState createState() => StepThreeCollectionState();
}

class StepThreeCollectionState extends State<StepThreeCollection> {
  final _formKey = GlobalKey<FormState>();

  final List<String> educationOptions = [
    MYTexts.below10th,
    MYTexts.pass10th,
    MYTexts.pass12th,
    MYTexts.diploma,
    MYTexts.graduate,
    MYTexts.postGraduate
  ];

  final List<String> currentlyStudingOptions = [
    "true",
    "false"
  ];

  final List<String> collegeNames = [
    "Harvard",
    "MIT",
    "Stanford",
    "Oxford",
    "Cambridge"
  ];
  final List<String> degreeNames = [
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
  final List<String> years =
      List.generate(71, (index) => (1980 + index).toString());

  String? graduateCollege;
  String? graduateDegree;
  String? graduateStartYear;
  String? graduateEndYear;

  String? postGraduateCollege;
  String? postGraduateDegree;
  String? postGraduateStartYear;
  String? postGraduateEndYear;

  @override
  void initState() {
    super.initState();
    context.read<FormBloc>().add(LoadFormData());
  }

  void _validateAndProceed() {
    if (_formKey.currentState!.validate()) {
      final formBloc = context.read<FormBloc>();
      final formState = formBloc.state;
      if (formState.educationLevel!=null&&formState.isCurrentlyStudying!=null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(MYTexts.studyStatusRequired),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      if (formState.isCurrentlyStudying == true && formState.educationLevel == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(MYTexts.currentStudyLevelRequired),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
      context.read<FormBloc>().add(SubmitForm());
      Navigator.pushNamed(context, '/stepFourCollection');

    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(MYTexts.fillAllFieldsError),
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
    required void Function(String?)? onCollegeChanged,
    required void Function(String?)? onDegreeChanged,
    required void Function(String?)?  onStartYearChanged,
    required void Function(String?)?  onEndYearChanged,
  }) {
    return Column(
      children: [
        SingleDropdownSelect(
          question: MYTexts.collegeName,
          items: collegeNames,
          isDown: true,
          selectedItem: selectedCollege,
          onSelectionChanged:  onCollegeChanged,
        ),
        verticalSpace(MySizes.spaceBtwSections.r),
        SingleDropdownSelect(
          question: MYTexts.degreeNameLabel,
          items: degreeNames,
          isDown: true,
          selectedItem: selectedDegree,
          onSelectionChanged:  onDegreeChanged,
        ),
        verticalSpace(MySizes.spaceBtwSections.r),
        RowCustomDropdown(
            question: "Duration ?",
            label1: MYTexts.graduateStartYear, label2: MYTexts.graduateEndYear, minValue1: DateTime.now().year-50, maxValue1: DateTime.now().year, minValue2: DateTime.now().year-50, maxValue2: DateTime.now().year+50, onSelected: (startYear,endYear){
          setState(() {
            selectedStartYear = startYear.toString();
            selectedEndYear = endYear.toString();
          });
        },
        isDown: true,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<FormBloc,UserFormState>(
        builder: (context,formState){
          final formBloc = context.read<FormBloc>();
          return Scaffold(
          bottomNavigationBar: BottomAppBar(
            child: MYElevatedButton(
              onPressed: () => _validateAndProceed(),
              child: const Text(MYTexts.next),
            ),
          ),
          appBar: AppBar(
            title: CustomLinearProgressIndicator(progress: formState.calculateProgress()),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: MySizes.defaultSpace.r),
              child: Center(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalSpace(MySizes.defaultSpace.r),
                      CustomChoiceChipList(
                        question: MYTexts.areYouCurrentlyStudying,
                        groupValue: formState.isCurrentlyStudying.toString(),
                        options: currentlyStudingOptions,
                        onChanged: (value) {
                          formBloc.add(UpdateFormEvent(isCurrentlyStudying: formState.isCurrentlyStudying));
                          print(formState.isCurrentlyStudying);
                        },
                      ),
                      verticalSpace(MySizes.spaceBtwSections.r),
                      CustomChoiceChipList(
                        question: MYTexts.education,
                        options: educationOptions,
                        groupValue: formState.educationLevel,
                        onChanged: (value) {
                          formBloc.add(UpdateFormEvent(educationLevel: value));
                        },
                      ),
                      verticalSpace(MySizes.spaceBtwSections.r),
                      if (formState.educationLevel == MYTexts.graduate ||
                          formState.educationLevel == MYTexts.postGraduate) ...[
                        Text(
                          MYTexts.graduateDetails,
                          style: MYAppTextStyles.titleLarge(
                              fontWeight: FontWeight.bold),
                        ),
                        verticalSpace(MySizes.spaceBtwItems.r),
                        _buildDegreeDetailsSection(
                          degreeType: "Graduate",
                          selectedCollege: formState.graduateCollege,
                          selectedDegree: formState.graduateDegree,
                          selectedStartYear: formState.graduateStartYear,
                          selectedEndYear: formState.graduateEndYear,
                          onCollegeChanged: (val) {
                            formBloc.add(UpdateFormEvent(graduateCollege: val));
                          } ,
                          onDegreeChanged: (val) {
                            formBloc.add(UpdateFormEvent(graduateDegree: val));
                          },
                          onStartYearChanged: (val) {
                            formBloc.add(UpdateFormEvent(graduateStartYear: val));
                          } ,
                          onEndYearChanged: (val) {
                            formBloc.add(UpdateFormEvent(graduateEndYear: val));
                          } ,
                        ),
                      ],
                      verticalSpace(MySizes.spaceBtwSections.r),
                      if (formState.educationLevel == MYTexts.postGraduate) ...[
                        Text(
                          MYTexts.postGraduateDetails,
                          style: MYAppTextStyles.titleLarge(
                              fontWeight: FontWeight.bold),
                        ),
                        verticalSpace(MySizes.spaceBtwItems.r),
                        _buildDegreeDetailsSection(
                          degreeType: "Post Graduate",
                          selectedCollege: postGraduateCollege,
                          selectedDegree: postGraduateDegree,
                          selectedStartYear: postGraduateStartYear,
                          selectedEndYear: postGraduateEndYear,
                          onCollegeChanged: (val) {
                            formBloc.add(UpdateFormEvent(postGraduateCollege: val));
                          } ,
                          onDegreeChanged: (val) {
                            formBloc.add(UpdateFormEvent(postGraduateDegree: val));
                          },
                          onStartYearChanged: (val) {
                            formBloc.add(UpdateFormEvent(postGraduateStartYear: val));
                          } ,
                          onEndYearChanged: (val) {
                            formBloc.add(UpdateFormEvent(postGraduateEndYear: val));
                          } ,
                        ),
                        verticalSpace(MySizes.spaceBtwSectionsLg.r)
                      ],
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

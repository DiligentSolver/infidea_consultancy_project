import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infidea_consultancy_app/core/utils/constants/sizes.dart';
import 'package:infidea_consultancy_app/core/utils/constants/texts.dart';
import 'package:infidea_consultancy_app/core/utils/helpers/bars.dart';
import 'package:infidea_consultancy_app/logic/blocs/form/form_bloc.dart';
import 'package:infidea_consultancy_app/logic/blocs/form/form_state.dart';
import 'package:infidea_consultancy_app/presentation/widgets/drop_down_button/single_drop_down.dart';
import '../../../core/utils/text_styles/text_styles.dart';
import '../../../data/repositories/dropdown_repository.dart';
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

  final List<String> _collegeNames = [
    "Harvard",
    "MIT",
    "Stanford",
    "Oxford",
    "Cambridge"
  ];

   List<String> _degreeNames = [

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

  DropdownRepository dropdownRepository = DropdownRepository();

  Future<void> fetchDegrees() async {
    try {
      final degrees = await dropdownRepository.getDegrees();
      setState(() {
        _degreeNames = degrees;
      });
    } catch (e) {
      print("Error fetching languages: $e");
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
      if (formState.isStepThreeValid()) {
        context.read<FormBloc>().add(SubmitForm());
        Navigator.pushNamed(context, '/stepFourCollection');
      }else{
        Bars.showCustomToast(context: context, message: 'Select your choice');
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
    required void Function(String?)? onStartYearChanged,
    required void Function(String?)? onEndYearChanged,
    required UserFormState formState,  // ✅ Added formState as a parameter
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ✅ College Name Dropdown
        SingleDropdownSelect(
          question: MYTexts.collegeName,
          items: _collegeNames,
          selectedItem: selectedCollege,
          onSelectionChanged: onCollegeChanged,
          isDown: true,
        ),
        verticalSpace(MySizes.spaceBtwSections.r),

        // ✅ Degree Name Dropdown
        SingleDropdownSelect(
          question: MYTexts.degreeNameLabel,
          items: _degreeNames,
          selectedItem: selectedDegree,
          onSelectionChanged: onDegreeChanged,
          isDown: true,
        ),
        verticalSpace(MySizes.spaceBtwSections.r),

        // ✅ Duration (Start Year & End Year)
        RowCustomDropdown(
          question: "Duration?",
          label1: MYTexts.graduateStartYear,
          label2: MYTexts.graduateEndYear,
          minValue1: DateTime.now().year - 50,
          maxValue1: DateTime.now().year,
          minValue2: DateTime.now().year - 50,
          maxValue2: DateTime.now().year + 50,
          isDown: true,
          onSelected: (startYear, endYear) {
            setState(() {
              formState = formState.copyWith(
                graduateStartYear: startYear.toString(),
                graduateEndYear: endYear.toString(),
              );
            });
            onStartYearChanged?.call(startYear.toString());
            onEndYearChanged?.call(endYear.toString());
          },
        ),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<FormBloc, UserFormState>(
        listener: (BuildContext context, UserFormState formState) {
          formState.copyWith(
            isCurrentlyStudying: formState.isCurrentlyStudying,
            educationLevel: formState.educationLevel,
            graduateCollege: formState.graduateCollege,
            graduateDegree: formState.graduateDegree,
            graduateStartYear: formState.graduateStartYear,
            graduateEndYear: formState.graduateEndYear,
            postGraduateCollege: formState.postGraduateCollege,
            postGraduateDegree: postGraduateDegree,
            postGraduateStartYear: postGraduateStartYear,
            postGraduateEndYear: postGraduateEndYear,
          );

          // ✅ Fetch Degrees only if education level is "Graduate"
          if (formState.educationLevel == MYTexts.graduate) {
            fetchDegrees();
          }
        },
        builder: (context, formState) {
          final formBloc = context.read<FormBloc>();

          return Scaffold(
            bottomNavigationBar: BottomAppBar(
              child: MYElevatedButton(
                onPressed: () => _validateAndProceed(),
                child: const Text(MYTexts.next),
              ),
            ),
            appBar: AppBar(
              title: Row(
                children: [
                  Expanded(
                    child: CustomLinearProgressIndicator(
                      progress: formState.calculateProgress(),
                    ),
                  ),
                  horizontalSpace(MySizes.spaceBtwItems.r),
                  const Text("Page: 3/5"),
                ],
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: MySizes.defaultSpace.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalSpace(MySizes.defaultSpace.r),
                    Text(
                      'Education Details',
                      style: MYAppTextStyles.titleLarge(fontWeight: FontWeight.bold),
                    ),
                    verticalSpace(MySizes.spaceBtwSectionsLg.r),
                    CustomChoiceChipList(
                      question: MYTexts.areYouCurrentlyStudying,
                      groupValue: formState.isCurrentlyStudying.toString(),
                      options: currentlyStudingOptions,
                      onChanged: (value) {
                        bool? isStudying = value == "true";
                        formBloc.add(UpdateFormEvent(isCurrentlyStudying: isStudying));
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

                    // ✅ Show Degree Details only for "Graduate"
                    if (formState.educationLevel == MYTexts.graduate ||
                        formState.educationLevel == MYTexts.postGraduate) ...[
                      Text(
                        MYTexts.graduateDetails,
                        style: MYAppTextStyles.titleLarge(fontWeight: FontWeight.bold),
                      ),
                      verticalSpace(MySizes.spaceBtwItems.r),
                      _buildDegreeDetailsSection(
                        degreeType: "Graduate",
                        selectedCollege: formState.graduateCollege,
                        selectedDegree: formState.graduateDegree,
                        selectedStartYear: formState.graduateStartYear,
                        selectedEndYear: formState.graduateEndYear,
                        formState: formState, // ✅ Pass formState
                        onCollegeChanged: (val) {
                          formBloc.add(UpdateFormEvent(graduateCollege: val));
                        },
                        onDegreeChanged: (val) {
                          formBloc.add(UpdateFormEvent(graduateDegree: val));
                        },
                        onStartYearChanged: (val) {
                          formBloc.add(UpdateFormEvent(graduateStartYear: val));
                        },
                        onEndYearChanged: (val) {
                          formBloc.add(UpdateFormEvent(graduateEndYear: val));
                        },
                      ),
                    ],
                    verticalSpace(MySizes.spaceBtwSections.r),

                    // ✅ Show Post Graduate Section only for "Post Graduate"
                    if (formState.educationLevel == MYTexts.postGraduate) ...[
                      Text(
                        MYTexts.postGraduateDetails,
                        style: MYAppTextStyles.titleLarge(fontWeight: FontWeight.bold),
                      ),
                      verticalSpace(MySizes.spaceBtwItems.r),
                      _buildDegreeDetailsSection(
                        degreeType: "Post Graduate",
                        selectedCollege: formState.postGraduateCollege,
                        selectedDegree: formState.postGraduateDegree,
                        selectedStartYear: formState.postGraduateStartYear,
                        selectedEndYear: formState.postGraduateEndYear,
                        onCollegeChanged: (val) {
                          formBloc.add(UpdateFormEvent(postGraduateCollege: val));
                        },
                        onDegreeChanged: (val) {
                          formBloc.add(UpdateFormEvent(postGraduateDegree: val));
                        },
                        onStartYearChanged: (val) {
                          formBloc.add(UpdateFormEvent(postGraduateStartYear: val));
                        },
                        onEndYearChanged: (val) {
                          formBloc.add(UpdateFormEvent(postGraduateEndYear: val));
                        },
                        formState: formState,
                      ),
                      verticalSpace(MySizes.spaceBtwSectionsLg.r),
                    ],
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

}

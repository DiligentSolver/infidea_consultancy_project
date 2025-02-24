import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:infidea_consultancy_app/core/utils/constants/sizes.dart';
import 'package:infidea_consultancy_app/core/utils/constants/texts.dart';
import 'package:infidea_consultancy_app/core/utils/helpers/bars.dart';
import 'package:infidea_consultancy_app/logic/blocs/form/form_bloc.dart';
import 'package:infidea_consultancy_app/logic/blocs/form/form_state.dart';
import 'package:infidea_consultancy_app/presentation/widgets/drop_down_button/single_drop_down.dart';
import 'package:infidea_consultancy_app/presentation/widgets/drop_down_button/year_range_picker.dart';
import 'package:infidea_consultancy_app/presentation/widgets/input_fields/text_form_field.dart';
import '../../../core/utils/text_styles/text_styles.dart';
import '../../../data/repositories/dropdown_repository.dart';
import '../../../logic/blocs/form/form_event.dart';
import '../../widgets/buttons/elevated_button.dart';
import '../../widgets/chips/choice_chip_list.dart';
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

  final List<String> currentlyStudingOptions = ["Yes", "No"];

  final List<String> _collegeNames = [
    "Harvard",
    "MIT",
    "Stanford",
    "Oxford",
    "Cambridge"
  ];

  List<String> _degreeNames = [];

  final List<String> startYears =
      List.generate(70, (index) => (DateTime.now().year - index).toString());

  final List<String> endYears =
      List.generate(100, (index) => (DateTime.now().year+20 - index).toString());

  String? graduateCollege;
  String? graduateDegree;
  String? graduateStartYear;
  String? graduateEndYear;

  String? postGraduateCollege;
  String? postGraduateDegree;
  String? postGraduateStartYear;
  String? postGraduateEndYear;

  DropdownRepository dropdownRepository = DropdownRepository();

  TextEditingController collegeController = TextEditingController();
  TextEditingController pgCollegeController = TextEditingController();

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
    // TODO: implement initState
    super.initState();
    final formState = context.read<FormBloc>().state;

    // Initialize controllers with existing values
    collegeController =
        TextEditingController(text: formState.graduateCollege ?? "");
    pgCollegeController =
        TextEditingController(text: formState.postGraduateCollege ?? "");
  }

  void _validateAndProceed() {
    final formBloc = context.read<FormBloc>();
    final formState = formBloc.state;
    if (formState.isStepThreeValid()) {
      context.read<FormBloc>().add(SubmitForm());
      Navigator.pushNamed(context, '/stepFourCollection');
    } else{
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
    required void Function(dynamic)? onStartYearChanged,
    required void Function(dynamic)? onEndYearChanged,
    required UserFormState formState, // ✅ Added formState as a parameter
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ✅ College Name Dropdown
        MYInputField(
            controller: collegeController,
            prefixIcon: Icon(FontAwesomeIcons.university),
            labelText: "College Name",
            onChanged: onCollegeChanged),
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
        YearRangePicker(
          startYears: startYears,
          endYears: endYears,
          selectedStartYear: formState.graduateStartYear,
          selectedEndYear: formState.graduateEndYear,
          onStartYearChanged: onStartYearChanged,
          onEndYearChanged: onEndYearChanged,
          startHintText: formState.graduateStartYear,
          endHintText: formState.graduateEndYear,
        ),
      ],
    );
  }

  Widget _buildPgDegreeDetailsSection({
    required String degreeType,
    required String? selectedPgCollege,
    required String? selectedPgDegree,
    required String? selectedPgStartYear,
    required String? selectedPgEndYear,
    required void Function(String?)? onPgCollegeChanged,
    required void Function(String?)? onPgDegreeChanged,
    required void Function(dynamic)? onPgStartYearChanged,
    required void Function(dynamic)? onPgEndYearChanged,
    required UserFormState formState, // ✅ Added formState as a parameter
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ✅ College Name Dropdown
        MYInputField(
            controller: pgCollegeController,
            prefixIcon: const Icon(FontAwesomeIcons.university),
            labelText: "College Name",
            onChanged: onPgCollegeChanged),
        verticalSpace(MySizes.spaceBtwSections.r),

        // ✅ Degree Name Dropdown
        SingleDropdownSelect(
          question: MYTexts.degreeNameLabel,
          items: _degreeNames,
          selectedItem: selectedPgDegree,
          onSelectionChanged: onPgDegreeChanged,
          isDown: true,
        ),
        verticalSpace(MySizes.spaceBtwSections.r),
        YearRangePicker(
          startYears: startYears,
          endYears: endYears,
          onStartYearChanged: onPgStartYearChanged,
          onEndYearChanged: onPgEndYearChanged,
          startHintText: formState.postGraduateStartYear,
          endHintText: formState.postGraduateEndYear,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<FormBloc, UserFormState>(
        listener: (BuildContext context, UserFormState formState) {
          // ✅ Fetch Degrees only if education level is "Graduate"
          if (formState.educationLevel == MYTexts.graduate ||
              formState.educationLevel == MYTexts.postGraduate) {
            fetchDegrees();
          }
          collegeController.text = formState.graduateCollege ?? '';
          pgCollegeController.text = formState.postGraduateCollege ?? '';
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
                padding:
                    EdgeInsets.symmetric(horizontal: MySizes.defaultSpace.r),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalSpace(MySizes.defaultSpace.r),
                      Text(
                        'Education Details',
                        style: MYAppTextStyles.titleLarge(
                            fontWeight: FontWeight.bold),
                      ),
                      verticalSpace(MySizes.spaceBtwSectionsLg.r),
                      CustomChoiceChipList(
                        question: MYTexts.areYouCurrentlyStudying,
                        groupValue: formState.isCurrentlyStudying.toString(),
                        options: currentlyStudingOptions,
                        onChanged: (value) {
                          formBloc
                              .add(UpdateFormEvent(isCurrentlyStudying: value));
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
                          formState: formState, // ✅ Pass formState
                          onCollegeChanged: (val) {
                            formBloc.add(UpdateFormEvent(graduateCollege: val));
                          },
                          onDegreeChanged: (val) {
                            formBloc.add(UpdateFormEvent(graduateDegree: val));
                          },
                          onStartYearChanged: (val) {
                            formBloc
                                .add(UpdateFormEvent(graduateStartYear: val));
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
                          style: MYAppTextStyles.titleLarge(
                              fontWeight: FontWeight.bold),
                        ),
                        verticalSpace(MySizes.spaceBtwItems.r),
                        _buildPgDegreeDetailsSection(
                          degreeType: "Post Graduate",
                          selectedPgCollege: formState.postGraduateCollege,
                          selectedPgDegree: formState.postGraduateDegree,
                          selectedPgStartYear: formState.postGraduateStartYear,
                          selectedPgEndYear: formState.postGraduateEndYear,
                          onPgCollegeChanged: (val) {
                            formBloc
                                .add(UpdateFormEvent(postGraduateCollege: val));
                          },
                          onPgDegreeChanged: (val) {
                            formBloc
                                .add(UpdateFormEvent(postGraduateDegree: val));
                          },
                          onPgStartYearChanged: (val) {
                            formBloc.add(
                                UpdateFormEvent(postGraduateStartYear: val));
                          },
                          onPgEndYearChanged: (val) {
                            formBloc
                                .add(UpdateFormEvent(postGraduateEndYear: val));
                          },
                          formState: formState,
                        ),
                        verticalSpace(MySizes.spaceBtwSectionsLg.r),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  bool validateForm() {
    return _formKey.currentState?.validate() ?? false;
  }
}

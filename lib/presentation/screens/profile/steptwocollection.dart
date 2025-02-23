import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infidea_consultancy_app/core/utils/constants/colors.dart';
import 'package:infidea_consultancy_app/core/utils/helpers/bars.dart';
import 'package:infidea_consultancy_app/core/utils/helpers/helper_functions.dart';
import 'package:infidea_consultancy_app/data/repositories/dropdown_repository.dart';
import 'package:infidea_consultancy_app/logic/blocs/form/form_state.dart';
import 'package:infidea_consultancy_app/presentation/widgets/buttons/elevated_button.dart';
import 'package:infidea_consultancy_app/presentation/widgets/drop_down_button/multi_drop_down.dart';
import 'package:infidea_consultancy_app/presentation/widgets/drop_down_button/multi_search_drop_down.dart';
import 'package:infidea_consultancy_app/presentation/widgets/drop_down_button/single_drop_down.dart';
import 'package:infidea_consultancy_app/presentation/widgets/drop_down_button/single_search_drop_down.dart';
import 'package:infidea_consultancy_app/presentation/widgets/linear_indicator/custom_linear_indicator.dart';
import '../../../core/utils/constants/sizes.dart';
import '../../../core/utils/constants/texts.dart';
import '../../../core/utils/text_styles/text_styles.dart';
import '../../../logic/blocs/form/form_bloc.dart';
import '../../../logic/blocs/form/form_event.dart';

class StepTwoCollection extends StatefulWidget {
  const StepTwoCollection({super.key});

  @override
  StepTwoCollectionState createState() => StepTwoCollectionState();
}

class StepTwoCollectionState extends State<StepTwoCollection> {
  List<Map<String, dynamic>> _states=[];
  List<String> _cities = [];
  List<String> _indoreLocalities = [];
  List<String> _languages = [];
  List<String> _metroCities = [];
  bool isLoading = false;
  DropdownRepository dropdownRepository = DropdownRepository();

  Future<void> fetchStates() async {
    try {
      final states = await dropdownRepository.getStates();
      setState(() {
        _states = states;
      });
    } catch (e) {
      print("Error fetching states: $e");
    }
  }

  Future<void> fetchCities(String stateCode) async {
    setState(() => isLoading = true);
    try {
      final cities = await dropdownRepository.getCities(stateCode);
      setState(() {
        _cities = cities;
      });
    } catch (e) {
      print("Error fetching cities: $e");
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> fetchLanguages() async {
    try {
      final languages = await dropdownRepository.getLanguages();
      setState(() {
        _languages = languages;
      });
    } catch (e) {
      print("Error fetching languages: $e");
    }
  }

  Future<void> fetchIndoreLocalities() async {
    try {
      final indoreLocalities = await dropdownRepository.getIndoreLocalities();
      setState(() {
        _indoreLocalities = indoreLocalities;
      });
    } catch (e) {
      print("Error fetching languages: $e");
    }
  }

  Future<void> fetchMetroCities() async {
    setState(() => isLoading = true);
    try {
      final metroCities = await dropdownRepository.getMetroCities();
      setState(() {
        _metroCities = metroCities;
      });
    } catch (e) {
      print("Error fetching metro cities: $e");
    } finally {
      setState(() => isLoading = false);
    }
  }

  void _onStateChanged(String? selectedState) {
    final selectedStateCode = _states.firstWhere(
        (state) => state['name'] == selectedState,
        orElse: () => {"code": null})['code']; // Extract state code

    if (selectedStateCode != null) {
      fetchCities(selectedStateCode); // Fetch cities for selected state
    }
    context.read<FormBloc>().add(UpdateFormEvent(state: selectedState));
  }

  void _onCityChanged(String? city) {
    if (city == 'indore' || city == 'Indore') {
      fetchIndoreLocalities(); // Fetch localities for indore
    }

    context.read<FormBloc>().add(UpdateFormEvent(currentCity: city));
  }

  @override
  void initState() {
    super.initState();
    fetchStates();
    fetchLanguages();
    fetchMetroCities();
  }

  void _validateAndProceed(BuildContext context) {
    final formBloc = context.read<FormBloc>();
    final formState = formBloc.state;
    if (formState.isStepTwoValid()) {
      formBloc.add(SubmitForm());
      Navigator.pushNamed(
          context, '/stepThreeCollection'); // Navigate to next form screen
    } else {
      Bars.showCustomToast(
          context: context, message: MYTexts.fillAllFieldsError);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<FormBloc, UserFormState>(
        builder: (context, formState) {
          final formBloc = context.read<FormBloc>();
          return Scaffold(
            // appBar: AppBar(
            //     title: Row(
            //   children: [
            //     Expanded(
            //         child: CustomLinearProgressIndicator(
            //             progress: formState.calculateProgress())),
            //     horizontalSpace(MySizes.spaceBtwItems.r),
            //     const Text("Page: 2/5"),
            //   ],
            // )),
            // bottomNavigationBar: BottomAppBar(
            //   child: MYElevatedButton(
            //     onPressed: () => _validateAndProceed(context),
            //     child: const Text(MYTexts.next),
            //   ),
            // ),
            body: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: MySizes.defaultSpace.r),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalSpace(MySizes.spaceBtwItems.r),
                      Text(
                        'Personal Details (2/2)',
                        style: MYAppTextStyles.titleLarge(
                            fontWeight: FontWeight.bold),
                      ),
                      verticalSpace(MySizes.spaceBtwSections.r),
                      SingleSearchDropdownButton(  items: _states.map((x) => x["name"]).toList(),
                        onChanged: (selected) {
                            _onStateChanged(selected);
                            },
                      question: MYTexts.state,
                      ),
                      verticalSpace(MySizes.spaceBtwSections.r),
                      if (formState.state != null) ...[
                        SingleSearchDropdownButton(question: MYTexts.currentCity,items: _cities,
                          onChanged: (selected) => _onCityChanged(selected)
                        ),
                        verticalSpace(MySizes.spaceBtwSections.r),
                      ],
                      if (formState.currentCity == 'indore' ||
                          formState.currentCity == 'Indore') ...[
                        SingleSearchDropdownButton(items: _indoreLocalities,
                          onChanged: (selected) {
                            formBloc.add(
                                UpdateFormEvent(currentLocality: selected));
                          },
                          question: MYTexts.currentLocality,
                        ),
                        verticalSpace(MySizes.spaceBtwSections.r),
                      ],
                      MultiSearchDropdownButton(maxSelection: 3,question: MYTexts.preferredLocations,items: _metroCities, onChanged: (newSelection) {
                        formBloc.add(
                            UpdateFormEvent(preferredCities: List<String>.from(newSelection)));
                      }),
                      verticalSpace(MySizes.spaceBtwSections.r),
                      MultiSearchDropdownButton(maxSelection: 5,question: MYTexts.speakingLanguages,items: _languages, onChanged: (newSelection) {
                        formBloc.add(
                            UpdateFormEvent(languages: List<String>.from(newSelection)));
                      }),
                      verticalSpace(MySizes.spaceBtwSectionsLg.r),
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
}

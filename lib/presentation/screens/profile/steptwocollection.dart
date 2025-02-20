import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infidea_consultancy_app/core/utils/helpers/bars.dart';
import 'package:infidea_consultancy_app/logic/blocs/form/form_state.dart';
import 'package:infidea_consultancy_app/presentation/screens/profile/steponecollection.dart';
import 'package:infidea_consultancy_app/presentation/widgets/buttons/elevated_button.dart';
import 'package:infidea_consultancy_app/presentation/widgets/drop_down_button/multi_drop_down.dart';
import 'package:infidea_consultancy_app/presentation/widgets/drop_down_button/single_drop_down.dart';
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

  final List<String> cities = [
    "Indore",
    "Mumbai",
    "Delhi",
    "Bangalore",
    "Chennai",
    "Kolkata",
    "Hyderabad",
    "Pune",
    "Jaipur",
    "Ahmedabad"
  ];

  final List<String> languages = [
    "Hindi",
    "German",
    "Oriya",
    "French",
    "Parsi",
    "Sindhi",
    "English",
    "Tamil",
    "Telugu",
    "Marathi",
    "Gujarati",
    "Bengali",
    "Punjabi",
    "Kannada",
    "Malayalam"
  ];

  @override
  void initState() {
    super.initState();
    context.read<FormBloc>().add(LoadFormData());

  }


  void _validateAndProceed(BuildContext context) {
    final formBloc = context.read<FormBloc>();
    final formState = formBloc.state;
    if (formState.isStepTwoValid()) {
     formBloc.add(SubmitForm());
      Navigator.pushNamed(
          context, '/stepThreeCollection'); // Navigate to next form screen
    } else {
      Bars.showCustomToast(context: context, message: MYTexts.fillAllFieldsError);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<FormBloc,UserFormState>(
          listener: (BuildContext context, UserFormState formState) {

            formState.copyWith(
              currentCity: formState.currentCity,
              currentLocality: formState.currentLocality,
              preferredCities: formState.preferredCities,
              languages: formState.languages,
            );

          },
        builder: (context,formState){
          final formBloc = context.read<FormBloc>();
          return Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                Expanded(child: CustomLinearProgressIndicator(progress: formState.calculateProgress())),
                horizontalSpace(MySizes.spaceBtwItems.r),
                const Text("Page: 2/5"),
              ],
            )
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
                    SingleDropdownSelect(
                      question: MYTexts.currentLocation,
                      selectedItem: formState.currentCity,
                      items: cities,
                      onSelectionChanged: (selected) {
                        formBloc.add(
                            UpdateFormEvent(currentCity: selected));
                      },
                    ),
                    verticalSpace(MySizes.spaceBtwSectionsLg.r),
                    if (formState.currentCity == 'indore' || formState.currentCity == 'Indore') ...[
                      SingleDropdownSelect(
                        question: MYTexts.currentLocality,
                        selectedItem: formState.currentLocality,
                        items: cities,
                        onSelectionChanged: (selected) {
                          formBloc.add(
                              UpdateFormEvent(currentLocality: selected));
                        },
                      ),
                      verticalSpace(MySizes.spaceBtwSectionsLg.r),
                    ],
                    MultiDropdownSelect(
                      question: MYTexts.preferredLocations,
                      selectedItems: formState.preferredCities??[],
                      items: cities,
                      maxSelection: 3,
                      onSelectionChanged: (List<String> newSelection) {
                        formBloc.add(
                            UpdateFormEvent(preferredCities: newSelection));
                      },
                      isDown: true,
                    ),
                    verticalSpace(MySizes.spaceBtwSectionsLg.r),
                    MultiDropdownSelect(
                      question: MYTexts.speakingLanguages,
                      selectedItems: formState.languages??[],
                      items: languages,
                      maxSelection: 5,
                      onSelectionChanged: (List<String> newSelection) {
                        formBloc.add(
                            UpdateFormEvent(languages: newSelection));
                      },
                      isDown: true,
                    )
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

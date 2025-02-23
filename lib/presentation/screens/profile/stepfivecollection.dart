import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infidea_consultancy_app/data/repositories/dropdown_repository.dart';
import 'package:infidea_consultancy_app/logic/blocs/auth/auth_bloc.dart';
import 'package:infidea_consultancy_app/logic/blocs/auth/auth_state.dart';
import '../../../core/utils/constants/sizes.dart';
import '../../../core/utils/helpers/bars.dart';
import '../../../core/utils/text_styles/text_styles.dart';
import '../../../logic/blocs/form/form_bloc.dart';
import '../../../logic/blocs/form/form_event.dart';
import '../../../logic/blocs/form/form_state.dart';
import '../../widgets/buttons/elevated_button.dart';
import '../../widgets/drop_down_button/multi_drop_down.dart';
import '../../widgets/linear_indicator/custom_linear_indicator.dart';

class StepFiveCollection extends StatefulWidget {
  const StepFiveCollection({super.key});

  @override
  State<StepFiveCollection> createState() => StepFiveCollectionState();
}

class StepFiveCollectionState extends State<StepFiveCollection> {
  List<String> _industries = [];
  List<String> _jobRoles = [];
  String? _selectedIndustry;
  bool isLoading = false;
  DropdownRepository dropdownRepository = DropdownRepository();

  Future<void> fetchIndustries() async {
    try {
      final industries = await dropdownRepository.getIndustries();
      print(industries);
      setState(() {
        _industries = industries;
      });
    } catch (e) {
      print("Error fetching industries: $e");
    }
  }

  Future<void> fetchJobRoles(String industry) async {
    setState(() => isLoading = true);
    try {
      final roles = await dropdownRepository.getJobRoles(industry);
      setState(() {
        _jobRoles = roles;
        _selectedIndustry = industry;
      });
    } catch (e) {
      print("Error fetching job roles: $e");
    } finally {
      setState(() => isLoading = false);
    }
  }

  List<String> getSuggestedRoles(List<String> selectedRoles) {
    final remainingRoles =
        _jobRoles.where((role) => !selectedRoles.contains(role)).toList();
    remainingRoles.shuffle();
    return remainingRoles.take(6).toList();
  }

  void toggleRole(
      BuildContext context, String role, List<String> selectedRoles) {
    if (selectedRoles.contains(role)) {
      context.read<FormBloc>().add(UpdateFormEvent(
          selectedRoles: List.from(selectedRoles)..remove(role)));
    } else if (selectedRoles.length < 5) {
      context.read<FormBloc>().add(
          UpdateFormEvent(selectedRoles: List.from(selectedRoles)..add(role)));
    } else {
      Bars.showCustomToast(
          context: context, message: 'You can only select up to 5 job roles');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchIndustries();
  }

  @override
  dispose(){
    super.dispose();

  }

  void _onCompleteForm(BuildContext context) {
    final formState = context.read<FormBloc>().state;
    if (formState.isComplete()) {
      context.read<FormBloc>().add(CompleteForm(context));
      // Navigator.pushNamed(context, '/homeScreen');
    } else {
      Bars.showCustomToast(
          context: context,
          message: 'Please complete all required fields before submitting.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<FormBloc, UserFormState>(
        builder: (BuildContext context, formState) {
          final List<String> selectedRoles = formState.selectedRoles ?? [];
          return SafeArea(
            child: Scaffold(
              // appBar: AppBar(
              //   title: Row(
              //     children: [
              //       Expanded(
              //         child: CustomLinearProgressIndicator(
              //             progress: formState.calculateProgress()),
              //       ),
              //       horizontalSpace(MySizes.spaceBtwItems.r),
              //       const Text("Page: 5/5"),
              //     ],
              //   ),
              // ),
              body: SingleChildScrollView(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: MySizes.defaultSpace.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalSpace(MySizes.defaultSpace.r),
                      Text(
                        'Choose Job Roles',
                        style: MYAppTextStyles.titleLarge(
                            fontWeight: FontWeight.bold),
                      ),
                      verticalSpace(MySizes.spaceBtwSections.r),

                      // ✅ Selected Roles Section
                      if (selectedRoles.isNotEmpty) ...[
                        Text('Selected Roles:',
                            style: MYAppTextStyles.titleSmall()),
                        Wrap(
                          spacing: MySizes.sm.r,
                          runSpacing: MySizes.sm.r,
                          children: selectedRoles.map((role) {
                            return Chip(
                              label: Text(role),
                              deleteIcon: const Icon(Icons.close),
                              onDeleted: () =>
                                  toggleRole(context, role, selectedRoles),
                            );
                          }).toList(),
                        ),
                      ],

                      verticalSpace(MySizes.spaceBtwSections.r),

                      // ✅ Suggested Roles Section
                      Text('Suggested Roles:',
                          style: MYAppTextStyles.titleSmall()),
                      verticalSpace(MySizes.spaceBtwItems.r),
                      Wrap(
                        spacing: MySizes.sm.r,
                        runSpacing: MySizes.sm.r,
                        children: getSuggestedRoles(selectedRoles).map((role) {
                          return ActionChip(
                            label: Text(role),
                            onPressed: () =>
                                toggleRole(context, role, selectedRoles),
                          );
                        }).toList(),
                      ),

                      verticalSpace(MySizes.spaceBtwSections.r),

                      // ✅ MultiDropdownSelect (Dropdown should NOT show selected roles)
                      MultiDropdownSelect(
                        items: _industries
                            .where((role) => !selectedRoles.contains(role))
                            .toList(),
                        selectedItems: selectedRoles,
                        isHint: false,
                        maxSelection: 5,
                        question: "Select your preferred job roles (up to 5)",
                        onSelectionChanged: (selected) {
                          context
                              .read<FormBloc>()
                              .add(UpdateFormEvent(selectedRoles: selected));
                        },
                      ),
                    ],
                  ),
                ),
              ),

              // // ✅ Complete Button
              // bottomNavigationBar: BottomAppBar(child:
              //     BlocConsumer<AuthBloc, AuthState>(
              //         listener: (context, state){
              //           if (state is Authenticated) {
              //             Navigator.pushNamedAndRemoveUntil(
              //                 context, '/homeScreen', (route) => false);
              //           }
              //         },
              //         builder: (context, state) {
              //   return MYElevatedButton(
              //     onPressed: selectedRoles.isEmpty
              //         ? null
              //         : () => _onCompleteForm(context),
              //     child: const Text('Complete'),
              //   );
              //
              // })),
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infidea_consultancy_app/data/repositories/dropdown_repository.dart';
import 'package:infidea_consultancy_app/logic/blocs/auth/auth_bloc.dart';
import 'package:infidea_consultancy_app/logic/blocs/auth/auth_state.dart';
import 'package:infidea_consultancy_app/presentation/widgets/drop_down_button/multi_search_drop_down.dart';
import 'package:infidea_consultancy_app/presentation/widgets/drop_down_button/single_search_drop_down.dart';

import '../../../core/utils/constants/sizes.dart';
import '../../../core/utils/helpers/bars.dart';
import '../../../core/utils/text_styles/text_styles.dart';
import '../../../logic/blocs/form/form_bloc.dart';
import '../../../logic/blocs/form/form_event.dart';
import '../../../logic/blocs/form/form_state.dart';
import '../../widgets/buttons/elevated_button.dart';
import '../../widgets/linear_indicator/custom_linear_indicator.dart';

class StepFiveCollection extends StatefulWidget {
  const StepFiveCollection({super.key});

  @override
  State<StepFiveCollection> createState() => StepFiveCollectionState();
}

class StepFiveCollectionState extends State<StepFiveCollection> {
  List<String> _industries = [];
  List<String> _jobRoles = [];
  bool isLoading = false;
  DropdownRepository dropdownRepository = DropdownRepository();

  Future<void> fetchIndustries() async {
    try {
      final industries = await dropdownRepository.getIndustries();
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
      });
    } catch (e) {
      print("Error fetching job roles: $e");
    } finally {
      setState(() => isLoading = false);
    }
  }

  void _onIndustryChanged(String? selected) {
    final FormBloc formBloc = context.read<FormBloc>();
    formBloc.add(UpdateFormEvent(industry: selected));

    // Fetch job roles based on the newly selected industry
    if (selected != null && selected.isNotEmpty) {
      fetchJobRoles(selected);
    } else {
      setState(() {
        _jobRoles = [];
      });
    }
  }

  List<String> getSuggestedRoles(List<String> selectedRoles) {
    final remainingRoles =
    _jobRoles.where((role) => !selectedRoles.contains(role)).toList();
    remainingRoles.shuffle();
    return remainingRoles;
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

    final formState = context.read<FormBloc>().state;
    if (formState.industry != null && formState.industry!.isNotEmpty) {
      fetchJobRoles(formState.industry!);
    }
  }

  void _onCompleteForm(BuildContext context) {
    final formState = context.read<FormBloc>().state;
    if (formState.isComplete()) {
      context.read<FormBloc>().add(CompleteForm(context));
    } else {
      Bars.showCustomToast(
          context: context,
          message: 'Please complete all required fields before submitting.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<FormBloc, UserFormState>(
        listener: (context, formState) {
          // No action needed here unless you have side effects
        },
        builder: (BuildContext context, formState) {
          return Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  Expanded(
                    child: CustomLinearProgressIndicator(
                        progress: formState.calculateProgress()),
                  ),
                  horizontalSpace(MySizes.spaceBtwItems.r),
                  const Text("Page: 5/5"),
                ],
              ),
            ),
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

                    // ✅ Industry Selection Dropdown
                    SingleSearchDropdownButton(
                      items: _industries,
                      question: "What industry do you prefer?",
                      onChanged: (selected) => _onIndustryChanged(selected),
                      hintText: formState.industry ?? "Select Industry",
                    ),
                    verticalSpace(MySizes.spaceBtwSections.r),

                    // ✅ Job Roles Dropdown
                    if (formState.industry != null &&
                        formState.industry!.isNotEmpty) ...[
                      MultiSearchDropdownButton(
                        items: _jobRoles,
                        question: "What are your preferred job roles?",
                        onChanged: (selected) {
                          context.read<FormBloc>().add(
                              UpdateFormEvent(selectedRoles: List<String>.from(selected)));
                        },
                        maxSelection: 5,
                      ),
                      verticalSpace(MySizes.spaceBtwSections.r),
                    ],

                    // ✅ Selected Roles Section
                    if (formState.selectedRoles?.isNotEmpty ?? false) ...[
                      Text('Selected Roles:',
                          style: MYAppTextStyles.titleSmall()),
                      verticalSpace(MySizes.spaceBtwItems.r),
                      Wrap(
                        spacing: MySizes.sm.r,
                        runSpacing: MySizes.sm.r,
                        children: formState.selectedRoles!.map((role) {
                          return Chip(
                            label: Text(role),
                            deleteIcon: const Icon(Icons.close),
                            onDeleted: () => toggleRole(
                                context, role, formState.selectedRoles!),
                          );
                        }).toList(),
                      ),
                      verticalSpace(MySizes.spaceBtwSections.r),
                    ],

                    // ✅ Suggested Roles Section
                    if (_jobRoles.isNotEmpty) ...[
                      Text('Suggested Roles:',
                          style: MYAppTextStyles.titleSmall()),
                      verticalSpace(MySizes.spaceBtwItems.r),
                      Wrap(
                        spacing: MySizes.sm.r,
                        runSpacing: MySizes.sm.r,
                        children:
                        getSuggestedRoles(formState.selectedRoles ?? [])
                            .map((role) {
                          return ActionChip(
                            label: Text(role),
                            onPressed: () => toggleRole(
                                context, role, formState.selectedRoles ?? []),
                          );
                        }).toList(),
                      ),
                      verticalSpace(MySizes.spaceBtwSections.r),
                    ],
                  ],
                ),
              ),
            ),

            // ✅ Complete Button
            bottomNavigationBar: BottomAppBar(
              child: BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is Authenticated) {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/homeScreen', (route) => false);
                  }
                  if(state is AuthError){
                    Bars.showErrorSnackBar(context: context, title: state.message);
                  }
                },
                builder: (context, state) {
                  return state is AuthLoading ? const Center(child: CircularProgressIndicator()) : MYElevatedButton(
                    onPressed: (formState.isComplete())
                        ? () => _onCompleteForm(context)
                        : null,
                    child: const Text('Complete'),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

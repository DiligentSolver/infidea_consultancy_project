import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infidea_consultancy_app/logic/blocs/auth/auth_bloc.dart';
import 'package:infidea_consultancy_app/logic/blocs/auth/auth_event.dart';
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
  final List<String> _allJobRoles = [
    'Software Engineer', 'Product Manager', 'UI/UX Designer', 'Data Scientist',
    'DevOps Engineer', 'Full Stack Developer', 'Frontend Developer', 'Backend Developer',
    'Mobile Developer', 'Cloud Architect', 'Business Analyst', 'Project Manager',
    'Quality Assurance', 'System Administrator', 'Database Administrator', 'Network Engineer',
    'Security Engineer', 'Machine Learning Engineer', 'Technical Writer', 'Scrum Master',
  ];

  List<String> getSuggestedRoles(List<String> selectedRoles) {
    final remainingRoles = _allJobRoles.where((role) => !selectedRoles.contains(role)).toList();
    remainingRoles.shuffle();
    return remainingRoles.take(6).toList();
  }

  void toggleRole(BuildContext context, String role, List<String> selectedRoles) {
    if (selectedRoles.contains(role)) {
      context.read<FormBloc>().add(UpdateFormEvent(selectedRoles: List.from(selectedRoles)..remove(role)));
    } else if (selectedRoles.length < 5) {
      context.read<FormBloc>().add(UpdateFormEvent(selectedRoles: List.from(selectedRoles)..add(role)));
    } else {
      Bars.showCustomToast(context: context, message: 'You can only select up to 5 job roles');
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<FormBloc>().add(LoadFormData());
  }

  void _onCompleteForm(BuildContext context) {
    final formState = context.read<FormBloc>().state;
    if (formState.isComplete()) {
      try{
        context.read<FormBloc>().add(CompleteForm());
      }catch(e){
        print(e);
      }

      // Navigator.pushNamed(context, '/homeScreen');
    } else {
      Bars.showCustomToast(context: context, message: 'Please complete all required fields before submitting.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<FormBloc, UserFormState>(
        listener: (context, formState) {
          formState.copyWith(selectedRoles: formState.selectedRoles);
        },
        builder: (BuildContext context, formState) {

          final List<String> selectedRoles = formState.selectedRoles ?? [];

          return Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  Expanded(
                    child: CustomLinearProgressIndicator(progress: formState.calculateProgress()),
                  ),
                  horizontalSpace(MySizes.spaceBtwItems.r),
                  const Text("Page: 5/5"),
                ],
              ),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: MySizes.defaultSpace.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  verticalSpace(MySizes.defaultSpace.r),
                  Text(
                    'Choose Job Roles',
                    style: MYAppTextStyles.titleLarge(fontWeight: FontWeight.bold),
                  ),
                  verticalSpace(MySizes.spaceBtwSections.r),
                  // ✅ MultiDropdownSelect (Dropdown should NOT show selected roles)
                  MultiDropdownSelect(
                    items: _allJobRoles.where((role) => !selectedRoles.contains(role)).toList(),
                    selectedItems: selectedRoles,
                    isHint: false,
                    maxSelection: 5,
                    question: "Select your preferred job roles (up to 5)",
                    onSelectionChanged: (selected) {
                      context.read<FormBloc>().add(UpdateFormEvent(selectedRoles: selected));
                    },
                  ),

                  verticalSpace(MySizes.spaceBtwItems.r),

                  // ✅ Selected Roles Section
                  if (selectedRoles.isNotEmpty) ...[
                    Text('Selected Roles:', style: MYAppTextStyles.titleSmall()),
                    Wrap(
                      spacing: MySizes.sm.r,
                      runSpacing: MySizes.sm.r,
                      children: selectedRoles.map((role) {
                        return Chip(
                          label: Text(role),
                          deleteIcon: const Icon(Icons.close),
                          onDeleted: () => toggleRole(context, role, selectedRoles),
                        );
                      }).toList(),
                    ),
                  ],

                  verticalSpace(MySizes.spaceBtwSections.r),


                  // ✅ Suggested Roles Section
                  Text('Suggested Roles:', style: MYAppTextStyles.titleSmall()),
                  verticalSpace(MySizes.spaceBtwItems.r),
                  Wrap(
                    spacing: MySizes.sm.r,
                    runSpacing: MySizes.sm.r,
                    children: getSuggestedRoles(selectedRoles).map((role) {
                      return ActionChip(
                        label: Text(role),
                        onPressed: () => toggleRole(context, role, selectedRoles),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // ✅ Complete Button
            bottomNavigationBar: BottomAppBar(
              child: MYElevatedButton(
                onPressed: selectedRoles.isEmpty ? null : () => _onCompleteForm(context),
                child: const Text('Complete'),
              ),
            ),
          );
        },
      ),
    );
  }
}

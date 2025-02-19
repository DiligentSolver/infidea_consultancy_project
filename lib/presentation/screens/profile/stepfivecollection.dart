import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infidea_consultancy_app/core/utils/constants/colors.dart';
import 'package:infidea_consultancy_app/presentation/widgets/input_fields/text_form_field.dart';
import '../../../core/utils/constants/sizes.dart';
import '../../../core/utils/constants/texts.dart';
import '../../../core/utils/helpers/bars.dart';
import '../../../core/utils/text_styles/text_styles.dart';
import '../../../logic/blocs/form/form_bloc.dart';
import '../../../logic/blocs/form/form_event.dart';
import '../../../logic/blocs/form/form_state.dart';
import '../../widgets/buttons/elevated_button.dart';
import '../../widgets/chips/choice_chip_list.dart';

class StepFiveCollection extends StatefulWidget {
  const StepFiveCollection({super.key});

  @override
  State<StepFiveCollection> createState() => _StepFiveCollectionState();
}

class _StepFiveCollectionState extends State<StepFiveCollection> {
  final List<String> _allJobRoles = [
    'Software Engineer',
    'Product Manager',
    'UI/UX Designer',
    'Data Scientist',
    'DevOps Engineer',
    'Full Stack Developer',
    'Frontend Developer',
    'Backend Developer',
    'Mobile Developer',
    'Cloud Architect',
    'Business Analyst',
    'Project Manager',
    'Quality Assurance',
    'System Administrator',
    'Database Administrator',
    'Network Engineer',
    'Security Engineer',
    'Machine Learning Engineer',
    'Technical Writer',
    'Scrum Master',
  ];

  final Set<String> _selectedRoles = {};
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  List<String> get _filteredJobRoles => _allJobRoles
      .where((role) => role.toLowerCase().contains(_searchQuery.toLowerCase()))
      .toList();

  void _handleRoleSelection(String? role) {
    if (role == null) return;

    setState(() {
      if (_selectedRoles.contains(role)) {
        _selectedRoles.remove(role);
      } else {
        if (_selectedRoles.length < 5) {
          _selectedRoles.add(role);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('You can only select up to 5 job roles'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    context.read<FormBloc>().add(LoadFormData());
  }

  void _onCompleteForm(BuildContext context) {
    final formState = context.read<FormBloc>().state;

    if (formState.isComplete()) {
      context.read<FormBloc>().add(SubmitForm());
      Navigator.pushNamed(context, '/dashboard');
    } else {
      Bars.showCustomToast(context: context, message: 'Please complete all required fields before submitting.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<FormBloc,UserFormState>(
        builder: (BuildContext context, formState) { return Scaffold(
          appBar: AppBar(
            title: LinearProgressIndicator(
              minHeight: MySizes.chipPadding,
              borderRadius: BorderRadius.circular(MySizes.borderRadiusLg.r),
              value: formState.calculateProgress(),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal:MySizes.defaultSpace.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpace(MySizes.defaultSpace.r),
                // Search Bar
                 MYInputField(
                   controller: _searchController,
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                     hintText: 'Search job roles...',
                   prefixIcon: const Icon(Icons.search,color: MYColors.secondaryColor,),
                ),
                verticalSpace(MySizes.spaceBtwItems.r),
                // Selected Roles Chips
                if (_selectedRoles.isNotEmpty)...[
                // Selected Roles Count
                  Text(
                    'Selected Roles (${_selectedRoles.length}/5):',
                    style: MYAppTextStyles.titleSmall(),
                  ),
                verticalSpace(MySizes.spaceBtwItems.r),
                  Wrap(
                    spacing: MySizes.spaceBtwItems.r,
                    runSpacing: MySizes.spaceBtwItems.r,
                    children: _selectedRoles.map((role) {
                      return Chip(
                        label: Text(role),
                        deleteIcon: const Icon(Icons.close, size: 18),
                        onDeleted: () => _handleRoleSelection(role),
                      );
                    }).toList(),
                  ),
                  verticalSpace(MySizes.spaceBtwSections.r),
                ],
                // Available Roles
                Text(
                  'Available Roles:',
                  style: MYAppTextStyles.titleSmall(),
                ),
                verticalSpace(MySizes.spaceBtwItems.r),
                // Job Roles Chips
                Expanded(
                  child: SingleChildScrollView(
                    child: CustomChoiceChipList(
                      options: _filteredJobRoles,
                      groupValue: null,
                      onChanged: _handleRoleSelection,
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            child: MYElevatedButton(
              onPressed: _selectedRoles.isEmpty ? null : ()=> _onCompleteForm(context),
              child: const Text('Complete'),
            ),
          )
        );},
      ),
    );
  }
}
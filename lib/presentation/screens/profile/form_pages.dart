import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infidea_consultancy_app/core/utils/constants/sizes.dart';
import 'package:infidea_consultancy_app/logic/blocs/auth/auth_bloc.dart';
import 'package:infidea_consultancy_app/logic/blocs/auth/auth_state.dart';
import 'package:infidea_consultancy_app/logic/blocs/form/form_bloc.dart';
import 'package:infidea_consultancy_app/logic/blocs/form/form_state.dart';
import 'package:infidea_consultancy_app/presentation/widgets/linear_indicator/custom_linear_indicator.dart';

import '../../../logic/blocs/form/form_event.dart';
import 'steponecollection.dart';
import 'steptwocollection.dart';
import 'stepthreecollection.dart';
import 'stepfourcollection.dart';
import 'stepfivecollection.dart';

class MultiStepFormPageView extends StatefulWidget {
  const MultiStepFormPageView({super.key});

  @override
  MultiStepFormPageViewState createState() => MultiStepFormPageViewState();
}

class MultiStepFormPageViewState extends State<MultiStepFormPageView> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Widget> _steps = [
    const StepOneCollection(),
    const StepTwoCollection(),
    const StepThreeCollection(),
    const StepFourCollection(),
    const StepFiveCollection(),
  ];

  // Handle "Back" button press in AppBar
  void _onBackPressed() {
    if (_currentPage > 0) {
      _pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
    } else {
      Navigator.pop(context); // Close the form if on the first page
    }
  }

  void _nextPage() {
    if (_currentPage < _steps.length - 1) {
      _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
    }
  }

  // Functions for each step's Next button
  void _onStepOneNext() {
    final formBloc = context.read<FormBloc>();
    final formState = formBloc.state;

    if (formState.isStepOneValid()) {
      formBloc.add(SubmitForm());
      _nextPage();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('All fields are required')),
      );
    }
  }

  void _onStepTwoNext() {
    final formBloc = context.read<FormBloc>();
    final formState = formBloc.state;

    if (formState.isStepTwoValid()) {
      formBloc.add(SubmitForm());
      _nextPage();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all required fields')),
      );
    }
  }

  void _onStepThreeNext() {
    final formBloc = context.read<FormBloc>();
    final formState = formBloc.state;

    if (formState.isStepThreeValid()) {
      formBloc.add(SubmitForm());
      _nextPage();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Select your education details')),
      );
    }
  }

  void _onStepFourNext() {
    final formBloc = context.read<FormBloc>();
    final formState = formBloc.state;

    if (formState.isStepFourValid()) {
      formBloc.add(SubmitForm());
      _nextPage();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Upload Resume & Profile Picture')),
      );
    }
  }

  void _onSubmitForm() {
    final formBloc = context.read<FormBloc>();
    final formState = formBloc.state;

    if (formState.isComplete()) {
      formBloc.add(CompleteForm(context));
    } else if(formState.selectedRoles!=null){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please complete all required fields before submitting.')),
      );
    }else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Select Job Roles')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: _onBackPressed, // Back button action
          ),
          title: BlocBuilder<FormBloc, UserFormState>(
            builder: (context, formState) => Row(
              children: [
                Expanded(
                  child: CustomLinearProgressIndicator(progress: formState.calculateProgress()),
                ),
                horizontalSpace(MySizes.spaceBtwItems.r),
                Text("Page: ${_currentPage + 1}/${_steps.length}"),
              ],
            ),
          ),
        ),
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (index) {
            setState(() {
              _currentPage = index;
            });
          },
          children: _steps,
        ),
        bottomNavigationBar: BlocConsumer<AuthBloc,AuthState>(
          listener: (context,state){
            if (state is Authenticated) {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/homeScreen', (route) => false);
              }
          },
          builder: (context,state){
            return BottomAppBar(
              child: ElevatedButton(
                onPressed: () {
                  if (_currentPage == 0) {
                    _onStepOneNext();
                  } else if (_currentPage == 1) {_onStepTwoNext();}
                  else if (_currentPage == 2) {_onStepThreeNext();}
                  else if (_currentPage == 3) {_onStepFourNext();}
                  else if (_currentPage == 4) {_onSubmitForm();}
                },
                child: Text(_currentPage == _steps.length - 1 ? "Submit" : "Next"),
              ),
            );
          }
        ),
      ),
    );
  }
}

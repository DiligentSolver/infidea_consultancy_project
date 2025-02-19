import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:infidea_consultancy_app/core/utils/constants/texts.dart';
import 'package:infidea_consultancy_app/logic/blocs/form/form_bloc.dart';
import 'package:infidea_consultancy_app/logic/blocs/form/form_state.dart';
import 'package:infidea_consultancy_app/presentation/widgets/buttons/elevated_button.dart';
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
  State<MultiStepFormPageView> createState() => _MultiStepFormPageViewState();
}

class _MultiStepFormPageViewState extends State<MultiStepFormPageView> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _nextPage() {
    if (_currentPage < 4) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {
        _currentPage++;
      });
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {
        _currentPage--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<FormBloc, UserFormState>(
          builder: (context, formState) {
            return CustomLinearProgressIndicator(progress: formState.calculateProgress());
          },
        ),
      ),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(), // Disable swiping
        children: const [
          StepOneCollection(),
          StepTwoCollection(),
          StepThreeCollection(),
          StepFourCollection(),
          StepFiveCollection(),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (_currentPage > 0)
              MYElevatedButton(
                onPressed: _previousPage,
                child: const Text('Previous'),
              ),
            if (_currentPage < 4)
              MYElevatedButton(
                onPressed: _nextPage,
                child: const Text(MYTexts.next),
              ),
            if (_currentPage == 4)
              BlocBuilder<FormBloc, UserFormState>(
                builder: (context, formState) {
                  return MYElevatedButton(
                    onPressed: () {
                      if (formState.isComplete()) {
                        context.read<FormBloc>().add(SubmitForm());
                        Navigator.pushNamed(context, '/dashboard');
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please complete all required fields before submitting.'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    child: const Text('Complete'),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infidea_consultancy_app/data/model/user_model.dart';
import 'package:infidea_consultancy_app/data/repositories/dropdown_repository.dart';
import 'package:infidea_consultancy_app/logic/blocs/auth/auth_bloc.dart';
import '../auth/auth_event.dart';
import 'form_event.dart';
import 'form_state.dart';
import '../../../data/repositories/auth_repository.dart';

class FormBloc extends Bloc<FormEvent, UserFormState> {
  final AuthRepository authRepository;

  FormBloc(this.authRepository) : super(UserFormState.initial()) {
    on<LoadFormData>(_onLoadFormData);
    on<UpdateFormEvent>(_onUpdateForm);
    on<SubmitForm>(_onSubmitForm);
    on<CompleteForm>(_onCompleteForm);
  }

  Future<void> _onLoadFormData(
      LoadFormData event, Emitter<UserFormState> emit) async {
    final Object? responseData = await authRepository.getSavedUserData();

    final UserModel userData =
    UserModel.fromJson(responseData as Map<String,dynamic>);

    emit(state.copyWith(
      mobile: userData.mobile,
    ));
  }



  void _onUpdateForm(UpdateFormEvent event, Emitter<UserFormState> emit) {
    emit(state.copyWith(
      firstName: event.firstName ?? state.firstName,
      lastName: event.lastName ?? state.lastName,
      fatherName: event.fatherName ?? state.fatherName,
      email: event.email ?? state.email,
      mobile: event.mobile ?? state.mobile,
      dob: event.dob ?? state.dob,
      gender: event.gender ?? state.gender,
      experience: event.experience ?? state.experience,
      state: event.state??state.state,
      currentCity: event.currentCity ?? state.currentCity,
      currentLocality: event.currentLocality ?? state.currentLocality,
      preferredCities: event.preferredCities ?? state.preferredCities,
      isCurrentlyStudying: event.isCurrentlyStudying??state.isCurrentlyStudying,
      educationLevel: event.educationLevel??state.educationLevel,
      languages: event.languages ?? state.languages,
      selectedRoles: event.selectedRoles ?? state.selectedRoles,
      graduateCollege: event.graduateCollege ?? state.graduateCollege,
      graduateDegree: event.graduateDegree ?? state.graduateDegree,
      graduateBranch: event.graduateBranch ?? state.graduateUniversity,
      graduateStartYear: event.graduateStartYear ?? state.graduateStartYear,
      graduateEndYear: event.graduateEndYear ?? state.graduateEndYear,
      graduateUniversity: event.graduateUniversity ?? state.graduateUniversity,
      graduateGrade: event.graduateGrade ?? state.graduateGrade,
      postGraduateCollege:
          event.postGraduateCollege ?? state.postGraduateCollege,
      postGraduateDegree: event.postGraduateDegree ?? state.postGraduateDegree,
      postGraduateStartYear:
          event.postGraduateStartYear ?? state.postGraduateStartYear,
      postGraduateEndYear:
          event.postGraduateEndYear ?? state.postGraduateEndYear,
      postGraduateUniversity:
          event.postGraduateUniversity ?? state.postGraduateUniversity,
      postGraduateBranch: event.postGraduateBranch ?? state.postGraduateBranch,
      postGraduateGrade: event.postGraduateGrade ?? state.postGraduateGrade,
      imageFile: event.imageFile??state.imageFile,
      resumeFile: event.resumeFile??state.resumeFile,
        cities: event.cities??state.cities,
        metroCities: event.metroCities??state.metroCities,
        states: event.states??state.states,
        indoreLocalities: event.indoreLocalities??state.indoreLocalities,
    ));
  }

  Future<void> _onSubmitForm(
      SubmitForm event, Emitter<UserFormState> emit) async {
    await authRepository.sendFormData(state.toJson());
  }

  Future<void> _onCompleteForm(
      CompleteForm event, Emitter<UserFormState> emit) async {
    if (state.isComplete()) {
      final authBloc = BlocProvider.of<AuthBloc>(event.context); // ✅ Get existing AuthBloc
      authBloc.add(RegisterNewUserFormEvent(state.toJson()));
    }
  }

}

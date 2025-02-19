import 'package:bloc/bloc.dart';
import 'package:infidea_consultancy_app/data/model/user_model.dart';
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
    final responseData = await authRepository.getSavedUserData();
    final UserModel userData =
    UserModel.fromJson(responseData as Map<String, dynamic>);

    // Extract first education entry (if available) for correct mapping
    final educationDetails = userData.education.isNotEmpty ? userData.education.first : null;

    emit(state.copyWith(
      firstName: userData.firstName,
      lastName: userData.lastName,
      fatherName: userData.fatherName,
      email: userData.email,
      mobile: userData.mobile,
      dob: DateTime.tryParse(userData.dob)?.toLocal(),
      gender: userData.gender,
      experience: userData.experience,
      currentCity: userData.currentCity,
      currentLocality: userData.currentLocality,
      preferredCities: userData.preferredCities.map((city) => city.city).toList(),
      languages: userData.languagesKnown,
      selectedRoles: userData.preferredRoles ?? [],

      // Education Fields
      educationLevel: educationDetails?.educationLevel ?? '',
      isCurrentlyStudying: educationDetails?.isCurrentlyStudying,
      graduateCollege: educationDetails?.college ?? '',
      graduateDegree: educationDetails?.degree ?? '',
      graduateStartYear: educationDetails?.startingYear ?? '',
      graduateEndYear: educationDetails?.passingYear ?? '',
      graduateUniversity: educationDetails?.university ?? '',
      graduateGrade: educationDetails?.grade ?? '',
      graduateBranch: educationDetails?.branch ?? '',

      postGraduateCollege: educationDetails?.postgraduateCollege ?? '',
      postGraduateDegree: educationDetails?.postgraduateDegree ?? '',
      postGraduateStartYear: educationDetails?.postgraduateStartingYear ?? '',
      postGraduateEndYear: educationDetails?.postgraduatePassingYear ?? '',
      postGraduateUniversity: educationDetails?.postgraduateUniversity ?? '',
      postGraduateBranch: educationDetails?.postgraduateBranch ?? '',
      postGraduateGrade: educationDetails?.postgraduateGrade ?? '',
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
      currentCity: event.currentCity ?? state.currentCity,
      currentLocality: event.currentLocality ?? state.currentLocality,
      preferredCities: event.preferredCities ?? state.preferredCities,
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
    ));
  }

  Future<void> _onSubmitForm(
      SubmitForm event, Emitter<UserFormState> emit) async {
    await authRepository.sendFormData(state.toJson());
  }

  Future<void> _onCompleteForm(
      CompleteForm event, Emitter<UserFormState> emit) async {
    if (state.isComplete()) {
      await authRepository
          .registerNewUser({'user': state.toJson()} as UserModel);
    }
  }
}

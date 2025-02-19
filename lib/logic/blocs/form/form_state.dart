import 'package:equatable/equatable.dart';
import 'package:infidea_consultancy_app/data/model/user_model.dart';

class UserFormState extends Equatable {
  final String? firstName;
  final String? lastName;
  final String? fatherName;
  final String? email;
  final String? mobile;
  final DateTime? dob;
  final String? gender;
  final String? experience;
  final String? currentCity;
  final String? currentLocality;
  final List<String>? preferredCities;
  final List<String>? languages;
  final List<String>? selectedRoles;
  final String? educationLevel;
  final bool? isCurrentlyStudying;
  final String? graduateCollege;
  final String? graduateDegree;
  final String? graduateStartYear;
  final String? graduateEndYear;
  final String? graduateUniversity;
  final String? graduateBranch;
  final String? graduateGrade;
  final String? postGraduateCollege;
  final String? postGraduateDegree;
  final String? postGraduateStartYear;
  final String? postGraduateEndYear;
  final String? postGraduateUniversity;
  final String? postGraduateBranch;
  final String? postGraduateGrade;

  const UserFormState({
    this.firstName,
    this.lastName,
    this.fatherName,
    this.email,
    this.mobile,
    this.dob,
    this.gender,
    this.experience,
    this.currentCity,
    this.currentLocality,
    this.preferredCities,
    this.languages,
    this.selectedRoles,
    this.educationLevel,
    this.isCurrentlyStudying,
    this.graduateCollege,
    this.graduateDegree,
    this.graduateStartYear,
    this.graduateEndYear,
    this.postGraduateCollege,
    this.postGraduateDegree,
    this.postGraduateStartYear,
    this.postGraduateEndYear,
    this.graduateUniversity,
    this.graduateBranch,
    this.graduateGrade,
    this.postGraduateUniversity,
    this.postGraduateBranch,
    this.postGraduateGrade,
  });

  factory UserFormState.initial() {
    return const UserFormState(
      firstName: null,
      lastName: null,
      fatherName: null,
      email: null,
      mobile: null,
      dob: null,
      gender: null,
      experience: null,
      currentCity: null,
      currentLocality: null,
      preferredCities: null,
      languages: null,
      selectedRoles: null,
      educationLevel: null,
      isCurrentlyStudying: null,
      graduateCollege: null,
      graduateDegree: null,
      graduateStartYear: null,
      graduateEndYear: null,
      graduateUniversity: null,
      graduateBranch: null,
      graduateGrade: null,
      postGraduateCollege: null,
      postGraduateDegree: null,
      postGraduateStartYear: null,
      postGraduateEndYear: null,
      postGraduateUniversity: null,
      postGraduateBranch: null,
      postGraduateGrade: null,
    );
  }

  UserFormState copyWith({
    String? firstName,
    String? lastName,
    String? fatherName,
    String? email,
    String? mobile,
    DateTime? dob,
    String? gender,
    String? experience,
    String? currentCity,
    String? currentLocality,
    List<String>? preferredCities,
    List<String>? languages,
    List<String>? selectedRoles,
    String? educationLevel,
    bool? isCurrentlyStudying,
    String? graduateCollege,
    String? graduateDegree,
    String? graduateStartYear,
    String? graduateEndYear,
    String? graduateUniversity,
    String? graduateBranch,
    String? graduateGrade,
    String? postGraduateCollege,
    String? postGraduateDegree,
    String? postGraduateStartYear,
    String? postGraduateEndYear,
    String? postGraduateUniversity,
    String? postGraduateBranch,
    String? postGraduateGrade,
  }) {
    return UserFormState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      fatherName: fatherName ?? this.fatherName,
      email: email ?? this.email,
      mobile: mobile ?? this.mobile,
      dob: dob ?? this.dob,
      gender: gender ?? this.gender,
      experience: experience ?? this.experience,
      currentCity: currentCity ?? this.currentCity,
      currentLocality: currentLocality ?? this.currentLocality,
      preferredCities: preferredCities ?? this.preferredCities,
      languages: languages ?? this.languages,
      selectedRoles: selectedRoles ?? this.selectedRoles,
      educationLevel: educationLevel ?? this.educationLevel,
      isCurrentlyStudying: isCurrentlyStudying ?? this.isCurrentlyStudying,
      graduateCollege: graduateCollege ?? this.graduateCollege,
      graduateDegree: graduateDegree ?? this.graduateDegree,
      graduateStartYear: graduateStartYear ?? this.graduateStartYear,
      graduateEndYear: graduateEndYear ?? this.graduateEndYear,
      graduateUniversity: graduateUniversity??this.graduateUniversity,
      graduateBranch: graduateBranch??this.graduateBranch,
      graduateGrade: graduateGrade??this.graduateGrade,
      postGraduateCollege: postGraduateCollege ?? this.postGraduateCollege,
      postGraduateDegree: postGraduateDegree ?? this.postGraduateDegree,
      postGraduateStartYear:
          postGraduateStartYear ?? this.postGraduateStartYear,
      postGraduateEndYear: postGraduateEndYear ?? this.postGraduateEndYear,
      postGraduateUniversity: postGraduateUniversity??this.postGraduateUniversity,
      postGraduateBranch: postGraduateBranch??this.postGraduateBranch,
      postGraduateGrade: postGraduateGrade??this.postGraduateGrade,
    );
  }

  bool isStepOneValid() {
    return firstName != null &&
        lastName != null &&
        fatherName != null &&
        email != null &&
        dob != null &&
        gender != null &&
        experience != null;
  }

  bool isComplete() {
    return isStepOneValid() &&
        currentCity != null &&
        (currentCity == 'Indore' ? currentLocality != null : true) &&
        preferredCities != null &&
        preferredCities!.isNotEmpty &&
        languages != null &&
        languages!.isNotEmpty &&
        selectedRoles != null &&
        selectedRoles!.isNotEmpty;
  }

  // Add the toJson method here
  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'fatherName': fatherName,
      'email': email,
      'mobile': mobile,
      'dob': dob.toString(),
      'gender': gender,
      'experience': experience,
      'currentCity': currentCity,
      'currentLocality': currentLocality,
      'preferredCities':
          preferredCities?.map((x) => PreferredCity(city: x)).toList(),
      'languagesKnown': languages,
      'selectedRoles': selectedRoles,
      'education': Education(
              degree: graduateDegree ?? '',
              college: graduateCollege ?? '',
              university: graduateUniversity ?? '',
              passingYear: graduateEndYear ?? '',
              startingYear: graduateStartYear ?? '',
              grade: graduateGrade ?? '',
              branch: graduateBranch ?? '',
              isCurrentlyStudying: isCurrentlyStudying,
              educationLevel: educationLevel ?? '',
              postgraduateDegree: postGraduateDegree ?? '',
              postgraduateCollege: postGraduateCollege ?? '',
              postgraduateUniversity: postGraduateUniversity ?? '',
              postgraduatePassingYear: postGraduateEndYear ?? '',
              postgraduateStartingYear: postGraduateStartYear ?? '',
              postgraduateGrade: postGraduateGrade ?? '',
              postgraduateBranch: postGraduateBranch ?? '')
          .toJson(),
    };
  }

  double calculateProgress() {
    int filledFields = 0;
    int totalFields = 23; // Step One + Step Two + Step Three + Step Four + Step Five

    // Step One Fields
    if (firstName?.isNotEmpty ?? false) filledFields++;
    if (lastName?.isNotEmpty ?? false) filledFields++;
    if (fatherName?.isNotEmpty ?? false) filledFields++;
    if (email?.isNotEmpty ?? false) filledFields++;
    if (mobile?.isNotEmpty ?? false) filledFields++;
    if (dob != null) filledFields++;
    if (gender != null) filledFields++;
    if (experience != null) filledFields++;

    // Step Two Fields
    if (currentCity != null) filledFields++;
    if (currentLocality != null) filledFields++;
    if (preferredCities != null && preferredCities!.isNotEmpty) filledFields++;
    if (languages != null && languages!.isNotEmpty) filledFields++;

    // Step Three Fields

    if (isCurrentlyStudying != null) filledFields++;
    if (educationLevel != null) filledFields++;
    if (graduateCollege != null) filledFields++;
    if (graduateDegree != null) filledFields++;
    if (graduateStartYear != null) filledFields++;
    if (graduateEndYear != null) filledFields++;
    if (postGraduateCollege != null) filledFields++;
    if (postGraduateDegree != null) filledFields++;
    if (postGraduateStartYear != null) filledFields++;
    if (postGraduateEndYear != null) filledFields++;

    //Step Four Fields


    // Step Five Fields (Example additional fields)
    if (selectedRoles != null && selectedRoles!.isNotEmpty) filledFields++;

    // Calculate the progress as the ratio of filled fields to total fields
    return filledFields / totalFields;
  }

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        fatherName,
        email,
        mobile,
        dob,
        gender,
        experience,
        currentCity,
        currentLocality,
        preferredCities,
        languages,
        selectedRoles,
        educationLevel,
        isCurrentlyStudying,
        graduateCollege,
        graduateDegree,
        graduateStartYear,
        graduateEndYear,
        postGraduateCollege,
        postGraduateDegree,
        postGraduateStartYear,
        postGraduateEndYear
      ];
}

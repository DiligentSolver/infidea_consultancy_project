import 'dart:io';

class UserForm {
  String? firstName, lastName, fatherName, email, phone, gender, experience, state, city, locality, educationLevel, industry;
  DateTime? dob;
  List<String>? preferredLocations, languages, jobRoles;
  bool? isCurrentlyStudying;
  String? college, degree, startYear, endYear;
  File? profileImage, resume;

  UserForm({
    this.firstName, this.lastName, this.fatherName, this.email, this.phone, this.dob, this.gender, this.experience,
    this.state, this.city, this.locality, this.preferredLocations, this.languages, this.educationLevel, this.isCurrentlyStudying,
    this.college, this.degree, this.startYear, this.endYear, this.industry, this.jobRoles, this.profileImage, this.resume,
  });

  UserForm copyWith({
    String? firstName, String? lastName, String? fatherName, String? email, String? phone, DateTime? dob, String? gender, String? experience,
    String? state, String? city, String? locality, List<String>? preferredLocations, List<String>? languages, String? educationLevel,
    bool? isCurrentlyStudying, String? college, String? degree, String? startYear, String? endYear, String? industry, List<String>? jobRoles,
    File? profileImage, File? resume,
  }) {
    return UserForm(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      fatherName: fatherName ?? this.fatherName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      dob: dob ?? this.dob,
      gender: gender ?? this.gender,
      experience: experience ?? this.experience,
      state: state ?? this.state,
      city: city ?? this.city,
      locality: locality ?? this.locality,
      preferredLocations: preferredLocations ?? this.preferredLocations,
      languages: languages ?? this.languages,
      educationLevel: educationLevel ?? this.educationLevel,
      isCurrentlyStudying: isCurrentlyStudying ?? this.isCurrentlyStudying,
      college: college ?? this.college,
      degree: degree ?? this.degree,
      startYear: startYear ?? this.startYear,
      endYear: endYear ?? this.endYear,
      industry: industry ?? this.industry,
      jobRoles: jobRoles ?? this.jobRoles,
      profileImage: profileImage ?? this.profileImage,
      resume: resume ?? this.resume,
    );
  }
}

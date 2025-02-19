import 'package:equatable/equatable.dart';

abstract class FormEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// Load saved form data from storage
class LoadFormData extends FormEvent {}

// Update form fields dynamically
class UpdateFormEvent extends FormEvent {
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

  UpdateFormEvent({
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

  @override
  List<Object?> get props => [
    firstName, lastName, fatherName, email, mobile, dob,
    gender, experience, currentCity, currentLocality,
    preferredCities, languages, selectedRoles, educationLevel,
    isCurrentlyStudying, graduateCollege, graduateDegree,
    graduateStartYear, graduateEndYear, graduateUniversity,graduateBranch,graduateGrade,postGraduateCollege,
    postGraduateDegree, postGraduateStartYear, postGraduateEndYear,postGraduateUniversity,postGraduateBranch,postGraduateGrade
  ];
}

// Submit form data after each step
class SubmitForm extends FormEvent {}

// Final submission after completing all steps
class CompleteForm extends FormEvent {}

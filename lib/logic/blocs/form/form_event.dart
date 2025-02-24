import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

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
  final String? state;
  final List<Map<String, dynamic>>? states;
  final List<String>? cities;
  final List<String>? metroCities;
  final List<String>? indoreLocalities;
  final String? currentCity;
  final String? currentLocality;
  final String? industry;
  final List<String>? preferredCities;
  final List<String>? languages;
  final List<String>? selectedRoles;
  final String? educationLevel;
  final String? isCurrentlyStudying;
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
  final File? resumeFile;
  final File? imageFile;

  UpdateFormEvent( {
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
    this.industry,
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
    this.imageFile,
    this.resumeFile,
    this.state,
    this.metroCities,
    this.states,
    this.cities,
    this.indoreLocalities
  });

  @override
  List<Object?> get props => [
    firstName, lastName, fatherName, email, mobile, dob,
    gender, experience, state,currentCity, currentLocality,
    preferredCities, languages, selectedRoles, educationLevel,
    isCurrentlyStudying, graduateCollege, graduateDegree, industry,
    graduateStartYear, graduateEndYear, graduateUniversity,graduateBranch,graduateGrade,postGraduateCollege,
    postGraduateDegree, postGraduateStartYear, postGraduateEndYear,postGraduateUniversity,postGraduateBranch,postGraduateGrade,resumeFile,imageFile,indoreLocalities,cities,metroCities,states
  ];
}

// Submit form data after each step
class SubmitForm extends FormEvent {}

// Final submission after completing all steps
class CompleteForm extends FormEvent {
  final BuildContext context;  // ✅ Add context parameter
  CompleteForm(this.context);
}

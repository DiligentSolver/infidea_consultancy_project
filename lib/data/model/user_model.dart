class UserModel {
  final String? id;
  final String? token;
  final String? mobile;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? fatherName;
  final String? dob;
  final int? calculatedAge;
  final String? gender;
  final String? experience;
  final List<ExperienceDetail>? experienceDetails;
  final String? currentCity;
  final String? currentLocality;
  final List<PreferredCity>? preferredCities;
  final List<String>? skills;
  final List<String>? languagesKnown;
  final String? currentAddress;
  final List<Education>? education;
  final List<Certification>? certifications;
  final String? resume;
  final String? passportPhoto;
  final String? portfolio;
  final String? linkedInId;
  final String? about;
  final List<Project>? projects;
  final String? expectedSalary;
  final String? jobType;
  final String? industry;
  final List<String>? preferredRoles;
  final String? workMode;
  final String? noticePeriod;
  final bool? willingToRelocate;
  final bool? isAdmin;
  final bool? isVerified;
  final bool? isEmployer;
  final bool? isEmailVerified;
  final DateTime? otpExpiry;
  final Location? location;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserModel({
    this.token,
    this.id,
    this.mobile,
    this.email,
    this.firstName,
    this.lastName,
    this.fatherName,
    this.dob,
    this.calculatedAge,
    this.gender,
    this.experience,
    this.experienceDetails,
    this.currentCity,
    this.currentLocality,
    this.preferredCities,
    this.skills,
    this.languagesKnown,
    this.currentAddress,
    this.education,
    this.certifications,
    this.resume,
    this.passportPhoto,
    this.portfolio,
    this.linkedInId,
    this.about,
    this.projects,
    this.expectedSalary,
    this.jobType,
    this.industry,
    this.preferredRoles,
    this.workMode,
    this.noticePeriod,
    this.willingToRelocate,
    this.isAdmin,
    this.isVerified,
    this.isEmployer,
    this.isEmailVerified,
    this.otpExpiry,
    this.location,
    this.createdAt,
    this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    try {
      final userData = json['user'] as Map<String, dynamic>?;
      return UserModel(
        token: json['token'],
        id: userData?['_id'],
        mobile: userData?['mobile'],
        email: userData?['email'],
        firstName: userData?['firstName'],
        lastName: userData?['lastName'],
        fatherName: userData?['fatherName'],
        dob: userData?['dob'],
        calculatedAge: userData?['calculatedAge'],
        gender: userData?['gender'],
        experience: userData?['experience'],
        experienceDetails: (userData?['experienceDetails'] as List?)
            ?.map((x) => ExperienceDetail.fromJson(x))
            .toList(),
        currentCity: userData?['currentCity'],
        currentLocality: userData?['currentLocality'],
        preferredCities: (userData?['preferredCities'] as List?)
            ?.map((x) => PreferredCity.fromJson(x))
            .toList(),
        skills: (userData?['skills'] as List?)?.cast<String>(),
        languagesKnown: (userData?['languagesKnown'] as List?)?.cast<String>(),
        currentAddress: userData?['currentAddress'],
        education: (userData?['education'] as List?)
            ?.map((x) => Education.fromJson(x))
            .toList(),
        certifications: (userData?['certifications'] as List?)
            ?.map((x) => Certification.fromJson(x))
            .toList(),
        resume: userData?['resume'],
        passportPhoto: userData?['passportPhoto'],
        portfolio: userData?['portfolio'],
        linkedInId: userData?['linkedInId'],
        about: userData?['about'],
        projects: (userData?['projects'] as List?)
            ?.map((x) => Project.fromJson(x))
            .toList(),
        expectedSalary: userData?['expectedSalary'],
        jobType: userData?['jobType'],
        industry: userData?['industry'],
        preferredRoles: (userData?['preferredRoles'] as List?)?.cast<String>(),
        workMode: userData?['workMode'],
        noticePeriod: userData?['noticePeriod'],
        willingToRelocate: userData?['willingToRelocate'],
        isAdmin: userData?['isAdmin'],
        isVerified: userData?['isVerified'],
        isEmployer: userData?['isEmployer'],
        isEmailVerified: userData?['isEmailVerified'],
        otpExpiry: userData?['otpExpiry'] != null
            ? DateTime.tryParse(userData?['otpExpiry'])
            : null,
        location: userData?['location'] != null
            ? Location.fromJson(userData?['location'])
            : null,
        createdAt: userData?['createdAt'] != null
            ? DateTime.tryParse(userData?['createdAt'])
            : null,
        updatedAt: userData?['updatedAt'] != null
            ? DateTime.tryParse(userData?['updatedAt'])
            : null,
      );
    } catch (e) {
      throw FormatException('Failed to parse UserModel: $e');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'mobile': mobile,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'fatherName': fatherName,
      'dob': dob,
      'calculatedAge': calculatedAge,
      'gender': gender,
      'experience': experience,
      'experienceDetails': experienceDetails?.map((x) => x.toJson()).toList(),
      'currentCity': currentCity,
      'currentLocality': currentLocality,
      'preferredCities': preferredCities?.map((x) => x.toJson()).toList(),
      'skills': skills,
      'languagesKnown': languagesKnown,
      'currentAddress': currentAddress,
      'education': education?.map((x) => x.toJson()).toList(),
      'certifications': certifications?.map((x) => x.toJson()).toList(),
      'resume': resume,
      'passportPhoto': passportPhoto,
      'portfolio': portfolio,
      'linkedInId': linkedInId,
      'about': about,
      'projects': projects?.map((x) => x.toJson()).toList(),
      'expectedSalary': expectedSalary,
      'jobType': jobType,
      'industry': industry,
      'preferredRoles': preferredRoles,
      'workMode': workMode,
      'noticePeriod': noticePeriod,
      'willingToRelocate': willingToRelocate,
      'isAdmin': isAdmin,
      'isVerified': isVerified,
      'isEmployer': isEmployer,
      'isEmailVerified': isEmailVerified,
      'otpExpiry': otpExpiry?.toIso8601String(),
      'location': location?.toJson(),
    };
  }
}

class ExperienceDetail {
  final String? companyName;
  final String? role;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? salary;
  final String? reasonForLeaving;
  final String? responsibilities;

  ExperienceDetail({
    this.companyName,
    this.role,
    this.startDate,
    this.endDate,
    this.salary,
    this.reasonForLeaving,
    this.responsibilities,
  });

  factory ExperienceDetail.fromJson(Map<String, dynamic> json) {
    try {
      return ExperienceDetail(
        companyName: json['companyName'],
        role: json['role'],
        startDate: json['startDate'] != null
            ? DateTime.tryParse(json['startDate'])
            : null,
        endDate:
        json['endDate'] != null ? DateTime.tryParse(json['endDate']) : null,
        salary: json['salary'],
        reasonForLeaving: json['reasonForLeaving'],
        responsibilities: json['responsibilities'],
      );
    } catch (e) {
      throw FormatException('Failed to parse ExperienceDetail: $e');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'companyName': companyName,
      'role': role,
      'startDate': startDate?.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'salary': salary,
      'reasonForLeaving': reasonForLeaving,
      'responsibilities': responsibilities,
    };
  }
}

class PreferredCity {
  final String? city;

  PreferredCity({this.city});

  factory PreferredCity.fromJson(Map<String, dynamic> json) {
    try {
      return PreferredCity(city: json['city']);
    } catch (e) {
      throw FormatException('Failed to parse PreferredCity: $e');
    }
  }

  Map<String, dynamic> toJson() {
    return {'city': city};
  }
}

class Education {
  final String? degree;
  final String? college;
  final String? university;
  final String? passingYear;
  final String? startingYear;
  final String? grade;
  final String? branch;
  final bool? isCurrentlyStudying;
  final String? educationLevel;
  final String? postgraduateDegree;
  final String? postgraduateCollege;
  final String? postgraduateUniversity;
  final String? postgraduatePassingYear;
  final String? postgraduateStartingYear;
  final String? postgraduateGrade;
  final String? postgraduateBranch;

  Education({
    this.degree,
    this.college,
    this.university,
    this.passingYear,
    this.startingYear,
    this.grade,
    this.branch,
    this.postgraduateDegree,
    this.postgraduateCollege,
    this.postgraduateUniversity,
    this.postgraduatePassingYear,
    this.postgraduateStartingYear,
    this.postgraduateGrade,
    this.postgraduateBranch,
    this.isCurrentlyStudying,
    this.educationLevel,
  });

  factory Education.fromJson(Map<String, dynamic> json) {
    try {
      return Education(
        degree: json['degree'],
        college: json['college'],
        university: json['university'],
        passingYear: json['passingYear'],
        startingYear: json['startingYear'],
        grade: json['grade'],
        branch: json['branch'],
        isCurrentlyStudying: json['isCurrentlyStudying'],
        educationLevel: json['educationLevel'],
        postgraduateDegree: json['postgraduateDegree'],
        postgraduateCollege: json['postgraduateCollege'],
        postgraduateUniversity: json['postgraduateUniversity'],
        postgraduatePassingYear: json['postgraduatePassingYear'],
        postgraduateStartingYear: json['postgraduateStartingYear'],
        postgraduateGrade: json['postgraduateGrade'],
        postgraduateBranch: json['postgraduateBranch'],
      );
    } catch (e) {
      throw FormatException('Failed to parse Education: $e');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'degree': degree,
      'college': college,
      'university': university,
      'passingYear': passingYear,
      'startingYear': startingYear,
      'grade': grade,
      'branch': branch,
      'isCurrentlyStudying': isCurrentlyStudying,
      'educationLevel': educationLevel,
      'postgraduateDegree': postgraduateDegree,
      'postgraduateCollege': postgraduateCollege,
      'postgraduateUniversity': postgraduateUniversity,
      'postgraduatePassingYear': postgraduatePassingYear,
      'postgraduateStartingYear': postgraduateStartingYear,
      'postgraduateGrade': postgraduateGrade,
      'postgraduateBranch': postgraduateBranch,
    };
  }
}

class Certification {
  final String? name;
  final String? issuingOrganization;
  final DateTime? issueDate;

  Certification({
    this.name,
    this.issuingOrganization,
    this.issueDate,
  });

  factory Certification.fromJson(Map<String, dynamic> json) {
    try {
      return Certification(
        name: json['name'],
        issuingOrganization: json['issuingOrganization'],
        issueDate: json['issueDate'] != null
            ? DateTime.tryParse(json['issueDate'])
            : null,
      );
    } catch (e) {
      throw FormatException('Failed to parse Certification: $e');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'issuingOrganization': issuingOrganization,
      'issueDate': issueDate?.toIso8601String(),
    };
  }
}

class Project {
  final String? title;
  final String? description;
  final List<String>? technologies;
  final String? link;

  Project({
    this.title,
    this.description,
    this.technologies,
    this.link,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    try {
      return Project(
        title: json['title'],
        description: json['description'],
        technologies: (json['technologies'] as List?)?.cast<String>(),
        link: json['link'],
      );
    } catch (e) {
      throw FormatException('Failed to parse Project: $e');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'technologies': technologies,
      'link': link,
    };
  }
}

class Location {
  final String? type;
  final List<double>? coordinates;

  Location({
    this.type,
    this.coordinates,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    try {
      return Location(
        type: json['type'],
        coordinates: (json['coordinates'] as List?)?.map((e) => (e as num).toDouble()).toList(),
      );
    } catch (e) {
      throw FormatException('Failed to parse Location: $e');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'coordinates': coordinates,
    };
  }
}
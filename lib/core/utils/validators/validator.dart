class MYValidator {

  // Email Validation
  static String? validateEmail(String? value) {
    final RegExp emailRegex =
    RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z][a-zA-Z0-9.-]*\.[a-zA-Z]{2,}$');

    if (value == null || value.isEmpty) {
      return 'Email is required.';
    }
    if (!emailRegex.hasMatch(value)) {
      return 'Invalid email address.';
    }
    return null;
  }

  // // Email or Phone Validation (Common ID Login)
  // static String? validateEmailOrPhone(String? value) {
  //   final RegExp emailRegex =
  //   RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z][a-zA-Z0-9.-]*\.[a-zA-Z]{2,}$');
  //   final RegExp phoneRegex = RegExp(r'^\+91[6-9]\d{9}$'); // Enforce "+91"
  //
  //   if (value == null || value.isEmpty) {
  //     return 'Email or phone number is required.';
  //   }
  //   if (!emailRegex.hasMatch(value) && !phoneRegex.hasMatch(value)) {
  //     return 'Enter a valid email or phone number (Phone must start with +91).';
  //   }
  //   return null;
  // }

  // Phone Number Validation (Only "+91" format allowed)
  static String? validatePhoneNumber(String? value) {
    final RegExp mobileRegExp = RegExp(r'^[6-9]\d{9}$');

    if (value!.isEmpty) {
      return 'Phone number is required.';
    }

    if(value.startsWith("+")){
      return 'Country code is already in use.';
    }

    if (value.length>=10 &&!mobileRegExp.hasMatch(value)) {
      return 'Phone number must be 10 digits long.';
    }
    return null;
  }

  /// Validates First Name & Last Name
  static String? validateName(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return "$fieldName is required";
    }
    if (!RegExp(r"^[A-Za-z]{2,30}$").hasMatch(value.trim())) {
      return "$fieldName atleast 2 character";
    }
    return null;
  }

  /// Validates Father's Name (Allows Spaces)
  static String? validateFatherName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Father’s Name is required";
    }
    if (!RegExp(r"^[A-Za-z ]{2,40}$").hasMatch(value.trim())) {
      return "Father’s Name must contain only letters & spaces";
    }
    return null;
  }

  // // Password Validation (Strong)
  // // Enhanced Password Validation
  // static String? validatePassword(String? value) {
  //   if (value == null || value.isEmpty) {
  //     return 'Password is required.';
  //   }
  //
  //   bool hasUpperCase = RegExp(r'[A-Z]').hasMatch(value);
  //   bool hasLowerCase = RegExp(r'[a-z]').hasMatch(value);
  //   bool hasDigit = RegExp(r'\d').hasMatch(value);
  //   bool hasSpecialChar =
  //   RegExp(r'[!@#$%^&*()_+{}\[\]:;<>,.?~\\/-]').hasMatch(value);
  //   bool hasMinLength = value.length >= 8;
  //
  //   List<String> missingConditions = [];
  //
  //   if (!hasMinLength) missingConditions.add('- At least 8 characters long');
  //
  //   if (missingConditions.isNotEmpty) {
  //     return 'Password must include:\n${missingConditions.join('\n')}';
  //   }
  //
  //   return null; // ✅ Password is valid
  // }

  // static String? validateLoginPassword(String? value) {
  //   if (value == null || value.isEmpty) {
  //     return 'Password is required.'; // Password cannot be empty
  //   }
  //
  //   return null; // ✅ Password is valid
  // }

}

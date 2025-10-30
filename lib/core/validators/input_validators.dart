class InputValidators {
  // 🔹 Email Validator
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email address';
    }

    return null;
  }

  // 🔹 Name Validator
  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Name is required';
    }

    if (value.length < 2) {
      return 'Name must be at least 2 characters';
    }

    return null;
  }
  // 🔹 Validator Field
  static String? validateField(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Field is required';
    }
    return null;
  }

  // 🔹 Password Validator
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }

    return null;
  }
  // 🔹 Phone Validator
  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone is required';
    }

    if (value.length != 10) {
      return 'Phone must be at  10 characters';
    }

    return null;
  }

  // 🔹 Confirm Password Validator
  static String? validateConfirmPassword(String? value, String originalPassword) {
    if (value == null || value.isEmpty) {
      return 'Confirm Password is required';
    }

    if (value != originalPassword) {
      return 'Passwords do not match';
    }

    return null;
  }
}

String? validateEmail(String? email) {
  if (email == null || email.isEmpty) {
    return "The email field cannot be empty!";
  } else if (!email.contains("@")) {
    return "The input should be an email!";
  }
  return null;
}

String? validatePassword(String? password) {
  if (password == null || password.isEmpty) {
    return "Password cannot be empty!";
  }
  return null;
}

String? validateConfirmPassword(String? confirmPassword, String? password) {
  if (confirmPassword == null || confirmPassword.isEmpty) {
    return "You must fill in the confirm password field.";
  } else if (confirmPassword != password) {
    return "Your password does not match.";
  }
  return null;
}

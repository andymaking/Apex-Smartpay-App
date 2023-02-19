var hasUpperCase = RegExp(r'[A-Z]');
var hasLowerCase = RegExp(r'[a-z]');
//var hasSymbols = RegExp(r"[!@#$%^&*(),\|+=;.?':{}|<>]");
var hasANumber = RegExp('(?=.*?[0-9])');

bool validatePassword(String? text) {
  bool validPassword = false;
  if (text == null) {
    validPassword = false;
  } else if (text.isEmpty) {
    validPassword = false;
  } else if (text.length <= 7) {
    validPassword = false;
  } else if (!hasANumber.hasMatch(text)) {
    validPassword = false;
  } else if (!hasLowerCase.hasMatch(text)) {
    validPassword = false;
  }
  // else if (!hasSymbols.hasMatch(text)) {
  //   validPassword = false;
  // }
  else if (!hasUpperCase.hasMatch(text)) {
    validPassword = false;
  } else {
    validPassword = true;
  }
  return validPassword;
}

PasswordStrength checkPasswordStrength(String password) {
  var strength;
  if (password.isEmpty) {
    strength = PasswordStrength.weak;
  } else {
    if (password.length <= 7) {
      strength = PasswordStrength.weak;
    } else if (validatePassword(password)) {
      strength = PasswordStrength.strong;
    } else {
      strength = PasswordStrength.average;
    }
  }
  return strength;
}

enum PasswordStrength {
  weak,
  average,
  strong,
}

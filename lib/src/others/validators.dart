import '../../my_services.dart';

// ignore: prefer_function_declarations_over_variables
FormFieldValidator<String> defaultFieldRequiredValidator = (String? value) {
  if (value == null || value.trim().isEmpty) {
    MyServicesLocalizationsData myServicesLabels = getMyServicesLabels(MyServices.context);
    return myServicesLabels.thisFieldIsRequired;
  }
  return null;
};

// ignore: prefer_function_declarations_over_variables
FormFieldValidator<String> defaultEmailValidator = (String? value) {
  value = value?.trim();
  final RegExp emailRxp = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');

  if (value == null || value.isEmpty || !emailRxp.hasMatch(value)) {
    MyServicesLocalizationsData myServicesLabels = getMyServicesLabels(MyServices.context);
    return myServicesLabels.incorrectEmail;
  }
  return null;
};

FormFieldValidator<String> defaultPasswordValidator({int length = 6}) => (String? value) {
      MyServicesLocalizationsData myServicesLabels = getMyServicesLabels(MyServices.context);

      if (value == null || value.isEmpty) {
        return myServicesLabels.enterAPassword;
      } else if (value.length < length) {
        return myServicesLabels.passwordLengthMustBeAtLeastCharacters;
      }
      return null;
    };

FormFieldValidator<String> defaultNewPasswordValidator({int length = 6}) => (String? value) {
      MyServicesLocalizationsData myServicesLabels = getMyServicesLabels(MyServices.context);

      if (value == null || value.isEmpty) {
        return myServicesLabels.enterANewPassword;
      } else if (value.length < length) {
        return myServicesLabels.passwordLengthMustBeAtLeastCharacters;
      }
      return null;
    };

FormFieldValidator<String> defaultCurrentPasswordValidator({int length = 6}) => (String? value) {
      MyServicesLocalizationsData myServicesLabels = getMyServicesLabels(MyServices.context);

      if (value == null || value.isEmpty) {
        return myServicesLabels.enterTheCurrentPassword;
      } else if (value.length < length) {
        return myServicesLabels.passwordLengthMustBeAtLeastCharacters;
      }
      return null;
    };

FormFieldValidator<String> defaultNameValidator = (String? value) {
  MyServicesLocalizationsData myServicesLabels = getMyServicesLabels(MyServices.context);

  if (value == null || value.isEmpty) {
    return myServicesLabels.enterTheNameCorrectly;
  }
  return null;
};

FormFieldValidator<String> defaultCodeValidator({int length = 4}) => (String? value) {
      MyServicesLocalizationsData myServicesLabels = getMyServicesLabels(MyServices.context);

      if (value == null || value.isEmpty || value.length < length) {
        return myServicesLabels.invalidRecoveryCode;
      }
      return null;
    };

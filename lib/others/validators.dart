import '../my_services.dart';

// ignore: prefer_function_declarations_over_variables
FormFieldValidator<String> fieldIsRequiredValidator = (String? value) {
  MyServicesLocalizationsData myServicesLabels = getMyServicesLabels(ServiceNav.navigatorKey.currentContext!);

  if (value == null || value.trim().isEmpty) {
    return myServicesLabels.thisFieldIsRequired;
  }
  return null;
};

import 'package:genie_luck/l10n/generated/app_localizations.dart';

class Validators {
  final AppLocalizations locale;

  Validators(this.locale);

  String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return locale.errorNameRequired;
    }
    final words = value.trim().split(RegExp(r'\s+'));
    if (words.length < 2) {
      return locale.errorFullNameRequired;
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return locale.errorEmailRequired;
    }
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (!emailRegex.hasMatch(value)) {
      return locale.errorInvalidEmail;
    }
    return null;
  }

  String? validatePassword(String? value) {
    List<String?> errors = [];
    if (value == null || value.isEmpty) {
      errors.add(locale.errorPasswordRequired);
    } else {
      if (value.length < 8) {
        errors.add(locale.errorPasswordMinLength);
      }
      final hasUppercase = value.contains(RegExp(r'[A-Z]'));
      final hasLowercase = value.contains(RegExp(r'[a-z]'));
      final hasNumber = value.contains(RegExp(r'[0-9]'));
      final hasSpecialChar = value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

      if (!hasUppercase) errors.add(locale.errorPasswordUppercase);
      if (!hasLowercase) errors.add(locale.errorPasswordLowercase);
      if (!hasNumber) errors.add(locale.errorPasswordNumber);
      if (!hasSpecialChar) errors.add(locale.errorPasswordSpecialChar);
    }
    if (errors.isEmpty) return null;
    return errors.join('\n');
  }

  String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return locale.errorConfirmPasswordRequired;
    }
    if (value != password) {
      return locale.errorPasswordsDoNotMatch;
    }
    return null;
  }

  String? validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return locale.errorDateRequired;
    }
    return null;
  }

  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return locale.errorPhoneRequired;
    }
    return null;
  }

  String? validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return locale.errorAddressRequired;
    }
    return null;
  }

  String? validateAddressNumber(String? value) {
    if (value == null || value.isEmpty) {
      return locale.errorAddressNumberRequired;
    }
    return null;
  }

  String? validateNeighborhood(String? value) {
    if (value == null || value.isEmpty) {
      return locale.errorNeighborhoodRequired;
    }
    return null;
  }

  String? validateCity(String? value) {
    if (value == null || value.isEmpty) {
      return locale.errorCityRequired;
    }
    return null;
  }

  String? validateState(String? value) {
    if (value == null || value.isEmpty) {
      return locale.errorStateRequired;
    }
    return null;
  }

  String? validateZipCode(String? value) {
    if (value == null || value.isEmpty) {
      return locale.errorZipCodeRequired;
    }

    return null;
  }

  String? validateCountry(String? value) {
    if (value == null || value.isEmpty) {
      return locale.errorCountryRequired;
    }
    return null;
  }
}

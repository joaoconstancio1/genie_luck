// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get registerTitle => 'Create Your Account and Take Action!';

  @override
  String get labelCompleteName => 'Complete Name';

  @override
  String get hintCompleteName => 'Enter your full name';

  @override
  String get labelEmail => 'Email';

  @override
  String get hintEmail => 'example@email.com';

  @override
  String get labelPassword => 'Password';

  @override
  String get hintPassword => 'Enter your password';

  @override
  String get labelConfirmPassword => 'Confirm Password';

  @override
  String get hintConfirmPassword => 'Confirm your password';

  @override
  String get labelBirthDate => 'Birth Date';

  @override
  String get hintBirthDate => '01/01/2000';

  @override
  String get labelPhoneNumber => 'Phone Number';

  @override
  String get hintPhoneNumber => '99999-9999';

  @override
  String get labelAcceptTerms => 'Accept Terms and Conditions';

  @override
  String get labelReceivePromotions => 'Receive Promotions';

  @override
  String get buttonRegisterNow => 'Register';

  @override
  String get labelZipCode => 'ZIP Code';

  @override
  String get hintZipCode => 'Enter your ZIP code';

  @override
  String get labelAddress => 'Address';

  @override
  String get hintAddress => 'Enter your address';

  @override
  String get labelSearchAddress => 'Search your address';

  @override
  String get hintSearchAddress => 'Example: ABC Avenue 123';

  @override
  String get labelAddressNumber => 'Number';

  @override
  String get hintAddressNumber => '999';

  @override
  String get labelCity => 'City';

  @override
  String get hintCity => 'Enter your city';

  @override
  String get labelState => 'State';

  @override
  String get hintState => 'Enter your state';

  @override
  String get labelCountry => 'Country';

  @override
  String get hintCountry => 'Enter your country';

  @override
  String get labelComplement => 'Complement';

  @override
  String get hintComplement => 'Block, Apartment, etc.';

  @override
  String get labelNeighborhood => 'Neighborhood';

  @override
  String get hintNeighborhood => 'Enter your neighborhood';

  @override
  String get back => 'Back';

  @override
  String get next => 'Next';

  @override
  String get searchCountry => 'Search country';

  @override
  String get loading => 'Loading...';

  @override
  String get errorNameRequired => 'The full name field is required';

  @override
  String get errorFullNameRequired => 'The name must contain at least two words';

  @override
  String get errorEmailRequired => 'The email field is required';

  @override
  String get errorInvalidEmail => 'Invalid email';

  @override
  String get errorPasswordRequired => 'The password field is required';

  @override
  String get errorPasswordMinLength => 'The password must have at least 8 characters';

  @override
  String get errorPasswordUppercase => 'The password must have an uppercase letter';

  @override
  String get errorPasswordLowercase => 'The password must have a lowercase letter';

  @override
  String get errorPasswordNumber => 'The password must have a number';

  @override
  String get errorPasswordSpecialChar => 'The password must have a special character';

  @override
  String get errorConfirmPasswordRequired => 'The confirm password field is required';

  @override
  String get errorPasswordsDoNotMatch => 'The passwords do not match';

  @override
  String get errorDateRequired => 'The birth date field is required';

  @override
  String get errorPhoneRequired => 'The phone number field is required';

  @override
  String get errorAddressRequired => 'The address field is required';

  @override
  String get errorAddressNumberRequired => 'The address number field is required';

  @override
  String get errorNeighborhoodRequired => 'The neighborhood field is required';

  @override
  String get errorCityRequired => 'The city field is required';

  @override
  String get errorStateRequired => 'The state field is required';

  @override
  String get errorZipCodeRequired => 'The ZIP code field is required';

  @override
  String get errorInvalidZipCode => 'The ZIP code must have 8 digits';

  @override
  String get errorCountryRequired => 'The country field is required';

  @override
  String get errorAddressSearchRequired => 'Please search and select an address';
}

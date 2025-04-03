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
  String get buttonRegisterNow => 'Register Now';
}

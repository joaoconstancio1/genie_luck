import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('pt'),
  ];

  /// No description provided for @registerTitle.
  ///
  /// In pt, this message translates to:
  /// **'Crie Sua Conta e Entre em Ação!'**
  String get registerTitle;

  /// No description provided for @labelCompleteName.
  ///
  /// In pt, this message translates to:
  /// **'Nome Completo'**
  String get labelCompleteName;

  /// No description provided for @hintCompleteName.
  ///
  /// In pt, this message translates to:
  /// **'Digite seu nome completo'**
  String get hintCompleteName;

  /// No description provided for @labelEmail.
  ///
  /// In pt, this message translates to:
  /// **'E-mail'**
  String get labelEmail;

  /// No description provided for @hintEmail.
  ///
  /// In pt, this message translates to:
  /// **'example@email.com'**
  String get hintEmail;

  /// No description provided for @labelPassword.
  ///
  /// In pt, this message translates to:
  /// **'Senha'**
  String get labelPassword;

  /// No description provided for @hintPassword.
  ///
  /// In pt, this message translates to:
  /// **'Digite sua senha'**
  String get hintPassword;

  /// No description provided for @labelConfirmPassword.
  ///
  /// In pt, this message translates to:
  /// **'Confirme a Senha'**
  String get labelConfirmPassword;

  /// No description provided for @hintConfirmPassword.
  ///
  /// In pt, this message translates to:
  /// **'Confirme sua senha'**
  String get hintConfirmPassword;

  /// No description provided for @labelBirthDate.
  ///
  /// In pt, this message translates to:
  /// **'Data de Nascimento'**
  String get labelBirthDate;

  /// No description provided for @hintBirthDate.
  ///
  /// In pt, this message translates to:
  /// **'01/01/2000'**
  String get hintBirthDate;

  /// No description provided for @labelPhoneNumber.
  ///
  /// In pt, this message translates to:
  /// **'Número de Telefone'**
  String get labelPhoneNumber;

  /// No description provided for @hintPhoneNumber.
  ///
  /// In pt, this message translates to:
  /// **'99999-9999'**
  String get hintPhoneNumber;

  /// No description provided for @labelAcceptTerms.
  ///
  /// In pt, this message translates to:
  /// **'Aceitar Termos e Condições'**
  String get labelAcceptTerms;

  /// No description provided for @labelReceivePromotions.
  ///
  /// In pt, this message translates to:
  /// **'Receber Promoções'**
  String get labelReceivePromotions;

  /// No description provided for @buttonRegisterNow.
  ///
  /// In pt, this message translates to:
  /// **'Registrar Agora'**
  String get buttonRegisterNow;

  /// No description provided for @labelZipCode.
  ///
  /// In pt, this message translates to:
  /// **'CEP'**
  String get labelZipCode;

  /// No description provided for @hintZipCode.
  ///
  /// In pt, this message translates to:
  /// **'Digite seu CEP'**
  String get hintZipCode;

  /// No description provided for @labelAddress.
  ///
  /// In pt, this message translates to:
  /// **'Endereço'**
  String get labelAddress;

  /// No description provided for @hintAddress.
  ///
  /// In pt, this message translates to:
  /// **'Digite seu endereço'**
  String get hintAddress;

  /// No description provided for @labelAddressNumber.
  ///
  /// In pt, this message translates to:
  /// **'Número'**
  String get labelAddressNumber;

  /// No description provided for @hintAddressNumber.
  ///
  /// In pt, this message translates to:
  /// **'999'**
  String get hintAddressNumber;

  /// No description provided for @labelCity.
  ///
  /// In pt, this message translates to:
  /// **'Cidade'**
  String get labelCity;

  /// No description provided for @hintCity.
  ///
  /// In pt, this message translates to:
  /// **'Digite sua cidade'**
  String get hintCity;

  /// No description provided for @labelState.
  ///
  /// In pt, this message translates to:
  /// **'Estado'**
  String get labelState;

  /// No description provided for @hintState.
  ///
  /// In pt, this message translates to:
  /// **'Digite seu estado'**
  String get hintState;

  /// No description provided for @labelCountry.
  ///
  /// In pt, this message translates to:
  /// **'País'**
  String get labelCountry;

  /// No description provided for @hintCountry.
  ///
  /// In pt, this message translates to:
  /// **'Digite seu país'**
  String get hintCountry;

  /// No description provided for @termsTitle.
  ///
  /// In pt, this message translates to:
  /// **'Termos e Condições'**
  String get termsTitle;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

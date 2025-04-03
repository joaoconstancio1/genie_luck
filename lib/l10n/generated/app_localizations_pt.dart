// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get registerTitle => 'Crie Sua Conta e Entre em Ação!';

  @override
  String get labelCompleteName => 'Nome Completo';

  @override
  String get hintCompleteName => 'Digite seu nome completo';

  @override
  String get labelEmail => 'E-mail';

  @override
  String get hintEmail => 'example@email.com';

  @override
  String get labelPassword => 'Senha';

  @override
  String get hintPassword => 'Digite sua senha';

  @override
  String get labelConfirmPassword => 'Confirme a Senha';

  @override
  String get hintConfirmPassword => 'Confirme sua senha';

  @override
  String get labelBirthDate => 'Data de Nascimento';

  @override
  String get hintBirthDate => '01/01/2000';

  @override
  String get labelPhoneNumber => 'Número de Telefone';

  @override
  String get hintPhoneNumber => '99999-9999';

  @override
  String get labelAcceptTerms => 'Aceitar Termos e Condições';

  @override
  String get labelReceivePromotions => 'Receber Promoções';

  @override
  String get buttonRegisterNow => 'Registrar Agora';
}

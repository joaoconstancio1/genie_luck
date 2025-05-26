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

  @override
  String get labelZipCode => 'CEP';

  @override
  String get hintZipCode => 'Digite seu CEP';

  @override
  String get labelAddress => 'Endereço';

  @override
  String get hintAddress => 'Digite seu endereço';

  @override
  String get labelSearchAddress => 'Pesquise seu endereço';

  @override
  String get hintSearchAddress => 'Avenida ABC 123';

  @override
  String get labelAddressNumber => 'Número';

  @override
  String get hintAddressNumber => '999';

  @override
  String get labelCity => 'Cidade';

  @override
  String get hintCity => 'Digite sua cidade';

  @override
  String get labelState => 'Estado';

  @override
  String get hintState => 'Digite seu estado';

  @override
  String get labelCountry => 'País';

  @override
  String get hintCountry => 'Digite seu país';

  @override
  String get back => 'Voltar';

  @override
  String get next => 'Próximo';

  @override
  String get searchCountry => 'Pesquisar país';

  @override
  String get errorCountryRequired => 'O campo país é obrigatório';

  @override
  String get errorInvalidZipCode => 'O CEP deve ter 8 dígitos';

  @override
  String get labelComplement => 'Complemento';

  @override
  String get hintComplement => 'Bloco, Apartamento, etc.';

  @override
  String get labelNeighborhood => 'Bairro';

  @override
  String get hintNeighborhood => 'Digite seu bairro';

  @override
  String get loading => 'Carregando...';
}

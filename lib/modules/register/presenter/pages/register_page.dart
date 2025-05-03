import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genie_luck/modules/register/presenter/cubit/cep_cubit.dart';
import 'package:genie_luck/modules/register/presenter/pages/components/contact_address_page.dart';
import 'package:genie_luck/modules/register/presenter/pages/components/personal_info_page.dart';
import 'package:genie_luck/modules/register/presenter/pages/components/terms_conditions_page.dart';

import 'package:genie_luck/core/utils/data_picker.dart';
import 'package:genie_luck/core/utils/validators.dart';
import 'package:genie_luck/l10n/generated/app_localizations.dart';
import 'package:genie_luck/core/models/user_model.dart';
import 'package:genie_luck/modules/register/presenter/cubit/register_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:intl_phone_field/countries.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => RegisterCubit(repository: GetIt.I())),
        BlocProvider(create: (context) => CepCubit(repository: GetIt.I())),
      ],
      child: const RegisterPageView(),
    );
  }
}

class RegisterPageView extends StatefulWidget {
  const RegisterPageView({super.key});

  @override
  State<RegisterPageView> createState() => _RegisterPageViewState();
}

class _RegisterPageViewState extends State<RegisterPageView> {
  final _formKey = GlobalKey<FormState>();
  final PageController _pageController = PageController();
  late DataPicker _dataPicker;

  // Controllers
  final TextEditingController _nameController = TextEditingController(
    text: 'João Vitor',
  );
  final TextEditingController _emailController = TextEditingController(
    text: 'joao.vitor@example.com',
  );
  final TextEditingController _passwordController = TextEditingController(
    text: 'Senha123!',
  );
  final TextEditingController _confirmPasswordController =
      TextEditingController(text: 'Senha123!');
  final TextEditingController _dateController = TextEditingController(
    text: '01/01/2000',
  );
  final TextEditingController _phoneController = TextEditingController(
    text: '999999999',
  );
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _addressNumberController =
      TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();

  final Validators _validators = Validators();
  bool _acceptTerms = false;
  bool _receivePromotions = false;
  DateTime? _selectedDate;
  String _selectedCountryCode = '+55';

  @override
  void initState() {
    super.initState();
    _dataPicker = DataPicker(dateController: _dateController);
  }

  void _onNextPage() {
    if (_formKey.currentState!.validate()) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  void _onPreviousPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  void _onRegister() {
    if (_formKey.currentState!.validate() && _acceptTerms) {
      final String fullPhoneNumber =
          '$_selectedCountryCode${_phoneController.text}';
      context.read<RegisterCubit>().registerUser(
        UserModel(
          fullName: _nameController.text,
          email: _emailController.text,
          password: _passwordController.text,
          birthDate: _selectedDate,
          phoneNumber: fullPhoneNumber,
          zipCode: _zipCodeController.text,
          address: _addressController.text,
          addressNumber: _addressNumberController.text,
          city: _cityController.text,
          state: _stateController.text,
          country: _countryController.text,
          termsAccepted: _acceptTerms,
          receivePromotions: _receivePromotions,
        ),
      );
    } else if (!_acceptTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('AppLocalizations.of(context)!.errorTermsRequired'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    Country brazil = countries.firstWhere((country) => country.code == 'BR');

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text(locale.registerTitle)),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              PersonalInfoPage(
                nameController: _nameController,
                emailController: _emailController,
                passwordController: _passwordController,
                confirmPasswordController: _confirmPasswordController,
                dateController: _dateController,
                phoneController: _phoneController,
                validators: _validators,
                dataPicker: _dataPicker,
                selectedCountryCode: _selectedCountryCode,
                onCountryCodeChanged:
                    (code) => setState(() => _selectedCountryCode = code),
                onDateSelected: (date) => setState(() => _selectedDate = date),
                onNext: _onNextPage,
                locale: locale,
              ),
              ContactAddressPage(
                countryController: TextEditingController(text: brazil.name),
                zipCodeController: TextEditingController(),
                addressController: TextEditingController(),
                addressNumberController: TextEditingController(),
                cityController: TextEditingController(),
                stateController: TextEditingController(),
                validators: Validators(),
                selectedCountry: brazil,
                onCountrySelected: (country) {},
                onNext: _onNextPage,
                onPrevious: _onPreviousPage,
                locale: AppLocalizations.of(context)!,
              ),
              TermsConfirmationPage(
                acceptTerms: _acceptTerms,
                receivePromotions: _receivePromotions,
                onAcceptTermsChanged:
                    (value) => setState(() => _acceptTerms = value),
                onReceivePromotionsChanged:
                    (value) => setState(() => _receivePromotions = value),
                onRegister: _onRegister,
                onPrevious: _onPreviousPage,
                locale: locale,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _dateController.dispose();
    _phoneController.dispose();
    _countryController.dispose();
    _zipCodeController.dispose();
    _addressController.dispose();
    _addressNumberController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _pageController.dispose();
    super.dispose();
  }
}

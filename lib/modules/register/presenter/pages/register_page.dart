import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:genie_luck/core/design/gl_text_form_field.dart';
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
  final TextEditingController _googlePlacesSearchController =
      TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _addressNumberController =
      TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();

  final Validators _validators = Validators();
  bool _acceptTerms = false;
  bool? _receivePromotions = false;
  DateTime? selectedDate;
  String _selectedCountryCode = '+55';
  final List<String> _countryFlags = [];
  List<Country> _countries = [];
  @override
  void initState() {
    super.initState();
    _dataPicker = DataPicker(dateController: _dateController);
    _countries = countries;
    _preloadCountryFlags();
  }

  void _preloadCountryFlags() {
    for (var country in _countries) {
      _countryFlags.add(country.flag);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations locale = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text(locale.registerTitle)),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _buildPersonalInfoPage(context, locale),
              _buildContactAddressPage(context, locale),
              _buildTermsConfirmationPage(context, locale),
            ],
          ),
        ),
      ),
    );
  }

  // Página 1: Informações Pessoais
  Widget _buildPersonalInfoPage(BuildContext context, AppLocalizations locale) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: SizedBox(
          width: 600,
          child: ListView(
            shrinkWrap: true,
            children: [
              GlTextFormField(
                controller: _nameController,
                keyboardType: TextInputType.name,
                labelText: locale.labelCompleteName,
                hintText: locale.hintCompleteName,
                validator: _validators.nameValidator,
              ),
              const SizedBox(height: 16),
              GlTextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                labelText: locale.labelEmail,
                hintText: locale.hintEmail,
                validator: _validators.validateEmail,
              ),
              const SizedBox(height: 16),
              GlTextFormField(
                controller: _passwordController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                labelText: locale.labelPassword,
                hintText: locale.hintPassword,
                obscureText: true,
                validator: _validators.validatePassword,
              ),
              const SizedBox(height: 16),
              GlTextFormField(
                controller: _confirmPasswordController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                labelText: locale.labelConfirmPassword,
                hintText: locale.hintConfirmPassword,
                obscureText: true,
                validator:
                    (value) => _validators.validateConfirmPassword(
                      value,
                      _passwordController.text,
                    ),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap:
                    () => _dataPicker.displayDatePicker(context).then((value) {
                      selectedDate = _dataPicker.selectedDate;
                    }),
                child: AbsorbPointer(
                  child: GlTextFormField(
                    controller: _dateController,
                    keyboardType: TextInputType.none,
                    readOnly: true,
                    labelText: locale.labelBirthDate,
                    hintText: locale.hintBirthDate,
                    suffixIcon: const Icon(Icons.calendar_today),
                    validator: _validators.validateDate,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              IntlPhoneField(
                pickerDialogStyle: PickerDialogStyle(
                  searchFieldInputDecoration: InputDecoration(
                    labelText: locale.searchCountry,
                  ),
                ),
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: locale.labelPhoneNumber,
                  hintText: locale.hintPhoneNumber,
                  hintStyle: TextStyle(color: Colors.grey),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                initialCountryCode: 'BR',
                onChanged: (phone) {
                  setState(() {
                    _selectedCountryCode = phone.countryCode;
                  });
                },
                validator:
                    (phone) => _validators.validatePhoneNumber(phone?.number),
                invalidNumberMessage: null,
                showCountryFlag: true,
                dropdownIcon: const Icon(Icons.arrow_drop_down),
                disableLengthCheck: true,
                autovalidateMode: AutovalidateMode.onUnfocus,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    );
                  }
                },
                child: const Text('Próximo'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Country? _selectedCountry;

  Widget _buildContactAddressPage(
    BuildContext context,
    AppLocalizations locale,
  ) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: SizedBox(
          width: 600,
          child: ListView(
            shrinkWrap: true,
            children: [
              const SizedBox(height: 16),
              Offstage(
                offstage: true,
                child: Text(
                  _countryFlags.join(),
                  style: const TextStyle(fontSize: 0),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _showCountryPickerDialog(context);
                },
                child: AbsorbPointer(
                  child: GlTextFormField(
                    controller: _countryController,
                    keyboardType: TextInputType.none,
                    readOnly: true,
                    labelText: locale.labelCountry,
                    hintText: _selectedCountry?.name ?? locale.hintCountry,
                    suffixIcon: const Icon(Icons.arrow_drop_down),
                    validator:
                        (value) =>
                            value == null || value.isEmpty
                                ? 'locale.errorCountryRequired'
                                : null,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              GlTextFormField(
                controller: _zipCodeController,
                keyboardType: TextInputType.text,
                labelText: locale.labelZipCode,
                hintText: locale.hintZipCode,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: GlTextFormField(
                      controller: _addressController,
                      keyboardType: TextInputType.text,
                      labelText: locale.labelAddress,
                      hintText: locale.hintAddress,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 1,
                    child: GlTextFormField(
                      controller: _addressNumberController,
                      keyboardType: TextInputType.number,
                      labelText: locale.labelAddressNumber,
                      hintText: locale.hintAddressNumber,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: GlTextFormField(
                      controller: _cityController,
                      keyboardType: TextInputType.text,
                      labelText: locale.labelCity,
                      hintText: locale.hintCity,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 1,
                    child: GlTextFormField(
                      controller: _stateController,
                      keyboardType: TextInputType.text,
                      labelText: locale.labelState,
                      hintText: locale.hintState,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    },
                    child: const Text('Voltar'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        );
                      }
                    },
                    child: const Text('Próximo'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Página 3: Termos e Confirmação
  Widget _buildTermsConfirmationPage(
    BuildContext context,
    AppLocalizations locale,
  ) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: SizedBox(
          width: 600,
          child: ListView(
            shrinkWrap: true,
            children: [
              Column(
                children: [
                  CheckboxListTile(
                    title: Text(locale.labelAcceptTerms),
                    value: _acceptTerms,
                    onChanged: (bool? value) {
                      setState(() {
                        _acceptTerms = value ?? false;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  CheckboxListTile(
                    title: Text(locale.labelReceivePromotions),
                    value: _receivePromotions,
                    onChanged: (bool? value) {
                      setState(() {
                        _receivePromotions = value ?? false;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => _onRegisterButtonPressed(context),
                      child: Text(locale.buttonRegisterNow),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  _pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                  );
                },
                child: const Text('Voltar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onRegisterButtonPressed(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      if (!_acceptTerms) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Você deve aceitar os termos para continuar.'),
          ),
        );
        return;
      }
      // Combine country code with phone number
      final String fullPhoneNumber =
          '$_selectedCountryCode${_phoneController.text}';
      context.read<RegisterCubit>().registerUser(
        UserModel(
          fullName: _nameController.text,
          email: _emailController.text,
          password: _passwordController.text,
          birthDate: selectedDate,
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
    }
  }

  void _showCountryPickerDialog(BuildContext context) {
    String searchQuery = '';
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            final filteredCountries =
                _countries
                    .where(
                      (country) => country.name.toLowerCase().contains(
                        searchQuery.toLowerCase(),
                      ),
                    )
                    .toList();
            return AlertDialog(
              title: Text(AppLocalizations.of(context)!.searchCountry),
              content: SizedBox(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.searchCountry,
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value;
                        });
                      },
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        cacheExtent: 1000,
                        itemCount: filteredCountries.length,
                        itemBuilder: (context, index) {
                          final country = filteredCountries[index];
                          return ListTile(
                            dense: true,
                            leading: Text(
                              country.flag,
                              style: TextStyle(fontSize: 20),
                            ),
                            title: Text(
                              country.name,
                              style: TextStyle(fontSize: 20),
                            ),
                            onTap: () {
                              setState(() {
                                _countryController.text = country.name;
                              });
                              Navigator.pop(context);
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
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
    _googlePlacesSearchController.dispose();
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

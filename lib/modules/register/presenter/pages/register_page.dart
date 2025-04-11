import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_google_maps_webservices/places.dart';
import 'package:genie_luck/core/design/gl_text_form_field.dart';
import 'package:genie_luck/core/utils/data_picker.dart';
import 'package:genie_luck/core/utils/validators.dart';
import 'package:genie_luck/l10n/generated/app_localizations.dart';
import 'package:genie_luck/core/models/user_model.dart';
import 'package:genie_luck/modules/register/presenter/cubit/register_cubit.dart';
import 'package:genie_luck/modules/register/presenter/cubit/register_states.dart';
import 'package:get_it/get_it.dart';
import 'package:uuid/uuid.dart';

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
    text: '+5511999999999',
  );
  final TextEditingController _googlePlacesSearchController =
      TextEditingController();
  List<Prediction> _predictions = [];
  String _sessionToken = const Uuid().v4();
  Map<String, String> _addressData = {};
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

  @override
  void initState() {
    super.initState();
    _dataPicker = DataPicker(dateController: _dateController);
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations locale = AppLocalizations.of(context)!;

    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(centerTitle: true, title: Text(locale.registerTitle)),
          body: SafeArea(
            child: Form(
              key: _formKey,
              child: PageView(
                controller: _pageController,
                physics:
                    const NeverScrollableScrollPhysics(), // Impede swipe manual
                children: [
                  _buildPersonalInfoPage(context, locale),
                  _buildContactAddressPage(context, locale),
                  _buildTermsConfirmationPage(context, locale, state),
                ],
              ),
            ),
          ),
        );
      },
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
              GlTextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                labelText: locale.labelPhoneNumber,
                hintText: locale.hintPhoneNumber,
                validator: (value) => _validators.validatePhoneNumber(value),
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
                child: Text('Proximo'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Página 2: Contato e Endereço
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
              TextField(
                controller: _googlePlacesSearchController,
                decoration: InputDecoration(
                  hintText: 'Digite o endereço',
                  prefixIcon: Icon(Icons.location_on, color: Colors.blue),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(vertical: 0),
                ),
                onChanged: (value) {
                  context.read<RegisterCubit>().searchPlaces(
                    value,
                    _sessionToken,
                  );
                },
              ),

              GlTextFormField(
                controller: _countryController,
                keyboardType: TextInputType.text,
                labelText: locale.labelCountry,
                hintText: locale.hintCountry,
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
                    child: Text('Voltar'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    },
                    child: Text('Proximo'),
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
    RegisterState state,
  ) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: SizedBox(
          width: 600,
          child: ListView(
            shrinkWrap: true,
            children: [
              if (state is RegisterLoadingState)
                const Center(child: CircularProgressIndicator())
              else if (state is RegisterErrorState)
                Center(
                  child: Text(
                    'Erro ao registrar: ${state.exception}',
                    style: const TextStyle(color: Colors.red),
                  ),
                )
              else if (state is RegisterSuccessState)
                const Center(child: Text('Registro realizado com sucesso!'))
              else
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
                child: Text('Voltar'),
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
          SnackBar(
            content: Text('Você deve aceitar os termos para continuar.'),
          ),
        );
        return;
      }
      context.read<RegisterCubit>().registerUser(
        UserModel(
          fullName: _nameController.text,
          email: _emailController.text,
          password: _passwordController.text,
          birthDate: selectedDate,
          phoneNumber: _phoneController.text,
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
}

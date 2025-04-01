import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genie_luck/core/design/gl_text_form_field.dart';
import 'package:genie_luck/core/utils/formatters.dart';
import 'package:genie_luck/core/utils/validators.dart';
import 'package:genie_luck/register/presenter/cubit/register_cubit.dart';
import 'package:genie_luck/register/presenter/cubit/register_states.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RegisterCubit(repository: GetIt.I()),
          child: RegisterPageView(),
        ),
      ],
      child: const RegisterPageView1(),
    );
  }
}

class RegisterPageView1 extends StatelessWidget {
  const RegisterPageView1({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        return Column(
          children: [
            ElevatedButton(
              onPressed: () {
                context.read<RegisterCubit>().registerUser(
                  fullName: 'joao',
                  email: '',
                  password: '',
                  birthDate: DateTime(
                    2000,
                    1,
                    1,
                  ), // Add birth date logic if needed
                  phoneNumber: '', // Add phone number logic if needed
                  zipCode: '', // Add zip code logic if needed
                  address: '', // Add address logic if needed
                  addressNumber: '', // Add address number logic if needed
                  city: '', // Add city logic if needed
                  state: '', // Add state logic if needed
                  country: '', // Add country logic if needed
                  termsAccepted: true,
                  receivePromotions: true,
                );
              },
              child: Text('Registrar'),
            ),
          ],
        );
      },
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
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final Validators _validators = Validators();
  final FocusNode _dateFocus = FocusNode();
  bool _acceptTerms = false;
  bool? _receivePromotions = false;

  bool _obscureText = true;

  DateTime? selectedDate;

  void _register() {
    if (_formKey.currentState!.validate()) {
      GoRouter.of(context).go('/genie-slider');
    }
  }

  @override
  void initState() {
    super.initState();
    _dateFocus.addListener(() {
      if (!_dateFocus.hasFocus) {
        _formKey.currentState?.validate();
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _dateFocus.dispose();
    super.dispose();
  }

  Future<void> _showDataPicker() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          child: Center(
            child: SizedBox(
              child: CupertinoDatePicker(
                use24hFormat: true,
                mode: CupertinoDatePickerMode.date,
                initialDateTime:
                    selectedDate ??
                    DateTime.now().subtract(Duration(days: 365 * 18)),
                maximumYear: DateTime.now().year - 18,
                minimumYear: DateTime.now().year - 100,
                onDateTimeChanged: (DateTime dateValue) {
                  selectedDate = dateValue;
                  setState(() {
                    _dateController.value = TextEditingValue(
                      text:
                          '${dateValue.day.toString().padLeft(2, '0')}/${dateValue.month.toString().padLeft(2, '0')}/${dateValue.year}',
                    );
                  });
                },
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Crie sua Conta e Entre na Ação!')),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: BlocBuilder<RegisterCubit, RegisterState>(
            builder: (context, state) {
              return ListView(
                padding: const EdgeInsets.all(16.0),
                shrinkWrap: true,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GlTextFormField(
                          controller: _nameController,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            labelText: 'Nome Completo',
                          ),
                          validator: (value) {
                            return _validators.nameValidator(value);
                          },
                        ),
                        GlTextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(labelText: 'E-mail'),
                          validator: (value) {
                            return _validators.validateEmail(value);
                          },
                        ),
                        GlTextFormField(
                          controller: _passwordController,
                          obscureText: _obscureText,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            labelText: 'Senha',
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed:
                                  () => setState(
                                    () => _obscureText = !_obscureText,
                                  ),
                            ),
                          ),
                          validator: (value) {
                            return _validators.validatePassword(value);
                          },
                        ),
                        GlTextFormField(
                          controller: _confirmPasswordController,
                          obscureText: _obscureText,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            labelText: 'Confirme a Senha',
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed:
                                  () => setState(
                                    () => _obscureText = !_obscureText,
                                  ),
                            ),
                          ),
                          validator: (value) {
                            return _validators.validateConfirmPassword(
                              value,
                              _passwordController.text,
                            );
                          },
                        ),

                        GlTextFormField(
                          keyboardType: TextInputType.datetime,
                          inputFormatters: Formatters().dateFormatter,
                          controller: _dateController,
                          focusNode: _dateFocus,
                          decoration: InputDecoration(
                            labelText: 'Data de Nascimento (DD/MM/AAAA)',
                          ),
                          validator: (value) {
                            return _validators.validateDate(value);
                          },
                          onTap: () => _showDataPicker(),
                        ),
                        GlTextFormField(
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            labelText: 'Número de Telefone',
                            prefixIcon: IconButton(
                              icon: Icon(Icons.flag),
                              onPressed: () {
                                // Implementar lógica para selecionar a bandeira do país
                              },
                            ),
                            prefixText:
                                '+55 ', // Exemplo de prefixo para o Brasil
                          ),
                          validator: (value) {
                            return _validators.validatePhoneNumber(value);
                          },
                        ),

                        CheckboxListTile(
                          title: Text('Aceitar Termos e Condições'),
                          value: _acceptTerms,
                          onChanged: (bool? value) {
                            setState(() {
                              _acceptTerms = value ?? false;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                        CheckboxListTile(
                          title: Text('Receber Promoções'),
                          value: _receivePromotions,
                          onChanged: (bool? value) {
                            setState(() {
                              _receivePromotions = value ?? false;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                        Center(
                          child: ElevatedButton(
                            onPressed:
                                (_formKey.currentState?.validate() ?? false) &&
                                        _acceptTerms
                                    ? _register
                                    : null,
                            child: Text('Registrar Agora'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

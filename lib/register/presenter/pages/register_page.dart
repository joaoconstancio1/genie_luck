import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genie_luck/core/design/gl_text_form_field.dart';
import 'package:genie_luck/core/utils/data_picker.dart';
import 'package:genie_luck/core/utils/validators.dart';
import 'package:genie_luck/l10n/generated/app_localizations.dart';
import 'package:genie_luck/register/data/models/user_model.dart';
import 'package:genie_luck/register/presenter/cubit/register_cubit.dart';
import 'package:genie_luck/register/presenter/cubit/register_states.dart';
import 'package:get_it/get_it.dart';

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
      child: const RegisterPageView(),
    );
  }
}

class RegisterPageView extends StatefulWidget {
  const RegisterPageView({super.key});

  @override
  State<RegisterPageView> createState() => _RegisterPageView1State();
}

class _RegisterPageView1State extends State<RegisterPageView> {
  @override
  void initState() {
    super.initState();
    _dataPicker = DataPicker(dateController: _dateController);
  }

  final _formKey = GlobalKey<FormState>();
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
  final TextEditingController _dateController = TextEditingController();

  final Validators _validators = Validators();
  DataPicker _dataPicker = DataPicker();
  bool _acceptTerms = false;
  bool? _receivePromotions = false;
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations? local = AppLocalizations.of(context);

    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(centerTitle: true, title: Text(local!.registerTitle)),

          body: SafeArea(
            child: BlocBuilder<RegisterCubit, RegisterState>(
              builder: (context, state) {
                if (state is RegisterLoadingState) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is RegisterErrorState) {
                  return Center(
                    child: Text(
                      'Erro ao registrar: ${state.exception}',
                      style: TextStyle(color: Colors.red),
                    ),
                  );
                } else if (state is RegisterSuccessState) {
                  return Center(child: Text('Registro realizado com sucesso!'));
                }
                return Center(
                  child: SizedBox(
                    width: 600,
                    child: Form(
                      key: _formKey,
                      child: ListView(
                        padding: const EdgeInsets.all(16.0),
                        shrinkWrap: true,
                        children: [
                          Column(
                            spacing: 16,
                            children: [
                              GlTextFormField(
                                controller: _nameController,
                                keyboardType: TextInputType.name,
                                labelText: 'Nome Completo',
                                hintText: 'Digite seu nome completo',
                                validator: _validators.nameValidator,
                              ),
                              GlTextFormField(
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                labelText: 'E-mail',
                                hintText: 'example@email.com',
                                validator: _validators.validateEmail,
                              ),
                              GlTextFormField(
                                controller: _passwordController,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                labelText: 'Senha',
                                hintText: 'Digite sua senha',
                                obscureText: true,
                                validator: _validators.validatePassword,
                              ),
                              GlTextFormField(
                                controller: _confirmPasswordController,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,

                                labelText: 'Confirme a Senha',
                                hintText: 'Confirme sua senha',
                                obscureText: true,
                                validator:
                                    (value) =>
                                        _validators.validateConfirmPassword(
                                          value,
                                          _passwordController.text,
                                        ),
                              ),
                              GestureDetector(
                                onTap:
                                    () => _dataPicker
                                        .displayDatePicker(context)
                                        .then((value) {
                                          selectedDate =
                                              _dataPicker.selectedDate;
                                        }),
                                child: AbsorbPointer(
                                  child: GlTextFormField(
                                    controller: _dateController,
                                    keyboardType: TextInputType.none,
                                    readOnly: true,
                                    labelText: 'Data de Nascimento',
                                    hintText: '01/01/2000',
                                    suffixIcon: Icon(Icons.calendar_today),
                                    validator: _validators.validateDate,
                                  ),
                                ),
                              ),

                              GlTextFormField(
                                keyboardType: TextInputType.phone,

                                labelText: 'Número de Telefone',
                                hintText: '99999-9999',
                                prefixIcon: Icon(Icons.phone),
                              ),
                            ],
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

                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed:
                                  () => _onRegisterButtonPressed(context),
                              child: Text('Registrar Agora'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  void _onRegisterButtonPressed(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<RegisterCubit>().registerUser(
        UserModel(
          fullName: _nameController.text,
          email: _emailController.text,
          password: _passwordController.text,
          birthDate: selectedDate,
          phoneNumber: '111111111',
          zipCode: '00000-000',
          address: 'Rua Exemplo',
          addressNumber: '123',
          city: 'São Paulo',
          state: 'SP',
          country: 'Brasil',
          termsAccepted: _acceptTerms,
          receivePromotions: _receivePromotions,
        ),
      );
    }
  }
}

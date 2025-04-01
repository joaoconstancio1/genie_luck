import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genie_luck/core/design/gl_text_form_field.dart';
import 'package:genie_luck/core/utils/formatters.dart';
import 'package:genie_luck/core/utils/validators.dart';
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
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: Text('Crie sua Conta e Entre na Ação!')),

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
                return Form(
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
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(labelText: 'Senha'),
                            validator: (value) {
                              return _validators.validatePassword(value);
                            },
                          ),
                          GlTextFormField(
                            controller: _confirmPasswordController,
                            obscureText: _obscureText,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              labelText: 'Confirme a Senha',
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
                                icon: Icon(Icons.phone),
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
                                  (_formKey.currentState?.validate() ??
                                              false) &&
                                          _acceptTerms
                                      ? () {
                                        if (_formKey.currentState!.validate()) {
                                          context
                                              .read<RegisterCubit>()
                                              .registerUser(
                                                fullName: _nameController.text,
                                                email: _emailController.text,
                                                password:
                                                    _passwordController.text,
                                                birthDate: selectedDate!,
                                                phoneNumber:
                                                    _dateController.text,
                                                zipCode: '00000-000',
                                                address: 'Rua Exemplo',
                                                addressNumber: '123',
                                                city: 'São Paulo',
                                                state: 'SP',
                                                country: 'Brasil',
                                                termsAccepted: _acceptTerms,
                                                receivePromotions:
                                                    _receivePromotions!,
                                              );
                                        }
                                      }
                                      : null,
                              child: Text('Registrar Agora'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

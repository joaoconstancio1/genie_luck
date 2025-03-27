import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _acceptTerms = false;
  bool? _receivePromotions = false;

  bool _obscureText = true;

  void _register() {
    if (_formKey.currentState!.validate()) {
      GoRouter.of(context).go('/genie-slider');
    }
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Informe um e-mail';
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (!emailRegex.hasMatch(value)) return 'E-mail inválido';
    return null;
  }

  String? _validatePassword(String? value) {
    List<String?> errors = [];
    if (value == null || value.isEmpty) {
      errors.add('Informe uma senha');
    } else {
      if (value.length < 8) {
        errors.add('A senha deve ter no mínimo 6 caracteres');
      }

      final hasUppercase = value.contains(RegExp(r'[A-Z]'));
      final hasLowercase = value.contains(RegExp(r'[a-z]'));
      final hasNumber = value.contains(RegExp(r'[0-9]'));
      final hasSpecialChar = value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

      if (!hasUppercase) errors.add('A senha deve ter uma letra maiúscula');
      if (!hasLowercase) errors.add('A senha deve ter uma letra minúscula');
      if (!hasNumber) errors.add('A senha deve ter um número');
      if (!hasSpecialChar) errors.add('A senha deve ter um caractere especial');
    }

    if (errors.isEmpty) return null;
    return errors.join('\n');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Crie sua Conta e Entre na Ação!')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(labelText: 'Nome Completo'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe seu nome completo';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(labelText: 'E-mail'),
                validator: _validateEmail,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                obscureText: _obscureText,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed:
                        () => setState(() => _obscureText = !_obscureText),
                  ),
                ),
                validator: _validatePassword,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: _obscureText,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  labelText: 'Confirme a Senha',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed:
                        () => setState(() => _obscureText = !_obscureText),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Confirme sua senha';
                  }
                  if (value != _passwordController.text) {
                    return 'As senhas não coincidem';
                  }
                  return null;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.datetime,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  TextInputFormatter.withFunction((oldValue, newValue) {
                    final text = newValue.text;
                    if (text.length > 10) return oldValue;
                    String formatted = text;
                    if (text.length >= 3) {
                      formatted =
                          '${text.substring(0, 2)}/${text.substring(2)}';
                    }
                    if (text.length >= 4) {
                      formatted =
                          '${text.substring(0, 2)}/${text.substring(2, 4)}/${text.substring(4, text.length > 8 ? 8 : text.length)}';
                    }
                    return TextEditingValue(
                      text: formatted,
                      selection: TextSelection.collapsed(
                        offset: formatted.length,
                      ),
                    );
                  }),
                ],
                decoration: InputDecoration(
                  labelText: 'Data de Nascimento (DD/MM/AAAA)',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe sua data de nascimento';
                  }
                  final dateRegex = RegExp(r'^\d{2}/\d{2}/\d{4}$');
                  if (!dateRegex.hasMatch(value)) {
                    return 'Formato inválido. Use DD/MM/AAAA';
                  }
                  try {
                    final parts = value.split('/');
                    final day = int.parse(parts[0]);
                    final month = int.parse(parts[1]);
                    final year = int.parse(parts[2]);
                    final birthDate = DateTime(year, month, day);
                    final today = DateTime.now();
                    final age =
                        today.year -
                        birthDate.year -
                        ((today.month < birthDate.month ||
                                (today.month == birthDate.month &&
                                    today.day < birthDate.day))
                            ? 1
                            : 0);
                    if (age < 18) {
                      return 'Você deve ter pelo menos 18 anos';
                    }
                  } catch (e) {
                    return 'Data inválida';
                  }
                  return null;
                },
              ),

              SizedBox(height: 24),
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
      ),
    );
  }
}

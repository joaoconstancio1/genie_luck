//TODO usar locale para traduzir

class Validators {
  String? nameValidator(String? value) {
    String errorMessage = "Informe seu nome completo";
    if (value == null || value.isEmpty) return errorMessage;
    final words = value.trim().split(RegExp(r'\s+'));
    if (words.length < 2) return errorMessage;
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Informe um e-mail';
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (!emailRegex.hasMatch(value)) return 'E-mail inválido';
    return null;
  }

  String? validatePassword(String? value) {
    List<String?> errors = [];
    if (value == null || value.isEmpty) {
      errors.add('Informe uma senha');
    } else {
      if (value.length < 8) {
        errors.add('A senha deve ter no mínimo 8 caracteres');
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

  String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) return 'Confirme sua senha';
    if (value != password) return 'As senhas não coincidem';
    return null;
  }

  String? validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Informe sua data de nascimento';
    }
    return null;
  }

  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Informe um número de telefone';
    }
    final phoneRegex = RegExp(r'^\+?[1-9]\d{1,14}$');
    if (!phoneRegex.hasMatch(value)) {
      return 'Número de telefone inválido';
    }
    return null;
  }
}

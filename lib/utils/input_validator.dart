class InputValidator {

  static String validatePassword(String value) {
    if(value.length < 7) return 'Senha deve ter no mínimo 7 caracteres';

    return null;
  }

  static String validateEmail(String value) {
    if(value == null || value.isEmpty) return 'E-mail não pode estar vazio';
    if(!value.contains('@')) return 'E-mail inválido';

    return null;
  }

  static String validateName(String value) {
    if(value.length < 4) return 'Nome deve ser maior que 3 caracteres';

    return null;
  }
}

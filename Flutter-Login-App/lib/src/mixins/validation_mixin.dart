class ValidationMixing {
  String validateEmail (String value) { 
        // Se o email não contém @...
        if(!value.contains('@')) { 
          // Então...
          return 'Please enter a valid email';
        }
          return null;
  }

  String validatePassword (String value) {
          // Se a senha tiver menos de 4 caracteres...
          if(value.length < 4) {
            // Então...
            return 'Password must be at least 4 characters';
          }
            return null;
        }
}

String? emailValidator(String? input) {
  if (input == null || input.isEmpty) {
      return 'Please enter an email';
    }
    
    // Regular expression for email validation
    final emailRegex = RegExp("\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*");

    if (!input.contains('@')) {
      return 'Please enter a valid email';
    }
    
    return 'The email is correct';
}
String? emailValidator(String? input) {
  if (input == null || input.isEmpty) {
      return 'Please enter an email';
    }
    
    // Regular expression for email validation
    final emailRegex = RegExp(r"/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/s");

    if (!emailRegex.hasMatch(input)) {
      return 'Please enter a valid email';
    }
    
    return 'The email is correct';
}
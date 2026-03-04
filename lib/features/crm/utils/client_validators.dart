class ClientValidators {
  static final RegExp _namePattern = RegExp(r"^[A-Za-zА-Яа-яЁё\s'-]{2,}$");
  static final RegExp _emailPattern = RegExp(
    r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$',
  );
  static final RegExp _phonePattern = RegExp(r'^\+?[0-9\s\-()]{7,20}$');

  static String? validateName(String value) {
    final normalized = value.trim();
    if (normalized.isEmpty) {
      return 'Name is required';
    }
    if (!_namePattern.hasMatch(normalized)) {
      return 'Name must contain at least 2 letters';
    }
    return null;
  }

  static String? validateEmail(String value) {
    final normalized = value.trim();
    if (normalized.isEmpty) {
      return 'Email is required';
    }
    if (!_emailPattern.hasMatch(normalized)) {
      return 'Invalid email format';
    }
    return null;
  }

  static String? validatePhone(String? value) {
    final normalized = (value ?? '').trim();
    if (normalized.isEmpty) {
      return null;
    }
    if (!_phonePattern.hasMatch(normalized)) {
      return 'Invalid phone format';
    }
    return null;
  }
}


class Validators {
  static bool isValidEmail(String email) {
    final pattern = RegExp(
      r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$',
    );

    return pattern.hasMatch(email.trim());
  }

  static bool isNotEmpty(String? value) {
    return value != null && value.trim().isNotEmpty;
  }

  static bool hasValidLength(
    String value, {
    int minLength = 1,
    int maxLength = 100,
  }) {
    return value.length >= minLength &&
        value.length <= maxLength;
  }

  static String sanitize(String input) {
    return input
        .replaceAll('&', '&amp;')
        .replaceAll('<', '&lt;')
        .replaceAll('>', '&gt;')
        .replaceAll('"', '&quot;')
        .replaceAll("'", '&#x27;');
  }

  static String? validateText(
    String? value, {
    int minLength = 1,
    int maxLength = 100,
  }) {
    if (value == null || value.trim().isEmpty) {
      return 'Teks tidak boleh kosong';
    }

    if (value.trim().length < minLength) {
      return 'Teks minimal $minLength karakter';
    }

    if (value.trim().length > maxLength) {
      return 'Teks maksimal $maxLength karakter';
    }

    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email tidak boleh kosong';
    }

    if (!isValidEmail(value)) {
      return 'Format email tidak valid';
    }

    return null;
  }

  // Validasi nomor telepon: 10-13 digit angka.

  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Nomor telepon tidak boleh kosong';
    }

    final phone = value.trim();
    final pattern = RegExp(r'^[0-9]{10,13}$');

    if (!pattern.hasMatch(phone)) {
      return 'Nomor telepon harus 10-13 digit angka';
    }

    return null;
  }

  // Validasi URL yang menggunakan HTTP atau HTTPS.

  static String? validateUrl(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'URL tidak boleh kosong';
    }

    final url = value.trim();
    final pattern = RegExp(
      r'^https?://[^\s]+$',
      caseSensitive: false,
    );

    if (!pattern.hasMatch(url)) {
      return 'URL harus diawali http:// atau https://';
    }

    return null;
  }

  // Validasi password minimal 8 karakter.

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password tidak boleh kosong';
    }

    if (value.length < 8) {
      return 'Password minimal 8 karakter';
    }

    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password harus memiliki huruf kapital';
    }

    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password harus memiliki angka';
    }

    if (!RegExp(r'[^A-Za-z0-9]').hasMatch(value)) {
      return 'Password harus memiliki simbol';
    }

    return null;
  }
}

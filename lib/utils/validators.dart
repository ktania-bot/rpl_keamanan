/// Kumpulan fungsi validasi dan sanitasi input.
class Validators {
  /// Memvalidasi format email.
  static bool isValidEmail(String email) {
    final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    return regex.hasMatch(email.trim());
  }

  /// Memeriksa apakah input tidak kosong.
  static bool isNotEmpty(String? value) {
    return value != null && value.trim().isNotEmpty;
  }

  /// Memeriksa panjang input.
  static bool hasValidLength(
    String value, {
    int min = 1,
    int max = 100,
  }) {
    final length = value.trim().length;
    return length >= min && length <= max;
  }

  /// Membersihkan karakter khusus untuk konteks teks HTML.
  static String sanitize(String input) {
    return input
        .replaceAll('&', '&amp;')
        .replaceAll('<', '&lt;')
        .replaceAll('>', '&gt;')
        .replaceAll('"', '&quot;')
        .replaceAll("'", '&#39;')
        .trim();
  }

  /// Memvalidasi teks berdasarkan panjang yang ditentukan.
  static String? validateText(
    String? value, {
    String fieldName = 'Field',
    int minLength = 1,
    int maxLength = 100,
  }) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName tidak boleh kosong';
    }

    if (!hasValidLength(
      value,
      min: minLength,
      max: maxLength,
    )) {
      return '$fieldName harus antara $minLength-$maxLength karakter';
    }

    return null;
  }

  /// Memvalidasi email.
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email tidak boleh kosong';
    }

    if (!isValidEmail(value)) {
      return 'Format email tidak valid';
    }

    return null;
  }
}
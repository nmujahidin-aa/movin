class Validators {
  static String? requiredField(String? v, {String message = 'Wajib diisi'}) {
    if (v == null || v.trim().isEmpty) return message;
    return null;
  }

  static String? email(String? v) {
    if (v == null || v.trim().isEmpty) return 'Email wajib diisi';
    final val = v.trim();
    final ok = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(val);
    if (!ok) return 'Format email tidak valid';
    return null;
  }

  static String? password(String? v) {
    if (v == null || v.isEmpty) return 'Password wajib diisi';
    if (v.length < 6) return 'Minimal 6 karakter';
    return null;
  }
}
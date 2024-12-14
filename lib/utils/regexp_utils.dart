class RegExpUtils {
  RegExpUtils._();

  static RegExp emailRegExp = RegExp(
      r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
      r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
      r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
      r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
      r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
      r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
      r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])');

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return "Email tidak boleh kosong";
    return emailRegExp.hasMatch(value) ? null : 'Masukkan email yang valid';
  }

  static String? validatePassword(String? value) {
    if (value == null) {
      return null;
    }

    String pattern = r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[A-Za-z\d]{8,}$';
    RegExp regex = RegExp(pattern);

    if (regex.hasMatch(value)) {
      return null;
    } else {
      if (!RegExp(r'(?=.*[a-z])').hasMatch(value)) {
        return 'Setidaknya 1 huruf kecil';
      } else if (!RegExp(r'(?=.*[A-Z])').hasMatch(value)) {
        return 'Setidaknya 1 huruf besar';
      } else if (!RegExp(r'(?=.*\d)').hasMatch(value)) {
        return 'Setidaknya 1 angka';
      } else if (value.length < 8) {
        return 'Minimal 8 karakter';
      } else {
        // return 'Pastikan password sesuai';
        return null;
      }
    }
  }
}

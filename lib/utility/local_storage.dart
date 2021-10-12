import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static final LocalStorage _shared = LocalStorage();
  static LocalStorage get shared => _shared;

  static late SharedPreferences _sharedPreferences;

  static Future<void> initialize() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  String get lengthKey => 'length';
  int get length => _sharedPreferences.getInt(lengthKey) ?? 16;
  set length(int value) {
    _sharedPreferences.setInt(lengthKey, value);
  }

  String get lettersKey => 'letters';
  bool get letters => _sharedPreferences.getBool(lettersKey) ?? true;
  set letters(bool value) {
    _sharedPreferences.setBool(lettersKey, value);
  }

  String get numbersKey => 'numbers';
  bool get numbers => _sharedPreferences.getBool(numbersKey) ?? true;
  set numbers(bool value) {
    _sharedPreferences.setBool(numbersKey, value);
  }

  String get uppercaseKey => 'uppercase';
  bool get uppercase => _sharedPreferences.getBool(uppercaseKey) ?? true;
  set uppercase(bool value) {
    _sharedPreferences.setBool(uppercaseKey, value);
  }

  String get specialCharKey => 'specialChar';
  bool get specialChar => _sharedPreferences.getBool(specialCharKey) ?? true;
  set specialChar(bool value) {
    _sharedPreferences.setBool(specialCharKey, value);
  }
}

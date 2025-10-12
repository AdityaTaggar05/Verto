import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  StorageService._internal();

  static final StorageService _instance = StorageService._internal();

  factory StorageService() {
    return _instance;
  }

  late SharedPreferences _prefs;
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static const String _usernameKey = 'username_key';
  static const String _firstNameKey = 'first_name_key';
  static const String _lastNameKey = 'last_name_key';
  static const String _accessTokenKey = 'authorization_token_key';
  static const String _refreshTokenKey = 'refresh_token_key';
  static const String _passwordKey = 'password_key';
  static const String _idKey = 'id_key';
  static const String _xpKey = 'xp_key';
  static const String _coinsKey = 'coins_key';

  // setter and getter function for id

  Future<void> setID(String id) async {
    await _prefs.setString(_idKey, id);
  }

  String getID() {
    return _prefs.getString(_idKey) ?? '';
  }

  // setter and getter function for xp

  Future<void> setXP(int xp) async {
    await _prefs.setInt(_xpKey, xp);
  }

  int getXP() {
    return _prefs.getInt(_idKey) ?? 0;
  }

  // setter and getter function for coins

  Future<void> setCoins(int coins) async {
    await _prefs.setInt(_coinsKey, coins);
  }

  int getCoins() {
    return _prefs.getInt(_coinsKey) ?? 0;
  }

  // setter and getter function for username

  Future<void> setUsername(String username) async {
    await _prefs.setString(_usernameKey, username);
  }

  String getUsername() {
    return _prefs.getString(_usernameKey) ?? 'Guest';
  }

  // setter and getter function for first name

  Future<void> setFirstName(String firstName) async {
    await _prefs.setString(_firstNameKey, firstName);
  }

  String? getFirstName() {
    return _prefs.getString(_firstNameKey);
  }

  // setter and getter function for last name

  Future<void> setLastName(String lastName) async {
    await _prefs.setString(_lastNameKey, lastName);
  }

  String? getLastName() {
    return _prefs.getString(_lastNameKey);
  }

  // getter and setter function for access token

  Future<void> setAccessToken(String accessToken) async {
    await _prefs.setString(_accessTokenKey, accessToken);
  }

  String? getAccessToken() {
    return _prefs.getString(_accessTokenKey);
  }

  // getter and setter function for refresh token

  Future<void> setRefreshToken(String refreshToken) async {
    await _prefs.setString(_refreshTokenKey, refreshToken);
  }

  String? getRefreshToken() {
    return _prefs.getString(_refreshTokenKey);
  }

  // getter and setter function for password

  Future<void> setPassword(String password) async {
    await _prefs.setString(_passwordKey, password);
  }

  String? getPassword() {
    return _prefs.getString(_passwordKey);
  }
}

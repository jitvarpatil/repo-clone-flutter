class AppCredentials {
    static String _appId = "";
  static String _authKey = "";
  static String _region = "";

  // Getters
  static String get appId => _appId;
  static String get authKey => _authKey;
  static String get region => _region;

  // Setters
  static setAppId(String value) {
    _appId = value;
  }

  static setAuthKey(String value) {
    _authKey = value;
  }

  static setRegion(String value) {
    _region = value;
  }

}
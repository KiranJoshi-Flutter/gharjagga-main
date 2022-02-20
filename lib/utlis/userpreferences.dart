import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static final String _kLoggedIn = "loggedIn";
  static final String _kFirstApp = "firstApp";
  static final String _kName = "name";
  static final String _kUsername = "username";
  static final String _kUserId = "userID";
  static final String _kUserAvatar = "userAvatar";
  static final String _kUserRole = "userRole";
  static final String _kUserEmail = "userEmail";

  static final String _kUserFirstName = "firstname";
  static final String _kUserLastName = "lastname";
  static final String _kToken = "token";

  static void logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(_kLoggedIn, false);
    prefs.remove(_kName);
    prefs.remove(_kUsername);
    prefs.remove(_kUserId);
    prefs.remove(_kUserAvatar);
    prefs.remove(_kUserRole);
    prefs.remove(_kUserEmail);
    prefs.remove(_kUserFirstName);
    prefs.remove(_kUserLastName);
    prefs.remove(_kToken);
  }

  // Get login status
  static Future<bool> getLoginStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var ls;

    if (prefs.getBool(_kLoggedIn) == null) {
      ls = false;
    } else {
      ls = prefs.getBool(_kLoggedIn);
    }

    return ls;
  }

  // Set login status
  static Future<bool> setLoginStatus(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setBool(_kLoggedIn, value);
  }

  // Get FirstApp status
  static Future<bool> getFirstAppStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var ls;

    if (prefs.getBool(_kFirstApp) == null) {
      ls = false;
    } else {
      ls = prefs.getBool(_kFirstApp);
    }

    return ls;
  }

  // Set FirstApp status
  static Future<bool> setFirstAppStatus(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setBool(_kFirstApp, value);
  }

  // School Username
  // ***************************************************************************
  static Future<bool> setUsername(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(_kUsername, value);
  }

  static Future<String?> getUsername() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_kUsername);
  }

  // ***************************************************************************

  // School Name
  // ***************************************************************************
  static Future<bool> setName(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(_kName, value);
  }

  static Future<String?> getName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_kName);
  }

  // ***************************************************************************

  // User Id
  // ***************************************************************************
  static Future<bool> setUserId(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(_kUserId, value);
  }

  static Future<String?> getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_kUserId);
  }

  // ***************************************************************************

  // User Avatar
  // ***************************************************************************
  static Future<bool> setUserAvatar(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(_kUserAvatar, value);
  }

  static Future<String?> getUserAvatar() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_kUserAvatar);
  }

  // ***************************************************************************

  // User Email
  // ***************************************************************************
  static Future<bool> setUserEmail(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(_kUserEmail, value);
  }

  static Future<String?> getUserEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_kUserEmail);
  }

  // ***************************************************************************

  // User Role
  // ***************************************************************************
  static Future<bool> setUserRole(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(_kUserRole, value);
  }

  static Future<String?> getUserRole() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_kUserRole);
  }

  // ***************************************************************************

  // User First Name
  // ***************************************************************************
  static Future<bool> setUserFirstName(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(_kUserFirstName, value);
  }

  static Future<String?> getUserFirstName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_kUserFirstName);
  }

  // ***************************************************************************

  // User First Name
  // ***************************************************************************
  static Future<bool> setUserLastName(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(_kUserLastName, value);
  }

  static Future<String?> getUserLastName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_kUserLastName);
  }

  // ***************************************************************************

  // User Token
  // ***************************************************************************
  static Future<bool> setToken(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(_kToken, value);
  }

  static Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_kToken);
  }

  // ***************************************************************************
}

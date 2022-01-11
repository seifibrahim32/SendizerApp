
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefClass{

  static SharedPreferences? _preferences ;
  bool opened = false;
  static Future init() async {
    _preferences = await SharedPreferences?.getInstance();
    print('instance created');

  }

  static Future setString(String value) async{
    await _preferences!.setString('Divisor', value);
  }

  static String? getString() => _preferences!.getString('Divisor');

}
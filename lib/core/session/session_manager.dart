import 'package:injectable/injectable.dart';
import 'package:ms_outlook_calender/core/session/pref_manager.dart';
import 'package:ms_outlook_calender/core/utils/constant.dart';


@injectable
class SessionManager {

  final PrefManager _prefManager;

  SessionManager(this._prefManager);

  String? get accessToken => _prefManager.getStringValue(Constant.accessToken);

  set accessToken(String? value) => _prefManager.saveString(Constant.accessToken, value ?? "");

  String? get refreshToken => _prefManager.getStringValue(Constant.refreshToken);

  set refreshToken(String? value) => _prefManager.saveString(Constant.refreshToken, value ?? "");

  String? get idToken => _prefManager.getStringValue(Constant.idToken);

  set idToken(String? value) => _prefManager.saveString(Constant.idToken, value ?? "");

  int? get tokenExpiration => _prefManager.getIntValue(Constant.tokenExpiration);

  set tokenExpiration(int? value) => _prefManager.saveInt(Constant.tokenExpiration, value ?? -1);

  void logout() => _prefManager.logOut();
}
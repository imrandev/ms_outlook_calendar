import 'package:injectable/injectable.dart';
import 'package:ms_outlook_calender/core/session/pref_manager.dart';
import 'package:ms_outlook_calender/core/utils/constant.dart';


@injectable
class SessionManager {

  final PrefManager _prefManager;

  SessionManager(this._prefManager);

  String? get accessToken => _prefManager.getStringValue(Constant.accessToken);

  set accessToken(String? value) => _prefManager.saveString(Constant.accessToken, value ?? "");

  void logout() => _prefManager.logOut();
}
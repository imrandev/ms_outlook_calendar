// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i25;

import '../network/api_client.dart' as _i3;
import '../session/pref_manager.dart' as _i45;
import '../session/session_manager.dart' as _i46;
import 'app_module.dart' as _i55; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  final appModule = _$AppModule();
  gh.factory<_i3.ApiClient>(() => _i3.ApiClient());
  await gh.factoryAsync<_i25.SharedPreferences>(
        () => appModule.prefs,
    preResolve: true,
  );
  gh.factory<_i45.PrefManager>(
          () => _i45.PrefManager(get<_i25.SharedPreferences>()));
  gh.factory<_i46.SessionManager>(
          () => _i46.SessionManager(get<_i45.PrefManager>()));
  return get;
}

class _$AppModule extends _i55.AppModule {}

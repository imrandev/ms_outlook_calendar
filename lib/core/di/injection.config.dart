// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:ms_outlook_calender/core/di/app_module.dart' as _i12;
import 'package:ms_outlook_calender/core/network/api_client.dart' as _i3;
import 'package:ms_outlook_calender/core/session/pref_manager.dart' as _i5;
import 'package:ms_outlook_calender/core/session/session_manager.dart' as _i6;
import 'package:ms_outlook_calender/data/repository/outlook_repository_impl.dart'
    as _i8;
import 'package:ms_outlook_calender/domain/repository/outlook_repository.dart'
    as _i7;
import 'package:ms_outlook_calender/domain/usecase/authenticate_usecase.dart'
    as _i9;
import 'package:ms_outlook_calender/domain/usecase/get_calendar_view_usecase.dart'
    as _i10;
import 'package:ms_outlook_calender/domain/usecase/get_schedule_usecase.dart'
    as _i11;
import 'package:shared_preferences/shared_preferences.dart'
    as _i4; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appModule = _$AppModule();
    gh.factory<_i3.ApiClient>(() => _i3.ApiClient());
    await gh.factoryAsync<_i4.SharedPreferences>(
      () => appModule.prefs,
      preResolve: true,
    );
    gh.factory<_i5.PrefManager>(
        () => _i5.PrefManager(gh<_i4.SharedPreferences>()));
    gh.factory<_i6.SessionManager>(
        () => _i6.SessionManager(gh<_i5.PrefManager>()));
    gh.factory<_i7.OutlookRepository>(() => _i8.OutlookRepositoryImpl(
          gh<_i6.SessionManager>(),
          gh<_i3.ApiClient>(),
        ));
    gh.factory<_i9.AuthenticateUseCase>(
        () => _i9.AuthenticateUseCase(gh<_i7.OutlookRepository>()));
    gh.factory<_i10.GetCalendarViewUseCase>(
        () => _i10.GetCalendarViewUseCase(gh<_i7.OutlookRepository>()));
    gh.factory<_i11.GetScheduleUseCase>(
        () => _i11.GetScheduleUseCase(gh<_i7.OutlookRepository>()));
    return this;
  }
}

class _$AppModule extends _i12.AppModule {}

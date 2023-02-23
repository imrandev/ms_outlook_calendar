import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:ms_outlook_calender/core/di/injection.dart';
import 'package:ms_outlook_calender/core/log/logger.dart';
import 'package:ms_outlook_calender/core/session/session_manager.dart';
import 'package:ms_outlook_calender/core/utils/constant.dart';

@injectable
class ApiClient {

  final _dio = Dio(BaseOptions(
    baseUrl: Constant.baseUrl,
    headers: {
      "Authorization" : getIt<SessionManager>().accessToken!,
    },
    receiveDataWhenStatusError: true,
    connectTimeout: const Duration(minutes: 2,),
    receiveTimeout: const Duration(minutes: 1,),
  ))..interceptors.add(Logging());

  Future<dynamic> postWithQuery(String path, {required query}) async {
    Response response = await _dio.post(path, queryParameters: query,);
    logger.e(response.statusMessage);
    if (response.statusCode == 500) return null;
    return response;
  }

  Future<dynamic> postWithData(String path, {required data}) async {
    Response response = await _dio.post(path, data: data,);
    logger.e(response.statusMessage);
    if (response.statusCode == 500) return null;
    return response;
  }

  Future<dynamic> get(String path, {Map<String, dynamic>? params}) async {
    try {
      Response response = await _dio.get(path, queryParameters: params,).catchError((e) {
        logger.e(e.toString());
      });
      logger.e(response.statusMessage);
      if (response.statusCode == 500) return null;
      return response.data;
    } on DioError catch(e) {
      logger.e(e.message);
      return Future.error(e);
    } catch(e){
      logger.e(e.toString());
    }
  }
}
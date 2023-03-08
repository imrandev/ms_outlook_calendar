import 'package:injectable/injectable.dart';
import 'package:ms_outlook_calender/domain/repository/outlook_repository.dart';

@injectable
class AuthenticateUseCase {

  final OutlookRepository _repository;

  AuthenticateUseCase(this._repository);

  Future<bool> invoke(){
    return _repository.authenticated();
  }
}
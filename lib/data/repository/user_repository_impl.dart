import 'package:Smartpay/data/remote/user_remote.dart';
import 'package:Smartpay/data/repository/user_repository.dart';
import 'package:Smartpay/domain/model/get_email_token.dart';
import 'package:Smartpay/domain/model/home.dart';
import 'package:Smartpay/domain/model/login_user.dart';
import 'package:Smartpay/domain/model/register_user.dart';

class UserRepositoryImpl extends UserRepository {
  final UserRemote userRemote;
  UserRepositoryImpl(this.userRemote,);

  @override
  Future<String?> changePassword(String password, String confirmPassword, String email, String otp) {
    // TODO: implement changePassword
    throw UnimplementedError();
  }

  @override
  Future<String?> forgotPassword(String email) {
    // TODO: implement forgotPassword
    throw UnimplementedError();
  }

  @override
  Future<GetEmailTokenResponse?> getEmailToken(String email) async {
    return await userRemote.getEmailToken(email);
  }

  @override
  Future<HomeResponse?> getHomeMessage() async {
    return await userRemote.getHomeMessage();
  }

  @override
  Future<LoginUserResponse?> login(String email, String password) async {
    final response = await userRemote.login(email, password);
    return response;
  }

  @override
  Future<RegisterUserResponse?> register(String fullName, String userName, String email, String country, String password) async {
    return await userRemote.register(fullName, userName, email, country, password);
  }

  @override
  Future<String?> verifyEmailToken(String email, String token) async {
    return await userRemote.verifyEmailToken(email, token);
  }

  @override
  Future<void> clearUserData() {
    // TODO: implement clearUserData
    throw UnimplementedError();
  }
}
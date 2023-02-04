
import 'package:Smartpay/data/remote/user_remote.dart';
import 'package:Smartpay/data/repository/user_repository.dart';
import 'package:Smartpay/domain/model/login_user.dart';
import 'package:Smartpay/domain/model/register_user.dart';
import 'package:Smartpay/domain/model/token_meta_data.dart';
import 'package:Smartpay/utils/sharedpreferences.dart';

class UserRepositoryImpl extends UserRepository {
  final UserRemote userRemote;
  final SharedPreference preference;
  UserRepositoryImpl(this.userRemote, this.preference);

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
  Future<String?> getEmailToken(String email) async {
    return await userRemote.getEmailToken(email);
  }

  @override
  Future<String?> getHomeMessage() async {
    return await userRemote.getHomeMessage();
  }

  @override
  Future<LoginUserResponse?> login(String email, String password) async {
    final response = await userRemote.login(email, password);
    preference.saveAppFirstLaunch(true);
    final tokenMeta = TokenMetaData(
        "${response?.data?.token}",
        DateTime.now().millisecondsSinceEpoch.toDouble(),
        "${response?.data?.user?.id}");
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
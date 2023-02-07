
import 'package:Smartpay/data/cache/user.cache.dart';
import 'package:Smartpay/data/core/table_constants.dart';
import 'package:Smartpay/data/remote/user_remote.dart';
import 'package:Smartpay/data/repository/user_repository.dart';
import 'package:Smartpay/domain/model/login_user.dart';
import 'package:Smartpay/domain/model/register_user.dart';
import 'package:Smartpay/domain/model/token_meta_data.dart';
import 'package:Smartpay/utils/constants.dart';
import 'package:Smartpay/utils/sharedpreferences.dart';

class UserRepositoryImpl extends UserRepository {
  final UserRemote userRemote;
  // final UserCache userCache;
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
  Future<String?> getEmailToken(String email) async {
    return await userRemote.getEmailToken(email);
  }

  @override
  Future<String?> getHomeMessage() async {
    return await userRemote.getHomeMessage();
  }

  @override
  Future<String?> login(String email, String password) async {
    final response = await userRemote.login(email, password);
    storageService.storeItem(key: DbTable.LOGIN_TABLE_NAME, value: "true");
    //await userCache.saveUserLogin(response!.data!);
    // await userCache.updateUserFirstTime(true);
    // final tokenMeta = TokenMetaData(
    //     "Bearer " "response?.data?.token}",
    //     "${response?.data?.user?.fullName}",
    //     "${response?.data?.user?.email}",
    //     "${response?.data?.user?.id}",
    //     DateTime.now().millisecondsSinceEpoch.toDouble(),
    //     );
    // await userCache.saveTokenMetaData(tokenMeta);
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
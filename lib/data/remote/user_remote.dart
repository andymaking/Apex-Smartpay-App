import 'package:Smartpay/domain/model/home.dart';
import 'package:Smartpay/domain/model/login_user.dart';
import 'package:Smartpay/domain/model/register_user.dart';

abstract class UserRemote {

  Future<String?> getEmailToken(String email);

  Future<String?> verifyEmailToken(String email, String token);

  Future<RegisterUserResponse?> register(String fullName, String userName,
      String email, String country, String password);

  Future<LoginUserResponse?> login(String email, String password);

  Future<String?> changePassword(String password, String confirmPassword,
      String email, String otp);

  Future<String?> forgotPassword(String email,);

  //Future<void> logoutUser(TokenMetaData tokenMetaData);

  Future<HomeResponse?> getHomeMessage();
}
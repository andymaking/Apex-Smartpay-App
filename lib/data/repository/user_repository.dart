
import 'package:Smartpay/domain/model/get_email_token.dart';
import 'package:Smartpay/domain/model/home.dart';
import 'package:Smartpay/domain/model/login_user.dart';
import 'package:Smartpay/domain/model/register_user.dart';
import 'package:Smartpay/domain/model/token_meta_data.dart';
import 'package:Smartpay/domain/model/verify_email_token.dart';

abstract class UserRepository {

  Future<String?> getEmailToken(String email);

  Future<String?> verifyEmailToken(String email, String token);

  Future<RegisterUserResponse?> register(String fullName, String userName,
      String email, String country, String password);

  Future<LoginUserResponse?> login(String email, String password);

  Future<String?> changePassword(String password, String confirmPassword,
      String email, String otp);

  Future<String?> forgotPassword(String email,);

  //Future<void> logoutUser(TokenMetaData tokenMetaData);

  Future<String?> getHomeMessage();

  Future<void> clearUserData();
}
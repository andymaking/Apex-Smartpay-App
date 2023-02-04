import 'package:Smartpay/data/core/network_config.dart';
import 'package:Smartpay/data/remote/user_remote.dart';
import 'package:Smartpay/domain/model/get_email_token.dart';
import 'package:Smartpay/domain/model/home.dart';
import 'package:Smartpay/domain/model/login_user.dart';
import 'package:Smartpay/domain/model/register_user.dart';
import 'package:Smartpay/domain/model/token_meta_data.dart';
import 'package:Smartpay/domain/model/verify_email_token.dart';
import 'package:Smartpay/utils/constants.dart';
import 'package:dio/dio.dart';

/// This calls implements the UserRemote logic
class UserRemoteImpl extends UserRemote {

  final Dio dioClient;
  UserRemoteImpl(this.dioClient);

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
    try {
      var _data = {'email': email};
      var response =
          await dioClient.post("${NetworkConfig.BASE_URL}/auth/email", data: _data);
      final responseData = GetEmailTokenResponse.fromJson(response.data).data;
      return responseData?.token;
    } catch (error) {
      print("error: $error");
      handleError(error);
    }
  }

  @override
  Future<String?> getHomeMessage() async {
    try {
      var getToken = sharedPreference.getToken();
      dioClient.options.headers['Authorization'] = getToken;
      var response = await dioClient.get(
        "${NetworkConfig.BASE_URL}/dashboard",
      );
      final responseData = HomeResponse.fromJson(response.data).data;
      return responseData?.secret;
    } catch (error) {
      print("get user error: ${error}");
      handleError(error);
    }
  }

  @override
  Future<LoginUserResponse?> login(String email, String password) async {
    try {
      var _data = { 'email': email, 'password': password, 'device_name': "mobile"};
      var response =
          await dioClient.post("${NetworkConfig.BASE_URL}/auth/register", data: _data);
      final responseData = LoginUserResponse.fromJson(response.data);
      final data = LoginData.fromJson(responseData.data);
      sharedPreference.saveToken(data.token!);
      return responseData;
    } catch (error) {
      print("error: $error");
      handleError(error);
    }
  }

  @override
  Future<RegisterUserResponse?> register(String fullName, String userName,
      String email, String country, String password,) async {
    try {
      var _data = {'full_name': fullName, 'username': userName, 'email': email,
        'country': country, 'password': password, 'device_name': "mobile"};
      var response =
          await dioClient.post("${NetworkConfig.BASE_URL}/auth/register", data: _data);
      final responseData = RegisterUserResponse.fromJson(response.data);
      final data = RegisterData.fromJson(responseData.data);
      sharedPreference.saveToken(data.token!);
      return responseData;
    } catch (error) {
      print("error: $error");
      handleError(error);
    }
  }

  @override
  Future<String?> verifyEmailToken(String email, String token) async {
    try {
      var _data = {'email': email, 'token': token};
      var response =
          await dioClient.post("${NetworkConfig.BASE_URL}/auth/email/verify", data: _data);
      final responseData = VerifyEmailTokenResponse.fromJson(response.data).data;
      return responseData?.email;
    } catch (error) {
      print("error: $error");
      handleError(error);
    }
  }

}
import 'package:Smartpay/data/core/network/App.logger.dart';
import 'package:Smartpay/data/core/network_config.dart';
import 'package:Smartpay/data/core/table_constants.dart';
import 'package:Smartpay/data/remote/user_remote.dart';
import 'package:Smartpay/domain/model/get_email_token.dart';
import 'package:Smartpay/domain/model/home.dart';
import 'package:Smartpay/domain/model/login_user.dart';
import 'package:Smartpay/domain/model/register_user.dart';
import 'package:Smartpay/domain/model/verify_email_token.dart';
import 'package:Smartpay/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// This calls implements the UserRemote logic
class UserRemoteImpl extends UserRemote {

  String token = "";
  final Dio dioClient;
  UserRemoteImpl(this.dioClient,);

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
      getLogger("error: $error");
      handleError(error);
    }
  }

  @override
  Future<String?> getHomeMessage() async {
    try {
      // var getToken = sharedPreference.getToken();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var toaken  = prefs.getString('tokenn');
      var getToken = await storageService.readItem(key: DbTable.TOKEN_TABLE_NAME);
      getLogger("Show token from pref:: $getToken");
      dioClient.options.headers['Authorization'] = "Bearer $toaken";
      dioClient.options.headers['content-type'] = "application/json; charset=utf-8";
      var response = await dioClient.get(
        "${NetworkConfig.BASE_URL}/dashboard",
      );
      final responseData = HomeResponse.fromJson(response.data).data;
      print("getHomeMessage.,.,.,.,.  $response");
      getLogger("token....: $toaken");
      return responseData?.secret;
    } catch (error) {
      handleError(error);
    }
  }

  @override
  Future<String?> login(String email, String password) async {
    try {
      var _data = { 'email': email, 'password': password, 'device_name': "mobile"};
      var response =
          await dioClient.post("${NetworkConfig.BASE_URL}/auth/login", data: _data);
      final responseData = LoginUserResponse.fromJson(response.data);
      setToken(responseData.data?.token);
      getLogger("token....login: $token");
      token = "${responseData.data?.token}";
      storageService.storeItem(key: DbTable.TOKEN_TABLE_NAME, value: responseData.data?.token);
      return responseData.data?.token;
    } catch (error) {
      handleError(error);
    }
  }

  setToken(val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('tokenn', val);
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
      setToken(responseData.data?.token);
      return responseData;
    } catch (error) {
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
      handleError(error);
    }
  }

}
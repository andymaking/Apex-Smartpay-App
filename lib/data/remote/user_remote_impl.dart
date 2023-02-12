import 'package:Smartpay/data/core/network/App.logger.dart';
import 'package:Smartpay/data/core/network/NetworkService.dart';
import 'package:Smartpay/data/core/network/api_error_handler.dart';
import 'package:Smartpay/data/core/network/urlPath.dart';
import 'package:Smartpay/data/core/network_config.dart';
import 'package:Smartpay/data/core/table_constants.dart';
import 'package:Smartpay/data/remote/user_remote.dart';
import 'package:Smartpay/domain/model/get_email_token.dart';
import 'package:Smartpay/domain/model/home.dart';
import 'package:Smartpay/domain/model/login_user.dart';
import 'package:Smartpay/domain/model/register_user.dart';
import 'package:Smartpay/domain/model/verify_email_token.dart';
import 'package:Smartpay/routes/locator.dart';
import 'package:Smartpay/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// This calls implements the UserRemote logic
class UserRemoteImpl extends NetworkService implements UserRemote {

  // String token = "";
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
  Future<GetEmailTokenResponse?> getEmailToken(String email) async {
    try {
      var dataBody = { 'email': email};
      final response = await request(
          path: UrlPath.login,
          method: RequestMethod.post,
          data: dataBody
      );
      return GetEmailTokenResponse.fromJson(response.data);
    } catch (err) {
      getLogger("Log getEmailToken remote error:: $err");
      print("Show getEmailToken remote error:: $err");
      rethrow;
    }
  }

  @override
  Future<HomeResponse?> getHomeMessage() async {

    var authToken = await sharedPreference.getToken();

    try {
      final response = await request(
          path: UrlPath.dashboard,
          method: RequestMethod.get,
        options: Options(
          headers: {
            "Authorization" : "Bearer $authToken",
          }
        ),
      );
      return HomeResponse.fromJson(response.data);
    } catch (err) {
      getLogger("Log getHomeMessage remote error:: $err");
      print("getHomeMessage remote error:: $err");
      rethrow;
    }
  }

  @override
  Future<LoginUserResponse?> login(String email, String password) async {
    try {
      var dataBody = { 'email': email, 'password': password, 'device_name': "mobile"};
      final response = await request(
          path: UrlPath.login,
          method: RequestMethod.post,
          data: dataBody);
      return LoginUserResponse.fromJson(response.data);
    } catch (err) {
      getLogger("Log login remote error:: $err");
      print("Show login remote error:: $err");
      rethrow;
    }
  }

  setToken(val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('tokenn', val);
  }

  @override
  Future<RegisterUserResponse?> register(String fullName, String userName,
      String email, String country, String password,) async {
    // try {
    //   var _data = {'full_name': fullName, 'username': userName, 'email': email,
    //     'country': country, 'password': password, 'device_name': "mobile"};
    //   var response =
    //       await dioClient.post("${NetworkConfig.BASE_URL}/auth/register", data: _data);
    //   final responseData = RegisterUserResponse.fromJson(response.data);
    //   setToken(responseData.data?.token);
    //   return responseData;
    // } catch (error) {
    //   handleError(error);
    // }
  }

  @override
  Future<String?> verifyEmailToken(String email, String token) async {
    // try {
    //   var _data = {'email': email, 'token': token};
    //   var response =
    //       await dioClient.post("${NetworkConfig.BASE_URL}/auth/email/verify", data: _data);
    //   final responseData = VerifyEmailTokenResponse.fromJson(response.data).data;
    //   return responseData?.email;
    // } catch (error) {
    //   handleError(error);
    // }
  }

}
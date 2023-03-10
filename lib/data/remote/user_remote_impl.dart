import 'package:Smartpay/data/core/network/App.logger.dart';
import 'package:Smartpay/data/core/network/NetworkService.dart';
import 'package:Smartpay/data/core/network/urlPath.dart';
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
class UserRemoteImpl extends NetworkService implements UserRemote {

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
          path: UrlPath.getEmailToken,
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
    try {
      var dataBody = {'full_name': fullName, 'username': userName, 'email': email,
        'country': country, 'password': password, 'device_name': "mobile"};
      final response = await request(
          path: UrlPath.register,
          method: RequestMethod.post,
          data: dataBody
      );
      return RegisterUserResponse.fromJson(response.data);
    } catch (err) {
      getLogger("Log register remote error:: $err");
      print("Show register remote error:: $err");
      rethrow;
    }
  }

  @override
  Future<VerifyEmailTokenResponse?> verifyEmailToken(String email, String token) async {
    try {
      var dataBody = {'email': email, 'token': token};
      final response = await request(
          path: UrlPath.verifyEmailOTP,
          method: RequestMethod.post,
          data: dataBody
      );
      return VerifyEmailTokenResponse.fromJson(response.data);
    } catch (err) {
      getLogger("Log verifyEmailToken remote error:: $err");
      print("Show verifyEmailToken remote error:: $err");
      rethrow;
    }
  }

}
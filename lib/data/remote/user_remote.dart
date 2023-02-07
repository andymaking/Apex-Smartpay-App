import 'dart:convert';

import 'package:Smartpay/domain/model/get_email_token.dart';
import 'package:Smartpay/domain/model/home.dart';
import 'package:Smartpay/domain/model/login_user.dart';
import 'package:Smartpay/domain/model/register_user.dart';
import 'package:Smartpay/domain/model/token_meta_data.dart';
import 'package:Smartpay/domain/model/verify_email_token.dart';
import 'package:dio/dio.dart';

abstract class UserRemote {

  Future<String?> getEmailToken(String email);

  Future<String?> verifyEmailToken(String email, String token);

  Future<RegisterUserResponse?> register(String fullName, String userName,
      String email, String country, String password);

  Future<String?> login(String email, String password);

  Future<String?> changePassword(String password, String confirmPassword,
      String email, String otp);

  Future<String?> forgotPassword(String email,);

  //Future<void> logoutUser(TokenMetaData tokenMetaData);

  Future<String?> getHomeMessage();
}

void handleError(dynamic error) {
  print("print errror.runtime :${error.runtimeType}");
  print("print errror.runtime :${error?.response == null}");
  var errorString = error.response.toString();

  if (error is DioError) {
    final errorMessage = DioExceptions.fromDioError(error).toString();
    throw errorMessage;
  } else {
    var json = jsonDecode(errorString);
    var nameJson = json['message'];

    throw nameJson;
  }
}

class DioExceptions implements Exception {
  DioExceptions.fromDioError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.cancel:
        message = "Request to API server was cancelled";
        break;
      case DioErrorType.connectTimeout:
        message = "Connection timeout with API server";
        break;
      case DioErrorType.other:
        message = "Connection to API server failed due to internet connection";
        break;
      case DioErrorType.receiveTimeout:
        message = "Receive timeout in connection with API server";
        break;
      case DioErrorType.response:
        message = _handleError(
            dioError.response?.statusCode ?? 444, dioError.response?.data);
        break;
      case DioErrorType.sendTimeout:
        message = "Send timeout in connection with API server";
        break;
      default:
        message = "Something went wrong";
        break;
    }
  }

  String message = "";

  String _handleError(int statusCode, dynamic error) {
    if (statusCode >= 400 && statusCode <= 499) {
      return error["message"];
    } else if (statusCode >= 500 && statusCode <= 599) {
      return 'Internal server error';
    } else {
      return 'Opps! something went wrong';
    }
  }


  @override
  String toString() => message;
}
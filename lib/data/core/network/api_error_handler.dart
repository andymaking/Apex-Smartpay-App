// ignore_for_file: unused_catch_stack

import 'package:Smartpay/data/core/network/App.logger.dart';
import 'package:Smartpay/data/core/network/LaravelError.dart';
import 'package:dio/dio.dart';

import 'ApiErrorModel.dart';

/// Helper class for converting [DioError] into readable formats
class ApiError {
  int? errorType = 0;

  final logger = getLogger('ApiError');

  /// description of error generated this is similar to convention [Error.message]
  String? errorDescription;

  ApiError({this.errorDescription});

  ApiError.fromDio(Object dioError) {
    _handleError(dioError);
  }

  /// sets value of class properties from [error]
  void _handleError(Object error) {
    if (error is DioError) {
      DioError dioError = error; // as DioError;
      switch (dioError.type) {
        case DioErrorType.cancel:
          errorDescription = "Request to server was cancelled";
          break;
        case DioErrorType.connectTimeout:
          errorDescription = "Connection timeout, please try again later";
          break;
        case DioErrorType.other:
          errorDescription = "Connection failed...";
          break;
        case DioErrorType.receiveTimeout:
          errorDescription = "Timout";
          break;

        case DioErrorType.sendTimeout:
          errorDescription = "Connection failed...";
          break;
        case DioErrorType.response:
          errorType = dioError.response?.statusCode;
          errorDescription = _handleErrorFromStatusCode(dioError.response);
          break;
      }
    } else {
      errorDescription = "Oops an error occurred, we are fixing it";
    }
  }

  @override
  String toString() => '$errorDescription';

  String? _handleErrorFromStatusCode(Response? response) {
    String? message;
    switch (response?.statusCode) {
      case 400:
      case 403:
      case 404:
      case 409:
        message = ApiErrorModel.fromJson(response?.data).message;
        break;
      case 422:
        message = _handleResponseFromLaravel(response);
        break;
      case 500:
        message = 'Something went wrong while processing your request';
        break;
      default:
    }
    return message;
  }

  String _handleResponseFromLaravel(Response<dynamic>? data) {
    final response = LaravelError.fromJson(data?.data);
    if (response.errors!.email!.isNotEmpty) {
      return response.errors!.email!.first;
    }
    if (response.errors!.username!.isNotEmpty) {
      return response.errors!.username!.first;
    }
    if (response.errors!.picture!.isNotEmpty) {
      return response.errors!.picture!.first;
    }
    if (response.errors!.receiverPhoneNo!.isNotEmpty) {
      return response.errors!.receiverPhoneNo!.first;
    }
    return '';
  }
}

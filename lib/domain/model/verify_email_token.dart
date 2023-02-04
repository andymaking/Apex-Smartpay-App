
class VerifyEmailTokenResponse {
  bool? status;
  String? message;
  VerifyEmailTokenData? data;

  VerifyEmailTokenResponse({
    this.status,
    this.message,
    this.data
  });

  VerifyEmailTokenResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? VerifyEmailTokenData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

class VerifyEmailTokenData {
  String? email;

  VerifyEmailTokenData({
    this.email,
  });

  VerifyEmailTokenData.fromJson(dynamic json) {
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['email'] = email;
    return map;
  }

}
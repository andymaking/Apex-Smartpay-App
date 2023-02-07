
class GetEmailTokenResponse {
  bool? status;
  String? message;
  GetEmailTokenData? data;

  GetEmailTokenResponse({
    this.status,
    this.message,
    this.data
  });

  GetEmailTokenResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? GetEmailTokenData.fromJson(json['data']) : null;
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

class GetEmailTokenData {
  String? token;

  GetEmailTokenData({
    this.token,
  });

  GetEmailTokenData.fromJson(dynamic json) {
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['token'] = token;
    return map;
  }

}

class HomeResponse {
  bool? status;
  String? message;
  HomeData? data;

  HomeResponse({
    this.status,
    this.message,
    this.data
  });

  HomeResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? HomeData.fromJson(json['data']) : null;
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

class HomeData {
  String? secret;

  HomeData({
    this.secret,
  });

  HomeData.fromJson(dynamic json) {
    secret = json['secret'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['secret'] = secret;
    return map;
  }

}
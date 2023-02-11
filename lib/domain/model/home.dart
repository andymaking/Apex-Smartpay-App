
class HomeResponse {
  bool? status;
  String? message;
  HomeData? data;

  HomeResponse({
    this.status,
    this.message,
    this.data
  });

  factory HomeResponse.fromJson(Map<String, dynamic> json) {
    return HomeResponse(
        status: json['status'] as bool?,
        message: json['message'] as String?,
        data: HomeData.fromJson(json['data']));
  }

  Map<String, dynamic> toJson() =>
      {'status': status, 'message': message, 'data': data?.toJson()};

}

class HomeData {
  String? secret;

  HomeData({
    this.secret,
  });

  factory HomeData.fromJson(Map<String, dynamic> json) {
    return HomeData(
      secret: json['secret'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'secret': secret,
  };

}
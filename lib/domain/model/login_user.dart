class LoginUserResponse {
  bool? status;
  String? message;
  LoginData? data;

  LoginUserResponse({this.status, this.message, this.data});

  factory LoginUserResponse.fromJson(Map<String, dynamic> json) {
    return LoginUserResponse(
        status: json['status'] as bool?,
        message: json['message'] as String?,
        data: LoginData.fromJson(json['data']));
  }

  Map<String, dynamic> toJson() =>
      {'status': status, 'message': message, 'data': data?.toJson()};
}

class LoginData {
  LoginUserData? user;
  String? token;

  LoginData({this.user, this.token,});

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      user: LoginUserData.fromJson(json['user']),
      token: json['token'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'user': user?.toJson(),
    'token': token,
  };
}

class LoginUserData {
  String? id;
  String? fullName;
  String? userName;
  String? email;
  String? phone;
  String? phoneCountry;
  String? country;
  String? avatar;

  LoginUserData({
    this.id,
    this.fullName,
    this.userName,
    this.email,
    this.phone,
    this.phoneCountry,
    this.country,
    this.avatar,
  });

  factory LoginUserData.fromJson(Map<String, dynamic> json) {
    return LoginUserData(
      id: json['id'] as String?,
      fullName: json['full_name'] as String?,
      userName: json['username'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      phoneCountry: json['phone_country'] as String?,
      country: json['country'] as String?,
      avatar: json['avatar'] as String?,

    );}

  Map<String, dynamic> toJson() => {
    'id': id,
    'full_name': fullName,
    'username': userName,
    'email': email,
    'phone': phone,
    'phone_country': phoneCountry,
    'country': country,
    'avatar': avatar,
  };

}

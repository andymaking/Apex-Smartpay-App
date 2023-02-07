
class RegisterUserResponse {
  bool? status;
  String? message;
  RegisterData? data;

  RegisterUserResponse({
    this.status,
    this.message,
    this.data,});

  factory RegisterUserResponse.fromJson(Map<String, dynamic> json) {
    return RegisterUserResponse(
        status: json['status'] as bool?,
        message: json['message'] as String?,
        data: RegisterData.fromJson(json['data']));
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'data': data?.toJson()
  };
}


class RegisterData {
  RegisterUserData? user;
  String? token;

  RegisterData({this.user, this.token,});

  factory RegisterData.fromJson(Map<String, dynamic> json) {
    return RegisterData(
        user: RegisterUserData.fromJson(json['user']),
        token: json['token'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'user': user?.toJson(),
    'token': token,
  };
}

class RegisterUserData {
  String? fullName;
  String? userName;
  String? email;
  String? country;
  String? id;

  RegisterUserData({
    this.fullName,
    this.userName,
    this.email,
    this.country,
    this.id,
  });

  factory RegisterUserData.fromJson(Map<String, dynamic> json) {
    return RegisterUserData(
      fullName: json['full_name'] as String?,
      userName: json['username'] as String?,
      email: json['email'] as String?,
      country: json['country'] as String?,
      id: json['id'] as String?,
    );}

  Map<String, dynamic> toJson() => {
    'full_name': fullName,
    'userName': userName,
    'email': email,
    'country': country,
    'id': id,
  };

}
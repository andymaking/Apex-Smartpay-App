
class LoginUserResponse {
  bool? status;
  String? message;
  LoginData? data;

  LoginUserResponse({
    this.status,
    this.message,
    this.data
  });

  LoginUserResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? LoginData.fromJson(json['data']) : null;
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

class LoginData {
  LoginUserData? user;
  String? token;

  LoginData({
    this.user,
    this.token,
  });

  LoginData.fromJson(dynamic json) {
    user = json['user'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['user'] = user;
    map['token'] = token;
    return map;
  }

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

  LoginUserData.fromJson(dynamic json) {
    id = json['id'];
    fullName = json['full_name'];
    userName = json['username'];
    email = json['email'];
    phone = json['phone'];
    phoneCountry = json['phoneCountry'];
    country = json['country'];
    avatar = json['avatar'];

  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['full_name'] = fullName;
    map['username'] = userName;
    map['email'] = email;
    map['phone'] = phone;
    map['phone_country'] = phoneCountry;
    map['country'] = country;
    map['avatar'] = avatar;

    return map;
  }

}
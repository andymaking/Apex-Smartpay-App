
class RegisterUserResponse {
  bool? status;
  String? message;
  RegisterData? data;

  RegisterUserResponse({
    this.status,
    this.message,
    this.data
  });

  RegisterUserResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? RegisterData.fromJson(json['data']) : null;
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

class RegisterData {
  RegisterUserData? user;
  String? token;

  RegisterData({
    this.user,
    this.token,
  });

  RegisterData.fromJson(dynamic json) {
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

  RegisterUserData.fromJson(dynamic json) {
    fullName = json['full_name'];
    userName = json['username'];
    email = json['email'];
    country = json['country'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['full_name'] = fullName;
    map['username'] = userName;
    map['email'] = email;
    map['country'] = country;
    map['id'] = id;
    return map;
  }

}
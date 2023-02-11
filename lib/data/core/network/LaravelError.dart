class LaravelError {
  bool? status;
  String? message;
  int? code;
  Errors? errors;

  LaravelError({this.status, this.message, this.code, this.errors});

  LaravelError.fromJson(Map<String, dynamic> json) {
    if (json["status"] is bool) {
      status = json["status"];
    }
    if (json["message"] is String) {
      message = json["message"];
    }
    if (json["code"] is int) {
      code = json["code"];
    }
    if (json["errors"] is Map) {
      errors = json["errors"] == null ? null : Errors.fromJson(json["errors"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["status"] = status;
    data["message"] = message;
    data["code"] = code;
    if (errors != null) {
      data["errors"] = errors?.toJson();
    }
    return data;
  }
}

class Errors {
  List<String>? email = [];
  List<String>? username = [];
  List<String>? picture = [];
  List<String>? receiverPhoneNo = [];
  List<String>? token = [];
  List<String>? country = [];
  List<String>? deviceName = [];
  List<String>? password = [];
  List<String>? secret = [];

  Errors({this.email, this.username, this.picture, this.receiverPhoneNo,
    this.token, this.country, this.deviceName, this.password, this.secret});

  Errors.fromJson(Map<String, dynamic> json) {
    if (json["email"] is List) {
      email = json["email"] == null ? [] : List<String>.from(json["email"]);
    }
    if (json["username"] is List) {
      username =
          json["username"] == null ? [] : List<String>.from(json["username"]);
    }
    if (json["picture"] is List) {
      picture =
          json["picture"] == null ? [] : List<String>.from(json["picture"]);
    }
    if (json["phone"] is List) {
      receiverPhoneNo =
          json["phone"] == null ? [] : List<String>.from(json["phone"]);
    }
    if (json["token"] is List) {
      token =
          json["token"] == null ? [] : List<String>.from(json["token"]);
    }
    if (json["country"] is List) {
      country =
          json["country"] == null ? [] : List<String>.from(json["country"]);
    }
    if (json["device_name"] is List) {
      deviceName =
          json["device_name"] == null ? [] : List<String>.from(json["device_name"]);
    }
    if (json["password"] is List) {
      password =
          json["password"] == null ? [] : List<String>.from(json["password"]);
    }
    if (json["secret"] is List) {
      secret =
          json["secret"] == null ? [] : List<String>.from(json["secret"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (email != null) data["email"] = email;
    return data;
  }
}

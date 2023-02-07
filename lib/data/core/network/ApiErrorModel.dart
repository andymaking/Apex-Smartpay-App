class ApiErrorModel {
  String? status;
  String? message;

  ApiErrorModel({this.status, this.message});

  factory ApiErrorModel.fromJson(Map<String, dynamic> json) {
    return ApiErrorModel(
      status: json['status'] as String?,
      message: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {'status': status, 'message': message};
}

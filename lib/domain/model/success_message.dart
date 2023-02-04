
class GetEmailTokenResponse {
  bool? status;
  String? message;
  SuccessMessageData? data;

  GetEmailTokenResponse({
    this.status,
    this.message,
    this.data
  });

  GetEmailTokenResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['message'] = message;
    return map;
  }

}

class SuccessMessageData {
  double? amount;
  double? amountPerAddress;
  bool? claimed;

  SuccessMessageData({
    this.amount,
    this.amountPerAddress,
    this.claimed,
  });

  SuccessMessageData.fromJson(dynamic json) {
    amount = json['amount'];
    amountPerAddress = json['amount_per_address'];
    claimed = json['claimed'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['amount'] = amount;
    map['amount_per_address'] = amountPerAddress;
    map['claimed'] = claimed;
    return map;
  }

}
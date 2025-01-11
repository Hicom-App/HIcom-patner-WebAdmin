class CardsModel {
  int? status;
  String? message;
  List<Result>? result;

  CardsModel({this.status, this.message, this.result});

  CardsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  int? id;
  String? cardNo;
  String? cardHolder;
  String? expirationDate;
  int? userId;
  int? expired;

  Result({this.id, this.cardNo, this.cardHolder, this.expirationDate, this.userId, this.expired});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cardNo = json['card_no'];
    cardHolder = json['card_holder'];
    expirationDate = json['expiration_date'];
    userId = json['user_id'];
    expired = json['expired'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['card_no'] = cardNo;
    data['card_holder'] = cardHolder;
    data['expiration_date'] = expirationDate;
    data['user_id'] = userId;
    data['expired'] = expired;
    return data;
  }
}

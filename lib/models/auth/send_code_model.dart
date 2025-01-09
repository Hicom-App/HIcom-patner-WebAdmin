class SendCodeModel {
  int? status;
  String? message;
  Result? result;

  SendCodeModel({this.status, this.message, this.result});

  SendCodeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    result =
    json['result'] != null ? Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (result != null) {
      data['result'] = result!.toJson();
    }
    return data;
  }
}

class Result {
  int? attempts;
  String? confirmationId;
  String? validUntil;

  Result({this.attempts, this.confirmationId, this.validUntil});

  Result.fromJson(Map<String, dynamic> json) {
    attempts = json['attempts'];
    confirmationId = json['confirmation_id'];
    validUntil = json['valid_until'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['attempts'] = attempts;
    data['confirmation_id'] = confirmationId;
    data['valid_until'] = validUntil;
    return data;
  }
}

class ProfileInfoModel {
  int? status;
  String? message;
  List<Result>? result;

  ProfileInfoModel({this.status, this.message, this.result});

  ProfileInfoModel.fromJson(Map<String, dynamic> json) {
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
  String? firstName;
  String? lastName;
  String? birthday;
  int? userType;
  int? countryId;
  int? regionId;
  int? cityId;
  String? address;
  String? phone;
  String? photoUrl;
  int? cashbackCalculated;
  int? cashbackWithdrawn;
  int? cashbackWaiting;
  int? cashbackRejected;
  int? cashbackRemain;

  Result({this.id, this.firstName, this.lastName, this.birthday, this.userType, this.countryId, this.regionId, this.cityId, this.address, this.phone, this.photoUrl, this.cashbackCalculated, this.cashbackWithdrawn, this.cashbackWaiting, this.cashbackRejected, this.cashbackRemain});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    birthday = json['birthday'];
    userType = json['user_type'];
    countryId = json['country_id'];
    regionId = json['region_id'];
    cityId = json['city_id'];
    address = json['address'];
    phone = json['phone'];
    photoUrl = json['photo_url'];
    cashbackCalculated = json['cashback_calculated'];
    cashbackWithdrawn = json['cashback_withdrawn'];
    cashbackWaiting = json['cashback_waiting'];
    cashbackRejected = json['cashback_rejected'];
    cashbackRemain = json['cashback_remain'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['birthday'] = birthday;
    data['user_type'] = userType;
    data['country_id'] = countryId;
    data['region_id'] = regionId;
    data['city_id'] = cityId;
    data['address'] = address;
    data['phone'] = phone;
    data['photo_url'] = photoUrl;
    data['cashback_calculated'] = cashbackCalculated;
    data['cashback_withdrawn'] = cashbackWithdrawn;
    data['cashback_waiting'] = cashbackWaiting;
    data['cashback_rejected'] = cashbackRejected;
    data['cashback_remain'] = cashbackRemain;
    return data;
  }
}

class SortedWarrantyModel {
  int? status;
  String? message;
  List<Result>? result;

  SortedWarrantyModel({this.status, this.message, this.result});

  SortedWarrantyModel.fromJson(Map<String, dynamic> json) {
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
  String? date;
  List<Results>? result;

  Result({this.date, this.result});

  Result.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    if (json['result'] != null) {
      result = <Results>[];
      json['result'].forEach((v) {
        result!.add(Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  int? id;
  int? productId;
  String? serialCode;
  int? cashback;
  String? warrantyStart;
  String? warrantyExpire;
  String? dateCreated;
  String? name;
  int? categoryId;
  String? brand;
  String? photoUrl;
  String? description;

  Results(
      {this.id,
        this.productId,
        this.serialCode,
        this.cashback,
        this.warrantyStart,
        this.warrantyExpire,
        this.dateCreated,
        this.name,
        this.categoryId,
        this.brand,
        this.photoUrl,
        this.description});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    serialCode = json['serial_code'];
    cashback = json['cashback'];
    warrantyStart = json['warranty_start'];
    warrantyExpire = json['warranty_expire'];
    dateCreated = json['date_created'];
    name = json['name'];
    categoryId = json['category_id'];
    brand = json['brand'];
    photoUrl = json['photo_url'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_id'] = productId;
    data['serial_code'] = serialCode;
    data['cashback'] = cashback;
    data['warranty_start'] = warrantyStart;
    data['warranty_expire'] = warrantyExpire;
    data['date_created'] = dateCreated;
    data['name'] = name;
    data['category_id'] = categoryId;
    data['brand'] = brand;
    data['photo_url'] = photoUrl;
    data['description'] = description;
    return data;
  }
}

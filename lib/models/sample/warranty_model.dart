import 'package:intl/intl.dart';

class WarrantyModel {
  int? status;
  String? message;
  List<Result>? result;

  WarrantyModel({this.status, this.message, this.result});

  WarrantyModel.fromJson(Map<String, dynamic> json) {
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
  int? productId;
  String? name;
  int? categoryId;
  String? brand;
  int? cashback;
  String? serialCode;
  String? warrantyStart;
  String? warrantyExpire;
  String? dateCreated;
  String? photoUrl;
  int? active;
  int? isArchived;
  String? description;

  Result({this.id, this.productId, this.name, this.categoryId, this.brand, this.cashback, this.serialCode, this.warrantyStart, this.warrantyExpire, this.dateCreated, this.photoUrl, this.active,this.isArchived, this.description,});

  Result.fromJson(Map<String, dynamic> json) {
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
    active = json['active'];
    isArchived = json['is_archived'];
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
    data['active'] = active;
    data['is_archived'] = isArchived;
    data['description'] = description;
    return data;
  }
}

class SortedWarrantyModel {
  int? status;
  String? message;
  List<SortedResult>? result;

  SortedWarrantyModel({this.status, this.message, this.result});

  SortedWarrantyModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['result'] != null) {
      result = <SortedResult>[];
      json['result'].forEach((v) {result!.add(SortedResult.fromJson(v));});
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (result != null) {data['result'] = result!.map((v) => v.toJson()).toList();}
    return data;
  }
}

class SortedResult {
  String? date;
  List<Result>? result;

  SortedResult({this.date, this.result});

  SortedResult.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {result!.add(Result.fromJson(v));});
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    if (result != null) {data['result'] = result!.map((v) => v.toJson()).toList();}
    return data;
  }
}

// Function to convert the original data to sorted structure
SortedWarrantyModel convertToSortedWarrantyModel(WarrantyModel warrantyModel) {
  SortedWarrantyModel sortedModel = SortedWarrantyModel(status: warrantyModel.status, message: warrantyModel.message, result: []);

  Map<String, List<Result>> groupedResults = {};

  String getMonth(String date) {
    switch (date) {
      case "01":
        return "yan";
      case "02":
        return "fev";
      case "03":
        return "mar";
      case "04":
        return "ap";
      case "05":
        return "may";
      case "06":
        return "iyn";
      case "07":
        return "iyl";
      case "08":
        return "avq";
      case "09":
        return "sen";
      case "10":
        return "okt";
      case "11":
        return "noy";
      case "12":
        return "dek";
      default:
        return "";
    }
  }

  for (var res in warrantyModel.result!) {
    String dateKey = "";
    if (res.warrantyStart!.contains(DateFormat('yyyy-MM-dd').format(DateTime.now()))) {
      dateKey = "bugun";
    } else if (res.warrantyStart!.contains(DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(const Duration(days: 1))))) {
      dateKey = "kecha";
    } else {
      dateKey = "${DateFormat('dd').format(DateTime.parse(res.warrantyStart!))} ${getMonth(DateFormat('MM').format(DateTime.parse(res.warrantyStart!)))}";
    }

    if (!groupedResults.containsKey(dateKey)) {
      groupedResults[dateKey] = [];
    }
    groupedResults[dateKey]!.add(res);
  }

  groupedResults.forEach((key, value) {
    sortedModel.result!.add(SortedResult(date: key, result: value));
  });

  return sortedModel;
}

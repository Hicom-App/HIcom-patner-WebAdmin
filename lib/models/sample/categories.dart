class CategoriesProductsModel {
  List<CategoriesModel>? all;

  CategoriesProductsModel({this.all});

  CategoriesProductsModel.fromJson(Map<String, dynamic> json) {
    if (json['all'] != null) {
      all = <CategoriesModel>[];
      json['all'].forEach((v) {
        all!.add(CategoriesModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (all != null) {
      data['all'] = all!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


class CategoriesModel {
  int? status;
  String? message;
  List<Result>? result;
  CategoriesModel({this.status, this.message, this.result});

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];

    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {result!.add(Result.fromJson(v));});
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

class Result {int? id;int? active;String? name;int? categoryId;int? cashback; String? categoryName; int? warranty; String? brand; int? price; int? discount;int? reviews;var rating;String? description;String? photoUrl;int? favorite;

  Result({this.id, this.active, this.name, this.categoryId, this.categoryName, this.cashback, this.warranty, this.brand, this.price, this.discount, this.reviews, this.rating, this.description, this.photoUrl, this.favorite});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    active = json['active'];
    name = json['name'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    cashback = json['cashback'];
    warranty = json['warranty'];
    brand = json['brand'];
    price = json['price'];
    discount = json['discount'];
    reviews = json['reviews'];
    rating = json['rating'];
    description = json['description'];
    photoUrl = json['photo_url'];
    favorite = json['favorite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['active'] = active;
    data['name'] = name;
    data['category_id'] = categoryId;
    data['category_name'] = categoryName;
    data['cashback'] = cashback;
    data['warranty'] = warranty;
    data['brand'] = brand;
    data['price'] = price;
    data['discount'] = discount;
    data['reviews'] = reviews;
    data['rating'] = rating;
    data['description'] = description;
    data['photo_url'] = photoUrl;
    data['favorite'] = favorite;
    return data;
  }
}
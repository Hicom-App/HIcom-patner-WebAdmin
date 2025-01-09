class ReviewsModel {
  int? status;
  String? message;
  List<Result>? result;

  ReviewsModel({this.status, this.message, this.result});

  ReviewsModel.fromJson(Map<String, dynamic> json) {
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
  int? userId;
  String? userName;
  String? userAvatar;
  int? rating;
  String? review;
  String? dateCreated;

  Result(
      {this.id,
        this.productId,
        this.userId,
        this.userName,
        this.userAvatar,
        this.rating,
        this.review,
        this.dateCreated});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    userId = json['user_id'];
    userName = json['user_name'];
    userAvatar = json['user_avatar'];
    rating = json['rating'];
    review = json['review'];
    dateCreated = json['date_created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_id'] = productId;
    data['user_id'] = userId;
    data['user_name'] = userName;
    data['user_avatar'] = userAvatar;
    data['rating'] = rating;
    data['review'] = review;
    data['date_created'] = dateCreated;
    return data;
  }
}

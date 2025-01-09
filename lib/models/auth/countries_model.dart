class CountriesModel {
  int? status;
  String? message;
  List<Countries>? countries;
  List<Regions>? regions;
  List<Cities>? cities;

  CountriesModel({this.status, this.message, this.countries, this.regions, this.cities});

  CountriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['result'] != null) {
      countries = <Countries>[];
      json['result'].forEach((v) {countries!.add(Countries.fromJson(v));});
    }
    if (json['result'] != null) {
      regions = <Regions>[];
      json['result'].forEach((v) {regions!.add(Regions.fromJson(v));});
    }
    if (json['result'] != null) {
      cities = <Cities>[];
      json['result'].forEach((v) {cities!.add(Cities.fromJson(v));});
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (countries != null) {data['result'] = countries!.map((v) => v.toJson()).toList();}
    if (regions != null) {data['result'] = regions!.map((v) => v.toJson()).toList();}
    if (cities != null) {data['result'] = cities!.map((v) => v.toJson()).toList();}
    return data;
  }
}

class Countries {
  int? id;
  String? name;
  String? phoneCode;
  String? flagUrl;

  Countries({this.id, this.name, this.phoneCode, this.flagUrl});

  Countries.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phoneCode = json['phone_code'];
    flagUrl = json['flag_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone_code'] = phoneCode;
    data['flag_url'] = flagUrl;
    return data;
  }
}

class Regions {
  int? id;
  int? countryId;
  String? name;

  Regions({this.id, this.countryId, this.name});

  Regions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    countryId = json['country_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['country_id'] = countryId;
    data['name'] = name;
    return data;
  }
}


class Cities {
  int? id;
  int? regionId;
  String? name;

  Cities({this.id, this.regionId, this.name});

  Cities.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    regionId = json['region_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['region_id'] = regionId;
    data['name'] = name;
    return data;
  }
}
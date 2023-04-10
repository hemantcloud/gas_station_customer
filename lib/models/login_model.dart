class LoginModel {
  bool? status;
  String? message;
  Data? data;

  LoginModel({this.status, this.message, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  UserData? userData;

  Data({this.userData});

  Data.fromJson(Map<String, dynamic> json) {
    userData = json['userData'] != null
        ? new UserData.fromJson(json['userData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userData != null) {
      data['userData'] = this.userData!.toJson();
    }
    return data;
  }
}

class UserData {
  int? id;
  String? uniqueId;
  String? fullName;
  String? email;
  String? mobileNumber;
  String? countryCode;
  String? profileImage;
  String? address1;
  String? address2;
  String? city;
  String? state;
  String? zipCode;
  String? mobileVerify;
  String? emailVerify;
  String? latitude;
  String? longitude;
  String? timezone;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;
  String? authToken;

  UserData(
      {this.id,
        this.uniqueId,
        this.fullName,
        this.email,
        this.mobileNumber,
        this.countryCode,
        this.profileImage,
        this.address1,
        this.address2,
        this.city,
        this.state,
        this.zipCode,
        this.mobileVerify,
        this.emailVerify,
        this.latitude,
        this.longitude,
        this.timezone,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.authToken});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uniqueId = json['unique_id'];
    fullName = json['full_name'];
    email = json['email'];
    mobileNumber = json['mobile_number'];
    countryCode = json['country_code'];
    profileImage = json['profileImage'];
    address1 = json['address_1'];
    address2 = json['address_2'];
    city = json['city'];
    state = json['state'];
    zipCode = json['zip_code'];
    mobileVerify = json['mobile_verify'];
    emailVerify = json['email_verify'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    timezone = json['timezone'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    authToken = json['auth_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['unique_id'] = this.uniqueId;
    data['full_name'] = this.fullName;
    data['email'] = this.email;
    data['mobile_number'] = this.mobileNumber;
    data['country_code'] = this.countryCode;
    data['profileImage'] = this.profileImage;
    data['address_1'] = this.address1;
    data['address_2'] = this.address2;
    data['city'] = this.city;
    data['state'] = this.state;
    data['zip_code'] = this.zipCode;
    data['mobile_verify'] = this.mobileVerify;
    data['email_verify'] = this.emailVerify;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['timezone'] = this.timezone;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['auth_token'] = this.authToken;
    return data;
  }
}

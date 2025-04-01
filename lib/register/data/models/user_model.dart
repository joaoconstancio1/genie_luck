class UserModel {
  String? address;
  String? addressNumber;
  String? birthDate;
  String? city;
  String? country;
  String? email;
  String? fullName;
  String? password;
  int? id;
  String? phoneNumber;
  bool? receivePromotions;
  String? state;
  bool? termsAccepted;
  String? zipCode;

  UserModel({
    this.address,
    this.addressNumber,
    this.birthDate,
    this.city,
    this.country,
    this.email,
    this.fullName,
    this.password,
    this.id,
    this.phoneNumber,
    this.receivePromotions,
    this.state,
    this.termsAccepted,
    this.zipCode,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    addressNumber = json['address_number'];
    birthDate = json['birth_date'];
    city = json['city'];
    country = json['country'];
    email = json['email'];
    fullName = json['full_name'];
    password = json['password'];
    id = json['id'];
    phoneNumber = json['phone_number'];
    receivePromotions = json['receive_promotions'];
    state = json['state'];
    termsAccepted = json['terms_accepted'];
    zipCode = json['zip_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address'] = address;
    data['address_number'] = addressNumber;
    data['birth_date'] = birthDate;
    data['city'] = city;
    data['country'] = country;
    data['email'] = email;
    data['full_name'] = fullName;
    data['password'] = password;
    data['id'] = id;
    data['phone_number'] = phoneNumber;
    data['receive_promotions'] = receivePromotions;
    data['state'] = state;
    data['terms_accepted'] = termsAccepted;
    data['zip_code'] = zipCode;
    return data;
  }
}

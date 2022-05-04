class UserApi {
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? sId;
  int? iV;
  String? token;

  UserApi(
      {this.firstName,
      this.lastName,
      this.email,
      this.password,
      this.sId,
      this.iV,
      this.token});

  UserApi.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    password = json['password'];
    sId = json['_id'];
    iV = json['__v'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['password'] = password;
    data['_id'] = sId;
    data['__v'] = iV;
    data['token'] = token;
    return data;
  }
}

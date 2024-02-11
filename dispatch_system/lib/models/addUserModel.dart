class addUserModel {
  String? message;
  User? user;

  addUserModel({this.message, this.user});

  addUserModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  String? sId;
  String? name;
  String? phoneNo;
  List<String>? emergencyContacts;

  User({this.sId, this.name, this.phoneNo, this.emergencyContacts});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    phoneNo = json['phoneNo'];
    emergencyContacts = json['emergencyContacts'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['phoneNo'] = this.phoneNo;
    data['emergencyContacts'] = this.emergencyContacts;
    return data;
  }
}

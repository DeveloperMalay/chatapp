class UserModel {
  String? uid;
  String? email;
  String? fullname;
  String? profilePic;

//default constructor
  UserModel({this.email, this.fullname, this.profilePic, this.uid});

//converting firebase_json data to map and then cenvert this into a object
  UserModel.fromMap(Map<String, dynamic> map) {
    uid = map['uid'];
    fullname = map['fullname'];
    email = map['email'];
    profilePic = map['profilePic'];
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'fullname': fullname,
      'email': email,
      'profilePic': profilePic,
    };
  }
}

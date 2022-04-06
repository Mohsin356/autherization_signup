import 'package:autherization/main.dart';

class UserModel{
  String? uid;
  String? userName;
  String? userEmail;
  String? userPhone;
  UserModel({this.uid,this.userName,this.userEmail,this.userPhone});
  //data from server
  factory UserModel.fromMap(map){
    return UserModel(
      uid: map['uid'],
      userEmail: map['useremail'],
      userName: map['username'],
      userPhone: map['phone'],
    );
  }
  //sending data to server
Map<String, dynamic> toMap(){
    return{
      'uid': uid,
      'useremail':userEmail,
      'username':userName,
      'phone':userPhone,
    };
}

}
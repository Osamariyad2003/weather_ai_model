import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  String? name;
  String? email;
  String? uId;
  String? image;


 UserModel({
    this.name,
    this.email,
    this.uId,
    this.image,
  });

   UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    uId = json['uId'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    data['email'] = email;
    data['uId'] = uId;
    data['image'] = image;
    return data;
  }

  @override
  List<Object?> get props => [name,email,uId,image];
}
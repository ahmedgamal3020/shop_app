
class ShopUserModel{
  bool? status;
  String? message;
  UserData?data;

  ShopUserModel.fromJson(Map<String,dynamic>json)
  {
    status=json['status'];
    message=json['message'];
    data=json['data']!=null? UserData.fromJson(json['data']):null;

  }

}

class UserData {

  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  String? password;
  int? points;
  int? credit;
  String? token;


//named constrictor
  UserData.fromJson(Map<String,dynamic>json){

    id=json['id'];
    name=json['name'];
    email=json['email'];
    phone=json['phone'];
    image=json['image'];
    password=json['password'];
    points=json['points'];
    credit=json['credit'];
    token=json['token'];

  }
}
class LoginModel
{
  LoginDataModel? data;
  String? token;
  LoginModel.fromJson(Map<String,dynamic> json)
  {
    data=json['data']!=null?LoginDataModel.formJson(json['data']) : null;
    token=json['token'];
  }
}
class LoginDataModel
{
  int? id;
  String? username;
  String? email;
  String? role;
  Profile? profile;
  LoginDataModel.formJson(Map<String,dynamic>json)
  {

    id = json['id'];
    username = json['username'];
    email = json['email'];
    role = json['role'];
    profile = json['profile'] != null ? Profile.fromJson(json['profile']) : null;
  }

}
class Profile
{
  int? id;
  //Comp
  String? name;
  String? workField;
  //------
  String? firstName;
  String? lastName;
  String? phone;
  String? address;
  String? birthdate;
  String? cv;
  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    //Company
    name = json['name'];
    workField = json['work_field'];
    //----
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    address = json['address'];
    birthdate = json['birthdate'];
    cv = json['cv'];
  }
}
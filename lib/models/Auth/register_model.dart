class RegisterModel
{
  String ?token;

  RegisterModel.fromJson(Map<String,dynamic> json)
  {
    token=json['key'];
    print(token);
  }

}
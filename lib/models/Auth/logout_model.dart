class LogoutModel
{
  String? message;
  LogoutModel.fromJson(Map<String,dynamic> json)
  {
    message=json['message'];
    print('message : $message');
  }
}

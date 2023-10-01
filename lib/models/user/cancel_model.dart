class UserCancelJobModel {
  String? message;
  UserCancelJobModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }
}

class DeleteModel {
  String? message;
  DeleteModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }
}

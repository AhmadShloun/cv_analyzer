class UserModel {
  List<DataUserModel>? data;
  UserModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <DataUserModel>[];
      json['data'].forEach((v) {
        data!.add(DataUserModel.fromJson(v));
      });
    }
  }
}

class DataUserModel {
  int? id;
  String? subject;
  String? requiredSkills;
  int? requiredWorkExperience;
  String? requiredSoftSkills;
  String? requiredLanguages;
  String? expireTime;
  String? status;
  Company? company;

  DataUserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subject = json['subject'];
    requiredSkills = json['required_skills'];
    requiredWorkExperience = json['required_work_experience'];
    requiredSoftSkills = json['required_soft_skills'];
    requiredLanguages = json['required_languages'];
    expireTime = json['expire_time'];
    status = json['status'];
    company =
    json['company'] != null ? Company.fromJson(json['company']) : null;
  }

}

class Company {
  int? id;
  String? name;
  String? workField;
  Company.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    workField = json['work_field'];
  }
}

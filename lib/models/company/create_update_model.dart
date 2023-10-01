class CreateUpdateModel {
  DataModelCU? data;
  String? message;

  CreateUpdateModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? DataModelCU.fromJson(json['data']) : null;
    message = json['message'];
  }
}

class DataModelCU {
  int? id;
  String? subject;
  String? requiredSkills;
  String? requiredWorkExperience;
  String? requiredSoftSkills;
  String? requiredLanguages;
  String? expireTime;
  String? status;
  Company? company;

  DataModelCU.fromJson(Map<String, dynamic> json) {
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

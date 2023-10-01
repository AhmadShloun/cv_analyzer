class UserSingleJobModel {
  DataJobModel? data;
  UserSingleJobModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? DataJobModel.fromJson(json['data']) : null;
  }

}

class DataJobModel {
  int? id;
  String? subject;
  String? requiredSkills;
  int? requiredWorkExperience;
  String? requiredSoftSkills;
  String? requiredLanguages;
  String? expireTime;
  String? status;
  bool? isApply;
  Company? company;


  DataJobModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subject = json['subject'];
    requiredSkills = json['required_skills'];
    requiredWorkExperience = json['required_work_experience'];
    requiredSoftSkills = json['required_soft_skills'];
    requiredLanguages = json['required_languages'];
    expireTime = json['expire_time'];
    status = json['status'];
    isApply = json['is_apply'];
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

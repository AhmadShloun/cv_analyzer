class ShowSingleJobAnalyzesModel {
  DataSingleJobAnalyzesModel? data;

  ShowSingleJobAnalyzesModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? DataSingleJobAnalyzesModel.fromJson(json['data']) : null;
  }
}

class DataSingleJobAnalyzesModel {
  int? id;
  String? subject;
  String? requiredSkills;
  int? requiredWorkExperience;
  String? requiredSoftSkills;
  String? requiredLanguages;
  Company? company;
  Null? results;

  DataSingleJobAnalyzesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subject = json['subject'];
    requiredSkills = json['required_skills'];
    requiredWorkExperience = json['required_work_experience'];
    requiredSoftSkills = json['required_soft_skills'];
    requiredLanguages = json['required_languages'];
    company =
    json['company'] != null ? Company.fromJson(json['company']) : null;
    results = json['results'];
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

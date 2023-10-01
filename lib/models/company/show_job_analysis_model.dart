class ShowJobAnalyzesModel {

  List<DataJobAnalysisShow>? data;

  ShowJobAnalyzesModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <DataJobAnalysisShow>[];
      json['data'].forEach((v) {
        data!.add(DataJobAnalysisShow.fromJson(v));
      });
    }
  }
}

class DataJobAnalysisShow {
  int? id;
  String? subject;
  String? requiredSkills;
  int? requiredWorkExperience;
  String? requiredSoftSkills;
  String? requiredLanguages;
  Company? company;
  Results? results;


  DataJobAnalysisShow.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subject = json['subject'];
    requiredSkills = json['required_skills'];
    requiredWorkExperience = json['required_work_experience'];
    requiredSoftSkills = json['required_soft_skills'];
    requiredLanguages = json['required_languages'];
    company =
    json['company'] != null ? Company.fromJson(json['company']) : null;
    results =
    json['results'] != null ? Results.fromJson(json['results']) : null;
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
class Results {
  int? id;
  int? jobAnalyzeId;
  List<ResultsSingle>? resultsSingle;


  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobAnalyzeId = json['job_analyze_id'];
    if (json['results'] != null) {
      resultsSingle = <ResultsSingle>[];
      json['results'].forEach((v) {
        resultsSingle!.add(ResultsSingle.fromJson(v));
      });
    }
  }

}

class ResultsSingle {
  int? score;
  String? fileName;

  ResultsSingle.fromJson(Map<String, dynamic> json) {
    score = json['score'];
    fileName = json['file_name'];
  }
}
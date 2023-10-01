class CompanySingleJobModel {
  DataModelJob? data;
  String? message;

  CompanySingleJobModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? DataModelJob.fromJson(json['data']) : null;
    message = json['message'];
  }
}

class DataModelJob {
  int? id;
  String? subject;
  String? requiredSkills;
  int? requiredWorkExperience;
  String? requiredSoftSkills;
  String? requiredLanguages;
  String? expireTime;
  String? status;
  Company? company;
  List<JobApplicants>? jobApplicants;

  DataModelJob.fromJson(Map<String, dynamic> json) {
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
    if (json['job_applicants'] != null) {
      jobApplicants = <JobApplicants>[];
      json['job_applicants'].forEach((v) {
        jobApplicants!.add(JobApplicants.fromJson(v));
      });
    }
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

class JobApplicants {
  int? id;
  Employee? employee;
  int? score;


  JobApplicants.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employee = json['employee'] != null
        ? Employee.fromJson(json['employee'])
        : null;
    score = json['score'];
  }

}

class Employee {
  int? id;
  String? firstName;
  String? lastName;
  String? phone;
  String? address;
  String? birthdate;
  String? cv;


  Employee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    address = json['address'];
    birthdate = json['birthdate'];
    cv = json['cv'];
  }
}

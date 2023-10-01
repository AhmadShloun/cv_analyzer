// ignore_for_file: camel_case_types

import 'package:cv_analyzer/models/company/company_single_job.dart';
import 'package:cv_analyzer/models/Auth/logout_model.dart';
import 'package:cv_analyzer/models/company/create_update_model.dart';
import 'package:cv_analyzer/models/company/delete_model.dart';
import 'package:cv_analyzer/models/company/job_analyzsis_model.dart';
import 'package:cv_analyzer/models/company/show_single_job_analysis_model.dart';

abstract class CompanyStates{}

class CompanyInitialState extends CompanyStates{}
//---------LogOut--------
class LogoutLoadingState extends CompanyStates{}
class LogoutSuccessState extends CompanyStates{
  final LogoutModel logoutModel;
  LogoutSuccessState(this.logoutModel);
}
class LogoutErrorState extends CompanyStates{
  final LogoutModel logoutModel;

  LogoutErrorState(this.logoutModel);
}



//-------Job All Data-------
class CompanyLoadingAllJobDataState extends CompanyStates{}
class CompanySuccessAllJobDataState extends CompanyStates{}
class CompanyErrorAllJobDataState extends CompanyStates{}


//-------Job Single Data-------
class CompanyLoadingSingleJobDataState extends CompanyStates{}
class CompanySuccessSingleJobDataState extends CompanyStates{
  final CompanySingleJobModel companySingleJobModel;
  CompanySuccessSingleJobDataState(this.companySingleJobModel);
}
class CompanyErrorSingleJobDataState extends CompanyStates{}


//Create Job
class CreateLoadingState extends CompanyStates{}
class CreateSuccessState extends CompanyStates{
  final CreateUpdateModel createModel;
  CreateSuccessState(this.createModel);
}
class CreateErrorState extends CompanyStates{
  final CreateUpdateModel createModel;
  CreateErrorState(this.createModel);
}

//UpdateJobCompany
class UpdateLoadingState extends CompanyStates{}
class UpdateSuccessState extends CompanyStates{
  final CreateUpdateModel updateModel;
  UpdateSuccessState(this.updateModel);
}
class UpdateErrorState extends CompanyStates{
  final CreateUpdateModel updateModel;
  UpdateErrorState(this.updateModel);
}
//DeleteJobCompany
class DeleteLoadingState extends CompanyStates{}
class DeleteSuccessState extends CompanyStates{
  final DeleteModel deleteModel;
  DeleteSuccessState(this.deleteModel);
}
class DeleteErrorState extends CompanyStates{

  final DeleteModel deleteModel;
  DeleteErrorState(this.deleteModel);
}
//Create Job Analysis
class CreateJobAnalyzsisLoadingState extends CompanyStates{}
class CreateJobAnalyzsisSuccessState extends CompanyStates{
  final JobAnalyzesModel jobAnalyzesModel;
  CreateJobAnalyzsisSuccessState(this.jobAnalyzesModel);
}
class CreateJobAnalyzsisErrorState extends CompanyStates{
  final JobAnalyzesModel jobAnalyzesModel;
  CreateJobAnalyzsisErrorState(this.jobAnalyzesModel);
}
//Get JobAll Analysis
class CompanyLoadingAllJobAnalysisDataState extends CompanyStates{}
class CompanySuccessAllJobAnalysisDataState extends CompanyStates{}
class CompanyErrorAllJobAnalysisDataState extends CompanyStates{}

//Get Job Single Analysis
class CompanyLoadingSingleJobAnalysisDataState extends CompanyStates{}
class CompanySuccessSingleJobAnalysisDataState extends CompanyStates{
  final ShowSingleJobAnalyzesModel showSingleJobAnalyzesModel;
  CompanySuccessSingleJobAnalysisDataState(this.showSingleJobAnalyzesModel);
}
class CompanyErrorSingleJobAnalysisDataState extends CompanyStates{}

class onChangeSelcetState extends CompanyStates{}
class selcetFileArchive extends CompanyStates{}
// class clearCacheFile extends CompanyStates{}






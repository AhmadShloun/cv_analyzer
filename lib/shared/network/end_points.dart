//Dijango
// var baseURL = 'https://cvsanalyzer.pythonanywhere.com/api';
//Local Host192.168.1.34:5555
// ignore_for_file: non_constant_identifier_names

var baseURL = 'http://10.0.2.2:8000/api';
var baseToken = 'Bearer';

//------------Auth-----------
var LOGIN = Uri.parse('$baseURL/login/');

var REGISTER_COMPANY = Uri.parse('$baseURL/registration/company/');

var REGISTER_USER = Uri.parse('$baseURL/registration/employee/');

var LOGOUT = Uri.parse('$baseURL/logout/');
//------------------COMPANY-------------
var ALLJOBCOMPANY = Uri.parse('$baseURL/company/jobs');

// var SINGLEJOBCOMPANY = Uri.parse('$baseURL/company/jobs/${idSingleJob}');تم كتاباته ضمن التابع

var CREATEJOB = Uri.parse('$baseURL/company/jobs');
// var DELETEJOB = Uri.parse('$baseURL/company/jobs/$id');
//var UPDATEJOB = Uri.parse('$baseURL/company/jobs');//ضمن الكود
var CREATEJOBANALYZIES = Uri.parse('$baseURL/company/job-analyzies');

var ALLJOBANALYZIES=Uri.parse('$baseURL/company/job-analyzies');
//-----------------USER-------------
var UPDATEPROFILE = Uri.parse('$baseURL/employee/profile');
var ALLJOBUSER = Uri.parse('$baseURL/employee/jobs');
// var SINGLEJOBUSER = Uri.parse('$baseURL/employee/jobs/$id}');تم كتاباته ضمن التابع
var APPLYJOB = Uri.parse('$baseURL/employee/jobs/apply');
// var CANCELJOB =Uri.parse('$baseURL/employee/jobs/cancel-apply/${model.id}');


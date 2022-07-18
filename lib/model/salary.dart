import 'package:marsa_delivery/model/User.dart';

class Salary extends User{
  int? sumSalary ;
  String? netSalary ;
  String? deduction ;

  String?salaryDate;
  String? month ;
  String?year;

  Salary.details({this.sumSalary, this.netSalary, this.deduction, this.salaryDate, String? employeeDate,String? idNum,String? housingAllowance,String? transAllowance ,String?name }):super(employeeDate:employeeDate ,idNum:idNum ,housingAllowance:housingAllowance , transAllowance: transAllowance,name: name);

  Salary({this.netSalary, this.salaryDate, this.month, this.year});
  factory Salary.fromJson(Map<String  ,dynamic> json ){
    return Salary(

      netSalary: json["salary_safy"] ,
      salaryDate:   json["date"],
      month:   json["month"],
      year:   json["year"],


    );
  }

  factory Salary.fromJsonDetails(Map<String  ,dynamic> json ){
    return Salary.details(
        sumSalary:json["sum_all_salary"]  ,
      netSalary:json["salary_safy"]  ,
        idNum:json["id_num"]  ,
      deduction:json["entry_khasm"]  ,
        transAllowance:json["trans_allowance"]   ,
        housingAllowance: json["housing_allowance"]  ,
      employeeDate: json["date_employment"],name: json["employ_name"]


    );
  }
}
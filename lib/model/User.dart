
class User {
  String? userId  ;
  String?userName  ;
  String? name  ;
  String? userPassword  ;
  String? email  ;
  String? phone  ;
  String? lat;
  String? lng;
  String? createLocation;
  String? idNum;
  String? salary ;
  String?salaryDate;
  String? vacation;
  String? housingAllowance;
  String? transAllowance;
  String? passEndDate;
  String? insuranceCardEndDate;
  String? insuranceEndDate;
  String? employeeDate;
  String? employeeEndDate;
  String? testPeriod;
  String? employeeTarget;
  String? licenceEndDate;
  String? shipmentQty  ;
  bool?admin ;


  User({this.userId, this.userName, this.userPassword, this.name, this.phone , this.lng ,this.admin, this.lat , this.createLocation,this.employeeDate,this.employeeEndDate,this.email,this.salaryDate
 , this.employeeTarget ,this.housingAllowance ,this.idNum,this.insuranceCardEndDate,this.insuranceEndDate,this.passEndDate,this.salary,this.testPeriod,this.transAllowance,this.vacation,this.licenceEndDate ,this.shipmentQty});

  factory User.fromJson (Map<String  ,dynamic> json ,  String password , ){
    return
      User(

        userName: json["username"] ,
        phone:  "12346677" ,
        userId:  json["user_id"]  ,
        name:   json["name"] ,
        admin:   json["employ_type"]==1?true :false ,
        userPassword: password  ,

      );
  } factory User.fromJsonProfile (Map<String  ,dynamic> json  ){
    return
      User(

        name: json["name"] ,userId: json["user_id"],
        vacation: json["employ_vac"]  ,
        idNum:  json["id_num"]  ,
        salary:   json["employ_salary"] ,
        transAllowance: json["trans_allowance"]   ,
        housingAllowance: json["housing_allowance"] ,
        employeeDate:json["date_employment"]  ,
        employeeEndDate:json["work_end_date"]  ,
        employeeTarget: json["employ_target"] ,
        insuranceCardEndDate:json["date_insurance_end"]  ,
        insuranceEndDate:json["date_insurance_end2"]  ,
        passEndDate: json["date_pass_end"] ,
        testPeriod:json["fatra_tagreeb"]  ,
        licenceEndDate: json["date_license_end"]

      );
  }
  factory User.fromJsonShared (Map<String  ,dynamic> json ){
    return User(

        userName: json["userName"] ,
        phone:   json["phone"],
        userId:  json["userId"]  ,
        name:   json["name"] ,
        userPassword:  json["password"]  ,
      admin:  json["admin"]

    );
  }
  factory User.fromJsonSalary(Map<String  ,dynamic> json ){
    return User(

      salary: json["salary_safy"] ,
      salaryDate:   json["date"],


    );
  } factory User.fromJsonEmployee(Map<String  ,dynamic> json ){
    return User(

      name: json["name"] ,
      userId:   json["user_id"],


    );
  }
factory User.fromJsonReturn(Map<String  ,dynamic> json ){
    return User(

      name: json["driver_name"] ,
      shipmentQty:   json["amount"],
      userId:   json["delivery_id"],


    );
  }

  Map<String, dynamic> toJson( ) {
    return {
      "userId": userId,
      "userName":userName ,
      "password":userPassword ,
      "name":name ,
      "phone": phone,
      "admin":admin

    };
  }

  User.login( this.userName, this.userPassword );
  Map toMap() {
    var map = <String, dynamic>{};
    map["username"]  = userName ;
    map["password"]  = userPassword;
    return map;
  }

  Map addLocationToMap() {
    var map = <String, dynamic>{};
    map["lat"]  = lat ;
    map["lng"]  = lng;
    map["user_id"]  = userId;
    map["createdDate"]  = createLocation;
    return map;
  }

  @override
  String toString() => name!;

  static List<User>? fromJsonList(List list) {
    if (list == null) return null;
    return list.map((item) => User.fromJsonEmployee(item)).toList();
  }
}
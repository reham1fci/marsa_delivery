class Financial{
String? reason ;
String? money ;
String? date ;
String? id ;
String? status ;

Financial({this.reason, this.money, this.date, this.id, this.status});
factory Financial.fromJson(Map<String  ,dynamic> json ){
  return Financial(

      reason:   json["salf_req"],
      date: json["salf_date"],
      money: json["salf_cost"],
      status:json["stat"]

  );}




Map toMap(String driverId) {
  var map = <String, dynamic>{};
  map["employ_id"]  = driverId ;
  map["salf_req"]  = reason;
  map["salf_cost"]  = money;
  map["salf_date"]  = date;
  return map;
}
}
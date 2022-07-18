class Violation {
  String? name;
  String? carNm;
  String? vDate ;
  String? vDetails;
  String? vId;
  String? vCost ;

  Violation(
  {this.name, this.carNm, this.vDate, this.vDetails, this.vId, this.vCost});
  factory Violation.fromJson(Map<String  ,dynamic> json ){
    return Violation(

      name: json["name"] ,
      carNm:   json["car_name"],
      vCost: json["car_mokh_cost"],
      vDate:json["car_mokh_date"],
      vDetails:json["mokh_details"],
vId: json["car_mokh_id"]
    );
  }


}
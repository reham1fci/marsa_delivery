class Car  {
  String? carId  ;
  String? processNum  ;
  String? plateNum  ;
  String? carName  ;
  String? structNum  ;
  String? carModel ;
  String? carType ;
  String? carIcon ;

  Car({this.carId, this.processNum, this.plateNum, this.carName, this.structNum,
      this.carModel, this.carType, this.carIcon});

  factory Car.fromJson(Map<String  ,dynamic> json ){
    return Car(

     carIcon: json["car_icon"],
      carId: json["car_id"],
      processNum: json["car_cust_id"],
      plateNum: json["plate_number"],
      carModel: json["car_model"],
      carName: json["car_name"],
      structNum: json["struc_no"],
      carType: json["car_type"],
    );
  }
}
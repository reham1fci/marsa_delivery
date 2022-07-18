class TheChiefRequest {
String? orderNum  ;
String? id  ;
String? orderCost ;
String? deliverCost ;
String? totalCost;
String? date;

TheChiefRequest({this.orderNum, this.orderCost, this.deliverCost,this.id ,
      this.totalCost, this.date});
factory TheChiefRequest.fromJson(Map<String  ,dynamic> json ){
  return TheChiefRequest(

      orderNum:   json["order_number"],
      orderCost: json["order_cost"],
      deliverCost: json["delivery_cost"],
      totalCost:json["amount"],
      date:json["createdTime"],
    id: json["id"]

  );}
  //driver_id,order_number,amount,order_cost,delivery_cost
  Map toMap(String driverId) {
  var map = <String, dynamic>{};
  map["driver_id"]  = driverId ;
  map["order_number"]  = orderNum;
  map["order_cost"]  = orderCost;
  map["delivery_cost"]  = deliverCost;
  map["amount"]  = totalCost;
  return map;
  }

}
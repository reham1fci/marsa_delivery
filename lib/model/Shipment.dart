class Shipment{
  String? date ;
  String? productName;
  String? shipNum  ;
  String? qty ;
  String?disId  ;
   bool? isSelected   ;
   String?lat ;
   String? lng;
    String?customerNm ;
    String?customerMobile  ;
    String?customerID   ;
    double?distanceBetween;


  Shipment({this.date, this.productName, this.shipNum, this.qty ,this.disId ,
    this.isSelected , this.customerID , this.customerMobile , this.customerNm
  ,this.lat , this.lng});
  factory Shipment.fromJson (Map<String  ,dynamic> json ){
    return
      Shipment(
date: json["dis_date"]  , productName: json["product_name"]  , qty:   json["amount_input"] ,
          shipNum:  json["shipp_number"],disId: json["dis_id"]  ,isSelected:  false

      );
  }factory Shipment.fromJsonQ (Map<String  ,dynamic> json ){
    return
      Shipment(
date: json["dis_date"]  , productName: json["product_name"]  , qty:   json["total_amount"] ,


      );
  }
  factory Shipment.fromJsonDelivery (Map<String  ,dynamic> json ){
    return
      Shipment(
disId: json["dis_id"]  , productName: json["product_name"]  , qty:   json["total_amount"] ,
        lng:  json["lng"] , lat:  json["lat"] , customerID: json["customer_id"]  , customerMobile:json["customer_mobile"]   ,  customerNm:  json["customer_name"] ,


      );
  }
  Map<String, dynamic> deliveryDoneMap (String userId ,  String userLat ,String userLng){
    return {
      "customer_id" :customerID ,
      "user_id" :userId ,
      "lat" :lat ,
      "lng" :lng ,
      "d_lat" :userLat ,
      "d_lng" :userLng ,
    } ;
  }  Map<String, dynamic> deliveryNotDoneMap (String userId , String reason  , String userLat ,String userLng){
    return {
      "customer_id" :customerID ,
      "user_id" :userId ,
      "reason" : reason ,
      "lat":userLat ,
      "lng": userLng ,

    } ;
  }

  @override
  String toString() {
    return 'Shipment{date: $date, productName: $productName, shipNum: $shipNum, qty: $qty, disId: $disId, isSelected: $isSelected}';
  }

  Map<String, dynamic> toJson (){
    return {
      "dis_id" :disId ,
  } ;
  }
}
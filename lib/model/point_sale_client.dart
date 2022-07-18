class PointSaleClient {
  String? customerId ;
  String? customerNum ;
  String? lat ;
  String? lng ;
  String? phone ;
  String? customerName  ;
  String? createDate  ;
  String? imageLocation  ;

  PointSaleClient({this.customerNum, this.lat, this.lng,
      this.phone, this.customerName, this.createDate , this.customerId,this.imageLocation});

  Map toMap(String userID) {
    var map = <String, dynamic>{};
    map["userr_id"]  = userID ;
    map["cust_num"]  = customerNum;
    map["lat"]  = lat.toString();
    map["lng"]  = lng.toString();
    map["createdDate"]  = createDate;
    map["user_mobile"]  = phone;
    map["name"]  = customerName;
    return map;
  }


  factory PointSaleClient.fromJson (Map<String  ,dynamic> json){
    return
      PointSaleClient(
      lat:json["lat"] , lng:json["lng"]  ,
    phone: json["user_mobile"] , customerName:  json["name"] ,customerId: json["customer_id"]

      );
  } factory PointSaleClient.fromJsonDetails (Map<String  ,dynamic> json , String customerId ){
    return
      PointSaleClient(
      lat:json["lat"] , lng:json["lng"]  ,imageLocation: json["location_image"],
    phone: json["customer_mobile"] , customerName:  json["customer_name"] ,customerId: customerId

      );
  }
}
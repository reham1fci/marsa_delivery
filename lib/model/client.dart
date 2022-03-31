class Client {
  String? customerId ;
  String? customerNum ;
  String? lat ;
  String? lng ;

  Client({ this.customerId, this.customerNum, this.lat, this.lng});
  Map toMap(String userID) {
    var map = <String, dynamic>{};
    map["user_id"]  = userID ;
    map["cust_num"]  = customerNum;
    map["lat"]  = lat.toString();
    map["lng"]  = lng.toString();
    return map;
  }
}
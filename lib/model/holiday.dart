class Holiday{
  String? reason  ;
  String? id  ;
  String? from  ;
  String? to  ;
  String? type  ;
  String? typeName  ;
  String? status  ;
  String? holidayNum  ;
  String? statNum  ;

  Holiday({
      this.reason, this.from, this.to, this.type, this.typeName, this.status ,this.holidayNum , this.id ,this.statNum});

  factory Holiday.fromJson(Map<String  ,dynamic> json ){
    return Holiday(

        reason:   json["vac_res"],
        id:   json["vac_id"],
        from: json["date_from"],
        to: json["date_to"],
        status:json["vac_stat"],
        holidayNum:json["vac_num"],
statNum: json["stat_num"]

    );}




  Map toMap(String driverId) {
    var map = <String, dynamic>{};
    map["employ_id"]  = driverId ;
    map["vac_res"]  = reason;
    map["vac_type"]  = type;
    map["date_from"]  = from;
    map["date_to"]  = to;
    return map;
  }
}
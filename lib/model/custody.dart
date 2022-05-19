class Custody{
  String? receiver ;
  String? sender ;
  String? senderNm ;
  String? amount ;
  String?  details ;
  String? id ;
  String? date ;

  Custody({this.receiver, this.sender, this.amount, this.details, this.id , this.date ,this.senderNm});
  factory Custody.fromJson(Map<String  ,dynamic> json ){
    return Custody(

      //receiver: json["name"] ,
      sender:   json["sender"],
      senderNm: json["sender_name"],
      id: json["id"],
      amount:json["amount"],
      date:json["createdTime"],
      details:json["details"],

    );
  }
  Map custodyToMap(String receiverId) {
    var map = <String, dynamic>{};
    map["id"]  = id ;
    map["sender"]  = sender;
    map["receiver"]  = receiverId;
    map["amount"]  = amount;
    map["details"]  = details;
    return map;
  }
}
class Custody{
  String? receiver ;
  String? sender ;
  String? senderNm ;
  String? amount ;
  String?  details ;
  String? id ;
  String? date ;
  String? processNum ;
  String? credit  ;
  String? debit  ;
  String?state ;
  String?stateNum ;
  String?type ;

  Custody({this.receiver, this.type,this.sender, this.amount, this.details, this.id , this.date ,this.senderNm ,this.processNum,this.credit ,this.debit ,this.state,this.stateNum});
  factory Custody.fromJson(Map<String  ,dynamic> json ){
    return Custody(

      //receiver: json["name"] ,
      sender:   json["sender"],
      senderNm: json["sender_name"],
      id: json["id"],
      amount:json["amount"],
      date:json["createdTime"],
      details:json["details"],
      processNum:json["process_num"],
      state: json["type"]=="1"?"كاش":json["type"]=="2"?"بنك":"فاتورة" ,
      type: json["type"]

    );
  }

  factory Custody.fromJsonDetails(Map<String  ,dynamic> json ){
    return Custody(

      receiver: json["receiver_name"] ,
      senderNm: json["sender_name"],
      credit: json["daen"],
      debit:json["madeen"],
      date:json["createdDate"],
      details:json["details"],
      state:json["stat"],

    );
  }
  factory Custody.fromJsonRequests(Map<String  ,dynamic> json ){
    return Custody(

      id: json["process_num"] ,
      amount: json["amount"],
      details:json["details"],
      state:json["stat"] ?? "",
      stateNum:json["stat_num"],

    );
  }
  Map custodyToMap(String receiverId) {
    var map = <String, dynamic>{};
    map["id"]  = id ;
    map["sender"]  = sender;
    map["receiver"]  = receiverId;
    map["amount"]  = amount;
    map["details"]  = details;
    map["process_num"]  = processNum;
    map["type"]  = type;
    return map;
  }
}
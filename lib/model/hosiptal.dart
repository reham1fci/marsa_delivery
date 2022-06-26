class Hospital{
  String? hospitalNm  ;
  String? hospitalType  ;
  String? location  ;

  Hospital({this.hospitalNm, this.hospitalType, this.location});
  factory Hospital.fromJson(Map<String  ,dynamic> json ){
    return Hospital(

      //receiver: json["name"] ,
        hospitalNm:    json["sender"],
        hospitalType: json["sender_name"],
        location: json["id"],


    );
  }


}

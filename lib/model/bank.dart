class Bank  {
  String? bankNm  ;
  String? bankId  ;

  Bank({this.bankNm, this.bankId});
  factory Bank.fromJson(Map<String  ,dynamic> json ){
    return Bank(

      bankNm: json["bank_name"] ,
      bankId:   json["bank_id"],


    );
  }
}
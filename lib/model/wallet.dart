class Wallet{
  String? name ;
  String? debit ;
  String? credit ;
  String? details ;
  String? walletId ;

  String? balance
  ;
  String? date
  ;
  Wallet({this.name, this.debit, this.credit, this.balance,this.date,this.details ,this.walletId});
  factory Wallet.fromJson(Map<String  ,dynamic> json ){
    return Wallet(

      name: json["name"] ,
      balance:   json["raseed"].toString(),
      credit: json["daen"],
      debit:json["madeen"],
date:json["process_date"],
      details:json["details"],
      walletId:json["wallet_id"],

    );
  }
  factory Wallet.fromJsonCustody(Map<String  ,dynamic> json ){
    return Wallet(

      balance:   json["raseed"],
      credit:   json["daen"],
      debit:   json["madeen"],

    );
  }
}
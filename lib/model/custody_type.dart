class CustodyType{
  int? id ;
  bool? value ;
  String? title ;

  CustodyType({this.id, this.value, this.title});

  @override
  String toString() {
    return 'CustodyType{id: $id, value: $value, title: $title}';
  }
}
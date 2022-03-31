
class User {
  String? userId  ;
  String?userName  ;
  String? name  ;
  String? userPassword  ;
  String? email  ;
  String? phone  ;
  String? lat;
  String? lng;
  String? createLocation;


  User({this.userId, this.userName, this.userPassword, this.name, this.phone , this.lng , this.lat , this.createLocation});

  factory User.fromJson (Map<String  ,dynamic> json ,  String password , ){
    return
      User(

        userName: json["username"] ,
        phone:  "12346677" ,
        userId:  json["user_id"]  ,
        name:   json["name"] ,
        userPassword: password  ,

      );
  }
  factory User.fromJsonShared (Map<String  ,dynamic> json ){
    return User(

        userName: json["userName"] ,
        phone:   json["phone"],
        userId:  json["userId"]  ,
        name:   json["name"] ,
        userPassword:  json["password"]  ,

    );
  }
  Map<String, dynamic> toJson( ) {
    return {
      "userId": userId,
      "userName":userName ,
      "password":userPassword ,
      "name":name ,
      "phone": phone

    };
  }

  User.login( this.userName, this.userPassword );
  Map toMap() {
    var map = <String, dynamic>{};
    map["username"]  = userName ;
    map["password"]  = userPassword;
    return map;
  }

  Map addLocationToMap() {
    var map = <String, dynamic>{};
    map["lat"]  = lat ;
    map["lng"]  = lng;
    map["user_id"]  = userId;
    map["createdDate"]  = createLocation;
    return map;
  }

  @override
  String toString() {
    return 'User{userId: $userId, userName: $userName, userPassword: $userPassword, email: $email, phone: $phone}';
  }
}
class User1 {
  String user_id = "", user_name = "", user_type = "";

  User1({required this.user_id, required this.user_name, required this.user_type});

  toJson(){
    return {
      'user_id' : user_id,
      'user_name' : user_name,
      'user_type' : user_type,
    };

  }

  User1.fromJson(Map<dynamic, dynamic> json)
    : user_id = json["user_id"].toString(),
        user_name = json["user_name"].toString(),
        user_type = json["user_type"].toString();

}

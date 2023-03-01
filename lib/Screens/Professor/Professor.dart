
class Professor{
  String prof_id = "";
  String prof_name = "";
  String gender = "";
  String phone_no = "";
  String email = "";
  String qualification = "";

  Professor({required this.prof_id, required this.prof_name, required this.gender, required this.phone_no, required this.email,
    required this.qualification});
  Map<dynamic, dynamic> toJson() =>{
    "professor": {
      'email' : email,
      'gender' : gender,
      'phone_no' : phone_no,
      'prof_id' : prof_id,
      'prof_name' : prof_name,
      'qualification' : qualification,

    }

  };


  Professor.fromJson(Map<dynamic, dynamic> json)
    : prof_id  = json['prof_id'].toString(),
        prof_name = json['prof_name'].toString(),
        gender = json['gender'].toString(),
        email = json['email'].toString(),
        phone_no = json['phone_no'].toString(),
        qualification = json['qualification'].toString();

}
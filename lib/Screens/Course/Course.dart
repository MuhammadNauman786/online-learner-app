
class Course{
  String course_id = "";
  String? course_title = "";

  Course({required this.course_id, this.course_title});

  Map<dynamic, dynamic> toJson() =>{
    course_id:{
      'course_id': course_id,
      'course_title': course_title,
    }
  };

  Course.fromJson(Map<dynamic, dynamic> json)
    :  course_id = json['course_id'].toString(),
        course_title = json['course_title'].toString();

}



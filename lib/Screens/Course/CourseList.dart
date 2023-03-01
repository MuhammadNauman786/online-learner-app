
import 'package:online_learner/library_main.dart';

class CourseList extends StatefulWidget {
  const CourseList({Key? key}) : super(key: key);

  @override
  State<CourseList> createState() => _CourseListState();
}

class _CourseListState extends State<CourseList> {
  final List<int> colorCodes = <int>[0xFF878888, 0x8DFFFFFF];

  @override
  Widget build(BuildContext context) {
    return FirebaseAnimatedList(
      query: FirebaseDatabase.instance.ref().child("courses"),
      shrinkWrap: true,
      itemBuilder: (context, snapshot, animation, index) {
        final json = snapshot.value as Map<dynamic, dynamic>;
        final courses = Course.fromJson(json);
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: 100.0,
            width: 395.0,
            decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                      color: Colors.grey,
                      blurRadius: 7.0,
                      spreadRadius: 3.0,
                      offset: Offset(2, 4)),
                ],
                // color: const Color(0x25B3B0B0),
                gradient: const LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomRight,
                  colors: [Colors.black45, Colors.white70],
                ),
                borderRadius: BorderRadius.circular(15.0)),
            child: ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => HomeScreen(
                          pageId: 'CourseContent',
                          courses: courses,
                        )));
              },
              title: Text(
                courses.course_title.toString(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(courses.course_id),
              leading: const Icon(
                Icons.library_books_outlined,
                color: Colors.black,
                size: 90,
              ),
            ),
          ),
        );
      },
    );
  }
}

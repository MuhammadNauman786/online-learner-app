
import 'package:online_learner/library_main.dart';

class Courses extends StatefulWidget {
  const Courses({Key? key, UserCredential? user}) : super(key: key);

  @override
  _CoursesState createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        title: 'Course List',
      ),
      body: Center(
        child: CourseList(),
      ),
    );
  }
}


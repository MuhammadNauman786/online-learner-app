
import 'package:flutter_riverpod/all.dart';
import 'package:online_learner/library_main.dart';


class HomeScreen extends StatefulWidget {

  final String pageId;
  final courses;
  final notes;
  final Course? course2;
  final String? notesKey;
  final List<Video>? videos;

  const HomeScreen({Key? key, required this.pageId, this.courses, this.course2, this.notes, this.notesKey, this.videos}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  // }

  // Commented

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
                return const Center(child: CircularProgressIndicator(color: Colors.grey,),);
            }
            else if(snapshot.hasError){
                return const Center(child: Text("Some thing went Wrong!."),);
            }
            else if(snapshot.hasData && widget.pageId == "CourseSelection"){
              return const Courses();
            }
            else if(snapshot.hasData && widget.pageId == "CourseContent"){
              return CourseContent(courses: widget.courses,);
            }
            else if(snapshot.hasData && widget.pageId == "ProfessorDetails"){
              return ProfessorDetails(course: widget.course2,);
            }
            else if(snapshot.hasData && widget.pageId == "NoteDisplay"){
              return NoteDisplay(course: widget.course2, notesKey: widget.notesKey,);
            }
            else if(snapshot.hasData && widget.pageId == "NotesList"){
              return NotesList(course: widget.course2,);
            }
            else if(snapshot.hasData && widget.pageId == "AddNotes"){
              return AddNotes(course: widget.course2,);
            }
            else if(snapshot.hasData && widget.pageId == "EditNotes"){
              return EditNotes(course: widget.course2, notesKey: widget.notesKey,);
            }
            else if(snapshot.hasData && widget.pageId == "VideoSection"){
              return ProviderScope(child: VideoSection(course: widget.course2,),);
            }
            else if(snapshot.hasData && widget.pageId == "VideoScreen"){
              return ProviderScope(child: VideoScreen(videoList: widget.videos!,),);
            }
            else if(snapshot.hasData && widget.pageId == "ChatRoom"){
              return ChatRoom();
            }
            else{
              return const LoginScreen();
            }
        },
      ),
    );
  }
}


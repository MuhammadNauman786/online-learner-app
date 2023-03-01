import 'package:online_learner/library_main.dart';


ListTile GetTiles(Icon icon, String label, void fun()) {
  return ListTile(
    onTap: fun,
    leading: icon,
    title: Text(
      label,
      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
    ),
  );
}

Divider CustomDivider(){
  return const Divider(
    height: 10,
    thickness: 3,
    indent: 50,
    endIndent: 5,
    color: Colors.black26,
  );
}

class MyDrawer extends StatefulWidget {
  final Course? course;

  const MyDrawer({Key? key, required this.course}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  String userEmail = FirebaseAuth.instance.currentUser!.email.toString();
  String userName = "";
  String userType = "";

void _readUser(){
      FirebaseDatabase.instance.ref().child("users").child(FirebaseAuth.instance.currentUser!.uid).onValue.listen((event) {
        setState(() {
          final json  = event.snapshot.value as Map<dynamic, dynamic>;
          final user1 = User1.fromJson(json);
          userName = user1.user_name;
          userType = user1.user_type;
        });
        
    });
  }

  @override
  void initState() {
      _readUser();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.grey, Colors.white, Colors.black12],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              stops: [
                0.3,
                0.10,
                0.15,
              ],
              transform: GradientRotation(0.2)
          ),
        ),
        child: Center(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                currentAccountPicture: const CircleAvatar(
                  foregroundImage: AssetImage("assets/images/Profesor.png"),
                  backgroundColor: Colors.black12,
                ),
                accountName: Text(
                  userName.toString(),
                  style:
                      const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                ),
                accountEmail: Text(
                  userEmail,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.grey, Colors.white, Colors.black12],
                      begin: Alignment.center,
                      end: Alignment.topRight,
                      stops: [
                        0.3,
                        0.14,
                        0.18,
                      ],
                      transform: GradientRotation(0.16)
                  ),
                ),
              ),
              GetTiles(
                  const Icon(
                    Icons.library_books_outlined,
                    color: Colors.black,
                  ),
                  "Course Selection",
                  () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const HomeScreen(pageId: 'CourseSelection',)));
                  }),

              CustomDivider(),

              GetTiles(
                  const Icon(
                    Icons.account_box_outlined,
                    color: Colors.black,
                  ),
                  "Professor Details",
                  () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => HomeScreen(pageId: 'ProfessorDetails', course2: widget.course,)));
                  }),
              CustomDivider(),
              GetTiles(
                  const Icon(
                    Icons.wysiwyg_outlined,
                    color: Colors.black,
                  ),
                  "Notes Section",
                  () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => HomeScreen(pageId: 'NotesList', course2: widget.course,)));
                  }),
              CustomDivider(),
              GetTiles(
                  const Icon(
                    Icons.ondemand_video_outlined,
                    color: Colors.black,
                  ),
                  "Videos Lecture",
                  () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => HomeScreen(pageId: 'VideoSection', course2: widget.course,)));
                  }),
              CustomDivider(),
              GetTiles(
                  const Icon(
                    Icons.messenger,
                    color: Colors.black,
                  ),
                  "Discussion Board",
                  () {}),
              CustomDivider(),
              GetTiles(
                  const Icon(
                    Icons.library_books,
                    color: Colors.black,
                  ),
                  "Helping Material",
                      (){}),
              CustomDivider(),
            ],
          ),
        ),
      ),
    );
  }
}

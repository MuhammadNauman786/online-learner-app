import 'package:online_learner/library_main.dart';

class NoteDisplay extends StatefulWidget {
  final Course? course;
  final String? notesKey;

  const NoteDisplay({Key? key, this.course, this.notesKey,}) : super(key: key);

  @override
  State<NoteDisplay> createState() => _NoteDisplayState();
}

class _NoteDisplayState extends State<NoteDisplay> {
  final DatabaseReference databaseReference = FirebaseDatabase.instance.ref().child("notes");
  String noteText = "";
  String noteTitle = "";

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _loadNotes() async {
    String userId = FirebaseAuth.instance.currentUser!.email
        .toString()
        .substring(
        0,
        FirebaseAuth.instance.currentUser!.email
            .toString()
            .indexOf("@"));

    databaseReference
        .child(userId)
        .child(widget.course!.course_id)
        .child(widget.notesKey.toString())
        .onValue
        .listen((event) {
      if(mounted){
        setState(() {
          final json = event.snapshot.value as Map<dynamic, dynamic>;
          final not = Notes.fromJson(json);

          noteTitle = not.notesTitle.toString();
          noteText = not.notesText.toString();
        });

       }


    });
  }


  @override
  void initState() {
    super.initState();
    _loadNotes();

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.grey,
        ),
        centerTitle: true,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Notes",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => HomeScreen(
                        pageId: 'EditNotes',
                        course2: widget.course,
                        notesKey: widget.notesKey,
                      )));
            },
            child: const Text(
              "Edit",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: Container(
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
              transform: GradientRotation(0.2)),
        ),
        child: ListView(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("${noteTitle.toString()}:",
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 22.0)),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Container(
                          height: 500.0,
                          width: 395.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black12),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(noteText.toString(),
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 16.0)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}

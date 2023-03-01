import 'package:online_learner/library_main.dart';

class EditNotes extends StatefulWidget {
  final Course? course;
  final String? notesKey;

  const EditNotes({Key? key, this.course, this.notesKey,}) : super(key: key);

  @override
  _EditNotesState createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> {
  final DatabaseReference databaseReference = FirebaseDatabase.instance.ref().child("notes");
  final titleController = TextEditingController();
  final textBodyController = TextEditingController();
  bool cancelVisibility = false;
  bool counter = true;
  String courseId = "";
  String? key = "";
  String userId = "";


  @override
  void dispose() {
    titleController.dispose();
    textBodyController.dispose();
    super.dispose();
  }

  Future<void> _getKey() async {

    userId = FirebaseAuth.instance.currentUser!.email
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
        .onValue.listen((event) {
     if(mounted){
       setState(() {
         final json = event.snapshot.value as Map<dynamic, dynamic>;
         final not = Notes.fromJson(json);
         titleController.text = not.notesTitle;
         textBodyController.text = not.notesText;
       });
     }
    });

  }


  @override
  void initState() {
    super.initState();
    _getKey();
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
          "Edit Notes",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          TextButton(
            onPressed: () {


                databaseReference.child(userId).child(widget.course!.course_id).child(widget.notesKey.toString()).update({
                  'notesText': textBodyController.text.toString(),
                  'notesTitle': titleController.text.toString(),
                });
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text("Notes Saved")));
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => HomeScreen(pageId: 'NotesList', course2: widget.course,)));
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
            },
            child: const Text(
              "Save",
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
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Container(
                          height: 60.0,
                          width: 395.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black12),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: TextField(
                              enabled: false,
                              textInputAction: TextInputAction.next,
                              controller: titleController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Container(
                          height: 450.0,
                          width: 395.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black12),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: TextField(
                              maxLines: 20,
                              textInputAction: TextInputAction.next,
                              controller: textBodyController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
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

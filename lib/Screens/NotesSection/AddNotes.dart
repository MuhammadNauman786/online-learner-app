import 'package:online_learner/library_main.dart';

class AddNotes extends StatefulWidget {
  final Course? course;

  const AddNotes({Key? key, this.course}) : super(key: key);

  @override
  _AddNotesState createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final textBodyController = TextEditingController();
  bool cancelVisibility = false;

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
          "Add Notes",
          style: const TextStyle(color: Colors.black),
        ),
        actions: [
          TextButton(
            onPressed: () {
              String userId = FirebaseAuth.instance.currentUser!.email
                  .toString()
                  .substring(
                      0,
                      FirebaseAuth.instance.currentUser!.email
                          .toString()
                          .indexOf("@"));
              Notes notes = Notes(
                  notesText: textBodyController.text,
                  notesTitle: titleController.text);
              try {
                if (formKey.currentState!.validate()) {
                  FirebaseDatabase.instance
                      .ref()
                      .child("notes")
                      .child(userId)
                      .child(widget.course!.course_id)
                      .push()
                      .set(notes.toJson());
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Successfully Added")));
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => HomeScreen(
                            pageId: 'NotesList',
                            course2: widget.course,
                          )));
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                }

                titleController.clear();
                textBodyController.clear();
              } on FirebaseAuthException catch (e) {
                print(e);
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Could not Added")));
              }
            },
            child: const Text(
              "Add",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: Form(
        key: formKey,
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
                              child: TextFormField(
                                onChanged: (value){
                                 setState(() {
                                   if (value.isEmpty) {
                                     cancelVisibility = false;
                                   } else {
                                     cancelVisibility = true;
                                   }
                                 });
                                },
                                textInputAction: TextInputAction.next,
                                controller: titleController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Required Field";
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Enter title here..',
                                  suffixIcon: GestureDetector(
                                    child: Visibility(
                                      child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            titleController.clear();
                                          });
                                        },
                                        icon: const Icon(Icons.cancel, color: Colors.grey,),
                                      ),
                                      visible: cancelVisibility,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
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
                                  hintText: 'Start writing from here..',
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
      ),
    );
  }
}

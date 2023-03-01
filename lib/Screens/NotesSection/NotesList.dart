import 'package:online_learner/library_main.dart';

class NotesList extends StatefulWidget {
  final Course? course;

  const NotesList({Key? key, required this.course}) : super(key: key);

  @override
  _NotesListState createState() => _NotesListState();
}

class _NotesListState extends State<NotesList> {
  String userId = FirebaseAuth.instance.currentUser!.email.toString().substring(
      0, FirebaseAuth.instance.currentUser!.email.toString().indexOf("@"));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Noted Notes",
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FirebaseAnimatedList(
            shrinkWrap: true,
            query: FirebaseDatabase.instance
                .ref()
                .child("notes")
                .child(userId)
                .child(widget.course!.course_id),
            itemBuilder: (context, snapshot, animation, index) {
              final json = snapshot.value as Map<dynamic, dynamic>;
              final notes = Notes.fromJson(json);
              return Dismissible(
                onDismissed: (_) {
                  String key = snapshot.key.toString();
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        // return object of type Dialog
                        return AlertDialog(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          title: const Text(
                            "Remove this Notes",
                            style: TextStyle(fontSize: 20),
                          ),
                          content: Text(notes.notesTitle,
                              style: const TextStyle(fontSize: 16)),
                          actions: <Widget>[
                            // usually buttons at the bottom of the dialog
                            TextButton(
                              child: const Text("No"),
                              onPressed: () {
                                setState(() {
                                  Navigator.of(context).pop();
                                });
                              },
                            ),
                            TextButton(
                              child: const Text("Yes"),
                              onPressed: () {
                                setState(() {
                                  FirebaseDatabase.instance
                                      .ref()
                                      .child("notes")
                                      .child(userId)
                                      .child(widget.course!.course_id)
                                      .child(key)
                                      .remove();
                                  Navigator.of(context).pop();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text(" Notes successfully deleted")));
                                });
                              },
                            ),
                          ],
                        );
                      });
                },
                background: Container(
                  color: Colors.red,
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  alignment: Alignment.centerRight,
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
                key: UniqueKey(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: index.isOdd ? Colors.white : Colors.black12,
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.grey,
                                blurRadius: 7.0,
                                spreadRadius: 3.0,
                                offset: Offset(3, 6)),
                          ],
                          // border: Border.all(color: Colors.black, style: BorderStyle.solid),
                        ),
                        child: ListTile(
                          style: ListTileStyle.list,
                          onTap: () {
                            setState(() {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      HomeScreen(
                                        pageId: 'NoteDisplay',
                                        course2: widget.course,
                                        notesKey: snapshot.key,
                                      )));
                            });
                          },
                          leading: const Icon(
                            Icons.notes,
                            color: Colors.black,
                            size: 50.0,
                          ),
                          title: Text(
                            notes.notesTitle.toString(),
                          ),
                          subtitle: Text(
                            notes.notesText.toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  HomeScreen(
                    pageId: "AddNotes",
                    course2: widget.course,
                  )));
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.black,
      ),
    );
  }
}

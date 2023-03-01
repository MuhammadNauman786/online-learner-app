
import 'package:online_learner/library_main.dart';

DecoratedBox GetButton(Icon icon, String title, void fun()) {
  final ButtonStyle ContentButtonStyle = ElevatedButton.styleFrom(
    primary: Colors.transparent,
    fixedSize: const Size(150.0, 150.0),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(110.0)),
  );

  return DecoratedBox(
    decoration: const BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.black,
          blurStyle: BlurStyle.outer,
          blurRadius: 7.0,
          spreadRadius: 3.0,
        ),
      ],
      gradient: LinearGradient(colors: [Colors.white, Colors.grey],

      ),
      shape: BoxShape.circle,
    ),
    child: ElevatedButton(
      style: ContentButtonStyle,
      onPressed: fun,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: const TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
        ],
      ),
    ),
  );
}

class Content extends StatefulWidget {
  final Course? courses1;

  const Content({Key? key, required this.courses1}) : super(key: key);

  @override
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 160.0,
            width: 400.0,
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                    color: Colors.grey,
                    blurRadius: 7.0,
                    spreadRadius: 5.0,
                    offset: Offset(3, 6)),
              ],
              border: Border.all(color: Colors.black, style: BorderStyle.solid),
              // color: Color(0x25B3B0B0),
              gradient: const LinearGradient(
                colors: [Colors.grey, Colors.white],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                stops: [
                  0.3,
                  0.9,
                ],
                transform: GradientRotation(5.0)
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0),
                bottomLeft: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Course Code: ${widget.courses1!.course_id}",
                        style: const TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const Icon(
                  Icons.menu_book_outlined,
                  color: Colors.black,
                  size: 70,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.courses1!.course_title.toString(),
                    style: const TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20.0),
        SizedBox(
          width: 400.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GetButton(
                          const Icon(
                            Icons.account_box_outlined,
                            color: Colors.black,
                            size: 50.0,
                          ),
                          "Professor Details",
                          () {
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => HomeScreen(pageId: 'ProfessorDetails', course2: widget.courses1,)));
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GetButton(
                          const Icon(
                            Icons.wysiwyg_outlined,
                            color: Colors.black,
                            size: 50.0,
                          ),
                          "Notes Section",
                          () {
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => HomeScreen(pageId: 'NotesList', course2: widget.courses1,)));
                          }),
                    ),
                  ],
                ),
              ),

              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GetButton(
                          const Icon(
                            Icons.ondemand_video_outlined,
                            color: Colors.black,
                            size: 50.0,
                          ),
                          "Videos Lecture",
                          () {
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => HomeScreen(pageId: 'VideoSection', course2: widget.courses1,)));
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GetButton(
                          const Icon(
                            Icons.messenger,
                            color: Colors.black,
                            size: 50.0,
                          ),
                          "Discussion Board",
                          () {
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => HomeScreen(pageId: 'ChatRoom',)));
                          }),
                    ),
                  ],
                ),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GetButton(
                          const Icon(
                            Icons.library_books,
                            color: Colors.black,
                            size: 50.0,
                          ),
                          "Helping Material",
                          () {}),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

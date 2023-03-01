import 'package:flutter/services.dart';
import 'package:online_learner/Screens/ScrollToHideWidget.dart';
import 'package:online_learner/library_main.dart';

class CourseContent extends StatefulWidget {
  final courses;


  const CourseContent({Key? key, required this.courses}) : super(key: key);

  @override
  State<CourseContent> createState() => _CourseContentState();
}

class _CourseContentState extends State<CourseContent> {
  late ScrollController controller;

  @override
  void initState() {
    super.initState();
    controller = ScrollController();
  }


  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool _pinned = false;
    bool _snap = true;
    bool _floating = true;
    return Scaffold(
      drawer: MyDrawer(
        course: widget.courses,
      ),
      drawerEnableOpenDragGesture: true,
      endDrawerEnableOpenDragGesture: true,
      body: CustomScrollView(
        controller: controller,
        slivers: [
          SliverAppBar(
            pinned: _pinned,
            snap: _snap,
            floating: _floating,
            backgroundColor: Colors.grey,
            systemOverlayStyle:
                const SystemUiOverlayStyle(statusBarColor: Colors.grey),
            centerTitle: true,
            elevation: 0.0,
            iconTheme: const IconThemeData(color: Colors.black),
            title: const Text(
              "Course Content",
              style: TextStyle(color: Colors.black),
            ),
            actions: <Widget>[
              IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        // return object of type Dialog
                        return AlertDialog(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          title: const Text(
                            "Logout",
                            style: TextStyle(fontSize: 20),
                          ),
                          content: const Text("Are you sure?",
                              style: TextStyle(fontSize: 18)),
                          actions: <Widget>[
                            // usually buttons at the bottom of the dialog
                            TextButton(
                              child: const Text("No"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: const Text("Yes"),
                              onPressed: () {
                                FirebaseAuth.instance.signOut();
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      });
                },
                icon: const Icon(
                  Icons.logout,
                ),
                tooltip: 'Logout',
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Content(courses1: widget.courses),
          ),
        ],
      ),
      bottomNavigationBar: ScrollToHideWidget(
        controller: controller,
        child: BottomNavigationBar(
          elevation: 0.0,
          backgroundColor: Colors.grey,
          selectedItemColor: Colors.black,
          onTap: (i)=>(
          Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen(pageId: 'CourseSelection',)))
          ),
          selectedIconTheme: const IconThemeData(color: Colors.black,),
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.circle,),
                activeIcon: Icon(Icons.circle,),
                label: "Courses"),
          ],
        ),
      ),
    );
  }
}

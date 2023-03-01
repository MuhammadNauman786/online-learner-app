import 'package:online_learner/library_main.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({Key? key, required this.title}) : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(55);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.grey,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.grey,),
      centerTitle: true,
      elevation: 0.0,
      iconTheme: const IconThemeData(color: Colors.black),
      title: Text(
        widget.title,
        style: const TextStyle(color: Colors.black),
      ),
      actions: <Widget>[
        IconButton(
          onPressed: logOut,
          icon: const Icon(
            Icons.logout,
          ),
          tooltip: 'Logout',
        ),
      ],
    );
  }

  Future logOut() async {
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
  }
}

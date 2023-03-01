import 'package:online_learner/library_main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool userErrorVisibility = false;
  bool passErrorVisibility = false;
  bool eyeVisibility = false;
  bool cancelVisibility = false;
  bool passHideOrShow = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: ListView(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.white70,
                        ),
                        padding: const EdgeInsets.all(2.0),
                        height: 100.0,
                        child: Image.asset(
                          "assets/images/icon.png",
                          fit: BoxFit.contain,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text("Login Here"),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Container(
                          height: 55.0,
                          width: 350.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black12),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: TextFormField(
                              onChanged: (value) {
                                setState(() {
                                  if (value.isEmpty) {
                                    cancelVisibility = false;
                                  } else {
                                    cancelVisibility = true;
                                  }
                                });
                              },
                              textInputAction: TextInputAction.next,
                              controller: emailController,
                              validator: (value) {
                                setState(() {
                                  if (value == null || value.isEmpty) {
                                    userErrorVisibility = true;
                                  } else {
                                    userErrorVisibility = false;
                                  }
                                });
                                return null;
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: 'User Id',
                                hintText: 'Enter User Id',
                                suffixIcon: GestureDetector(
                                  child: Visibility(
                                    child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          emailController.clear();
                                        });
                                      },
                                      icon: const Icon(Icons.cancel, color: Colors.grey,),
                                    ),
                                    visible: cancelVisibility,
                                  ),
                                ),
                                prefixIcon: const Icon(Icons.account_circle_outlined),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: SizedBox(
                          height: 20,
                          width: 395.0,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 40.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Visibility(
                                  child: const Text(
                                    "Please enter user Id!",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  visible: userErrorVisibility,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Container(
                          height: 55.0,
                          width: 350.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black12),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: TextFormField(
                              onChanged: (value){
                                setState(() {
                                  if (value.isEmpty) {
                                    eyeVisibility = false;
                                  } else {
                                    eyeVisibility = true;
                                  }
                                });
                              },
                              textInputAction: TextInputAction.done,
                              controller: passwordController,
                              validator: (value) {
                                setState(() {
                                  if (value == null || value.isEmpty) {
                                    passErrorVisibility = true;
                                  } else {
                                    passErrorVisibility = false;
                                  }
                                });

                                return null;
                              },
                              obscureText: passHideOrShow,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Password',
                                hintText: 'Enter Password',
                                suffixIcon: GestureDetector(
                                  child: Visibility(
                                    child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          passHideOrShow = !passHideOrShow;
                                        });
                                      },
                                      icon: Icon(passHideOrShow? Icons.visibility_off_outlined :
                                        Icons.visibility_outlined,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    visible: eyeVisibility,
                                  ),
                                ),
                                prefixIcon: const Icon(Icons.key),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: SizedBox(
                          height: 18,
                          width: 395.0,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 40.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Visibility(
                                  child: const Text(
                                    "Please enter password!",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  visible: userErrorVisibility,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: SizedBox(
                          width: 395.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      barrierDismissible: true,
                                      builder: (context) => const Center(
                                            child: CircularProgressIndicator(
                                              color: Colors.grey,
                                            ),
                                          ));

                                  try {
                                    setState(() {
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ForgotPassword()),
                                          (route) => false);
                                    });
                                  } catch (e) {
                                    print(e);
                                  }
                                },
                                child: const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 25.0),
                                  child: Text(
                                    "Forgot Password!",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: loginMethod,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          shadowColor: Colors.grey,
                          primary: Colors.black,
                          fixedSize: const Size(350.0, 50.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.lock_open_outlined,
                              color: Colors.white,
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future loginMethod() async {
    try {
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) => const Center(
                child: CircularProgressIndicator(
                  color: Colors.grey,
                ),
              ));

      if (formKey.currentState!.validate()) {
        UserCredential user = (await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text,
                password: passwordController.text));

        if (user.user != null) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => const HomeScreen(
                        pageId: 'CourseSelection',
                      )),
              (route) => false);

          emailController.clear();
          passwordController.clear();
        }
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(
          context: context,
          builder: (context) => const Center(
                  child: AlertDialog(
                title: Text("Please Enter correct User Id or Password!"),
              )));
    }
  }
}

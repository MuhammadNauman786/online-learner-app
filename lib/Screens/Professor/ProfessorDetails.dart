import 'package:online_learner/library_main.dart';

Text getHeadingText(String string) {
  return Text(string.toString(), style: const TextStyle(
      color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14.0),);
}

Text getText(String string) {
  return Text(string.toString(), style: const TextStyle(
      color: Colors.black, fontSize: 14.0),);
}

class ProfessorDetails extends StatefulWidget {
  final Course? course;

  const ProfessorDetails({Key? key, this.course}) : super(key: key);

  @override
  State<ProfessorDetails> createState() => _ProfessorDetailsState();
}

class _ProfessorDetailsState extends State<ProfessorDetails> {

  String id = "";
  String name = "";
  String gender = "";
  String email = "";
  String phone = "";
  String qualification = "";
  final DatabaseReference reference = FirebaseDatabase.instance.ref();

void _readData(){

   reference.child("courses").child(widget.course!.course_id).child("professor").onValue.listen((event) {

    setState(() {
      final json = event.snapshot.value as Map<dynamic, dynamic>;
      final professor = Professor.fromJson(json);
      id = professor.prof_id;
      name = professor.prof_name;
      email = professor.email;
      gender = professor.gender;
      phone = professor.phone_no;
      qualification = professor.qualification;

    });
   });

  }


  @override
  void initState() {
    _readData();

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(
        title: 'Professor Details',
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
              transform: GradientRotation(0.2)
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                        height: 150.0,
                        width: 200.0,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.black, style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(30.0),
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
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.account_circle_outlined, color: Colors.black,
                            size: 150.0,),
                        )
                    ),
                  ),

                  SizedBox(height: 20.0,),


                  Container(
                    width: 400.0,
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.grey,
                            blurRadius: 7.0,
                            spreadRadius: 5.0,
                            offset: Offset(3, 6)),
                      ],
                      border: Border.all(
                          color: Colors.black, style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(30.0),
                      gradient: const LinearGradient(
                          colors: [Colors.white, Colors.grey],

                      ),
                    ),
                    child: Center(
                      child: DataTable(
                        columns: [
                          DataColumn(label: getText("")),
                          DataColumn(label: getText("")),
                        ],
                        // border: TableBorder.all(color: Colors.black,
                        //     style: BorderStyle.solid,
                        //     width: 2.0),
                        rows: [
                          DataRow(cells: [
                            DataCell(getHeadingText("Id:")),

                            DataCell(getText(id)),

                          ]),
                          DataRow(cells: [
                            DataCell(getHeadingText("Name:")),

                            DataCell(getText(name)),

                          ]),
                          DataRow(cells: [
                            DataCell(getHeadingText("Gender:")),

                            DataCell(getText(gender)),

                          ]),
                          DataRow(cells: [
                            DataCell(getHeadingText("Email:")),

                            DataCell(getText(email)),

                          ]),
                           DataRow(cells: [
                            DataCell(getHeadingText("Phone No:")),

                            DataCell(getText(phone)),

                          ]),
                          DataRow(cells: [
                            DataCell(getHeadingText("Qualification:")),

                            DataCell(getText(qualification)),

                          ]),

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
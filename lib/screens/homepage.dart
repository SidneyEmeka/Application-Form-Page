import 'package:form_page/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class aForm {
  int? id;
  //String dob;
  String name;
  String day;
  String course;
  //String time;
  String essay;
  String state;

  aForm(
      {this.id,
      //required this.dob,
      required this.name,
      required this.day,
      required this.course,
      //required this.time,
      required this.essay,
      required this.state});

  Map<String, dynamic> toMap() {
    return {
      "user_id": id,
      // "user_dob": dob,
      "user_name": name,
      "user_day": day,
      "user_course": course,
      // "user_time": time,
      "user_essay": essay,
      "user_state": state,
    };
  }
}

////DATABASE
String dbTableName = "formDB";
String thePathis = "";

Future<String> getDBPATH() async {
  thePathis = await getDatabasesPath();
  String path = join(thePathis, dbTableName);
  return path;
}

class DbProvider {
  Database? db;
  String mySQLcl =
      'CREATE TABLE $dbTableName(user_id integer PRIMARY KEY AUTOINCREMENT,user_name TEXT,user_dob TEXT,user_day TEXT,user_course TEXT,user_time TEXT,user_essay TEXT,user_state TEXT)';

  Future open(String path) async {
    db = await openDatabase(path, version: 2,
        onCreate: (Database db, int version) async {
      await db.execute(mySQLcl);
    });
  }

  Future<aForm> insert(aForm aUserForm) async {
    aUserForm.id = await db?.insert(dbTableName, aUserForm.toMap());
    return aUserForm;
  }
}

class _HomeState extends State<Home> {
  String dob = "";
  String time = "";
  final nameController = TextEditingController();
  final dobController = TextEditingController();
  final courseController = TextEditingController();
  final timeController = TextEditingController();
  final dayController = TextEditingController();
  final stateController = TextEditingController();
  final essayController = TextEditingController();

  Future<void> openAppDatabase() async {
    await DbProvider().open(await getDBPATH());
  }

  void register() async {
    final userInput = aForm(
        id: 0,
        //  dob: dobController.text,
        name: nameController.text,
        day: dayController.text,
        course: courseController.text,
        // time: timeController.text,
        essay: dayController.text,
        state: stateController.text);
    final received = await DbProvider().insert(userInput);
    if (received.id != 0) {
      print('registered successfully');
    }
  }

  @override
  void initState() {
    openAppDatabase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: ListView(
          children: [
            const SizedBox(
              height: 15,
            ),
            const HeaderWidget(),
            const SizedBox(
              height: 100,
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Registration",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                    flex: 3,
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: "Enter Your Name",
                      ),
                      controller: nameController,
                    )),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                    flex: 1,
                    child: TextField(
                      keyboardType: TextInputType.datetime,
                      decoration: const InputDecoration(
                        hintText: "DOB",
                      ),
                      onTap: () => showDatePicker(
                              context: context,
                              firstDate: DateTime(2017),
                              lastDate: DateTime.now())
                          .then(
                        (date) => setState(() => dobController.text =
                            date.toString().split(" ").first),
                      ),
                      controller: dobController,
                    )),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              decoration: const InputDecoration(
                hintText: "Course",
              ),
              controller: courseController,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.datetime,
                    decoration: const InputDecoration(hintText: "Time"),
                    onTap: () async => await showTimePicker(
                            context: context, initialTime: TimeOfDay.now())
                        .then((selectedTime) => setState(() {
                              final time =
                                  '${selectedTime!.hour.toString()}: ${selectedTime.minute.toString()}';

                              timeController.text = time;
                            })),
                    controller: timeController,
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  flex: 3,
                  child: TextField(
                    decoration: const InputDecoration(
                        hintText: "What Days are You Available"),
                    controller: dayController,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              decoration: const InputDecoration(
                hintText: "State of Origin",
              ),
              controller: stateController,
            ),
            const SizedBox(
              height: 50,
            ),
            TextField(
              controller: essayController,
              decoration: const InputDecoration(
                hintText:
                    "In not more than 500 words, Briefly explain why you should be selected",
              ),
              minLines: 3,
              maxLines: 4,
              maxLength: 500,
              keyboardType: TextInputType.multiline,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
              ),
              child: GestureDetector(
                child: ElevatedButton(
                  onPressed: () {
                    final name = nameController.text;
                    final dob = dobController.text;
                    final course = courseController.text;
                    final time = timeController.text;
                    final day = dayController.text;
                    final state = stateController.text;
                    final essay = essayController.text;
                    register();
                    print(
                        "Name : $name\n,Course : $course\n,Day : $day\n,State of Origin : $state\n,Essay : $essay");
                  },
                  child: const Text("Register"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

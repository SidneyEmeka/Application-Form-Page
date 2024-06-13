import 'package:form_page/widgets/header.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
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

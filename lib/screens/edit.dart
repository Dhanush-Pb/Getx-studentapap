import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getex_tudu/controler/home_contorler.dart';
import 'package:getex_tudu/model/_dbstudent.dart';
import 'package:getex_tudu/screens/Homepage.dart';

class Editpage extends StatelessWidget {
  Student student;
  final homecontroler controler = Get.find<homecontroler>();

  Editpage({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    TextEditingController namecontroler =
        TextEditingController(text: student.name);
    TextEditingController agecontroler =
        TextEditingController(text: student.age);
    TextEditingController placecontroler =
        TextEditingController(text: student.place);
    TextEditingController phonenumberconrtroler =
        TextEditingController(text: student.phone);
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit details'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
        child: Column(
          children: [
            TextField(
              controller: namecontroler,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(
              height: 12,
            ),
            TextField(
              controller: agecontroler,
              decoration: InputDecoration(labelText: 'Age'),
            ),
            SizedBox(
              height: 12,
            ),
            TextField(
              controller: phonenumberconrtroler,
              decoration: InputDecoration(labelText: 'phone'),
            ),
            SizedBox(
              height: 12,
            ),
            TextField(
              controller: placecontroler,
              decoration: InputDecoration(labelText: 'Place'),
            ),
            SizedBox(
              height: 25,
            ),
            ElevatedButton(
                onPressed: () {
                  controler.updatestudent(
                      student,
                      namecontroler.text,
                      agecontroler.text,
                      phonenumberconrtroler.text,
                      placecontroler.text);
                  Get.snackbar('Success', '${student.name} details updated');
                  Get.to(() => Homepage());
                },
                child: Text('save'))
          ],
        ),
      ),
    );
  }
}

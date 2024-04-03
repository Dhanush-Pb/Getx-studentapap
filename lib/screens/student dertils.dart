import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getex_tudu/model/_dbstudent.dart';
import 'package:getex_tudu/screens/edit.dart';

class detailsscreen extends StatelessWidget {
  final Student student;
  const detailsscreen({
    super.key,
    required this.student,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 25),
                child: CircleAvatar(
                  backgroundColor: Colors.green,
                  child: IconButton(
                      onPressed: () {
                        Get.to(() => Editpage(student: student));
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: Color.fromARGB(255, 255, 255, 255),
                      )),
                ),
              )
            ],
            centerTitle: true,
            title: Text(
              'Details of   ${student.name}',
              style: TextStyle(fontSize: 15),
            )),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            CircleAvatar(
                radius: 100, backgroundImage: FileImage(File(student.image))),
            const SizedBox(
              height: 50,
            ),
            widget('Name', String, student.name),
            const SizedBox(
              height: 20,
            ),
            widget('Age', String, student.age),
            const SizedBox(
              height: 20,
            ),
            widget('Phone', String, student.phone),
            const SizedBox(
              height: 20,
            ),
            widget('Place', String, student.place),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 60,
                ),
              ],
            )
          ],
        ));
  }

  widget(String name, String, data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 120),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Center(
            child: Text(
              name,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ),
          Row(
            children: [
              Text(
                data,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
              ),
            ],
          )
        ],
      ),
    );
  }
}

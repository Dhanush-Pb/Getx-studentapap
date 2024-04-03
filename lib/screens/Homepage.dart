import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:getex_tudu/controler/home_contorler.dart';
import 'package:getex_tudu/model/_dbstudent.dart';

import 'package:getex_tudu/screens/add.dart';
import 'package:getex_tudu/screens/student%20dertils.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final homecontroler controller = Get.put(homecontroler());

  @override
  void initState() {
    controller.loadStudents();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Get.bottomSheet(
                    Container(
                      child: Wrap(
                        children: [
                          ListTile(
                              leading: const Icon(Icons.light_mode_outlined),
                              title: const Text('Light theme'),
                              onTap: () => {
                                    Get.changeTheme(ThemeData.light()),
                                    Get.back(),
                                  }),
                          ListTile(
                              leading: const Icon(Icons.light_mode),
                              title: const Text('Dark theme'),
                              onTap: () => {
                                    Get.changeTheme(ThemeData.dark()),
                                    Get.back(),
                                  }),
                        ],
                      ),
                    ),
                    backgroundColor: Colors.blue);
              },
              icon: const Icon(
                Icons.light,
                size: 35,
              ))
        ],
        centerTitle: true,
        title: const Text('students'),
      ),
      body: Center(
        child: Obx(() {
          if (controller.student.isEmpty) {
            return const Text('No data');
          } else {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: controller.student.length,
              itemBuilder: (context, index) {
                print(controller.student[index].image);
                // Return a widget to display student details
                return GestureDetector(
                  onTap: () {
                    Get.to(() =>
                        detailsscreen(student: controller.students[index]));
                  },
                  child: Card(
                    color: const Color.fromARGB(255, 160, 160, 160),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: CircleAvatar(
                              radius: 55,
                              backgroundImage: FileImage(
                                  File(controller.student[index].image))),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Display other details
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    controller.student[index].name,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  CircleAvatar(
                                    backgroundColor: Colors.red,
                                    child: IconButton(
                                        onPressed: () {
                                          _delete(controller.student[index]);
                                        },
                                        icon: const Icon(Icons.delete)),
                                  )
                                ],
                              ),

                              // Add more details as needed
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => addstudent());
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _delete(Student student) {
    Get.defaultDialog(
        title: 'conformation of deletion',
        middleText: 'Are you sure want to delete',
        textConfirm: 'Delete',
        confirmTextColor: Colors.white,
        onConfirm: () {
          controller.delete(student);

          Get.to(() => Homepage());
        },
        onCancel: () {});
  }
}

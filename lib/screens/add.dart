import 'dart:io'; // Add this import for using File class

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getex_tudu/model/_dbstudent.dart';

import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

// ignore: camel_case_types
// ignore: camel_case_types
class addstudentformgetcontroler extends GetxController {
  Rx<File?> selectedimage = Rx<File?>(null);
}

// ignore: must_be_immutable, camel_case_types
class addstudent extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController namecontroler = TextEditingController();
  TextEditingController clascontroler = TextEditingController();
  TextEditingController agecontroler = TextEditingController();
  TextEditingController ponenumber = TextEditingController();

  addstudentformgetcontroler controler = Get.put(
    addstudentformgetcontroler(),
  );

  addstudent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add student'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Obx(() {
                return Column(
                  children: [
                    Center(
                      child: GestureDetector(
                        onTap: () => _pickImage(controler),
                        child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                            child: controler.selectedimage.value != null
                                ? ClipOval(
                                    child: Image.file(
                                      controler.selectedimage.value!,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : const Icon(
                                    Icons.add_photo_alternate,
                                    size: 60,
                                    color: Colors.white,
                                  )),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    custmtestfield(
                        controller: namecontroler,
                        keybordtype: TextInputType.name,
                        labeltext: 'Name',
                        // ignore: avoid_types_as_parameter_names
                        validator: (Value) {
                          if (Value == null || Value.isEmpty) {
                            return 'plese enter name';
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    custmtestfield(
                        controller: agecontroler,
                        keybordtype: TextInputType.number,
                        labeltext: 'Age',
                        validator: (Value) {
                          if (Value == null || Value.isEmpty) {
                            return 'plese enter  Age';
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    custmtestfield(
                        controller: ponenumber,
                        keybordtype: TextInputType.phone,
                        labeltext: 'Phone number',
                        validator: (Value) {
                          if (Value == null || Value.isEmpty) {
                            return 'plese enter number';
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    custmtestfield(
                        controller: clascontroler,
                        keybordtype: TextInputType.name,
                        labeltext: 'Place',
                        // ignore: avoid_types_as_parameter_names
                        validator: (Value) {
                          if (Value == null || Value.isEmpty) {
                            return 'plese enter place';
                          }
                          return null;
                        }),
                  ],
                );
              }),
              ElevatedButton(
                  onPressed: () {
                    if (controler.selectedimage.value == null) {
                      Get.snackbar('Error', 'Pleace add a image',
                          backgroundColor:
                              const Color.fromARGB(255, 255, 17, 0),
                          colorText: Colors.white,
                          snackPosition: SnackPosition.BOTTOM);
                    } else {
                      if (_formKey.currentState!.validate()) {
                        Student student = Student();
                        student.name = namecontroler.text;
                        student.age = agecontroler.text;
                        student.phone = ponenumber.text;
                        student.place = clascontroler.text;
                        student.image = controler.selectedimage.value!.path;
                        // Save the student details
                        savestuden(student);
                        Get.back();
                      }
                    }
                  },
                  child: const Text('Save'))
            ],
          ),
        ),
      ),
    );
  }
}

void savestuden(Student student) async {
  final box = Hive.box<Student>('students');
  await box.add(student);
  print('${student.name}added ');
  Get.snackbar('Sucess', '${student.name}  details added');
}

void _pickImage(addstudentformgetcontroler controller) async {
  final pickedImage =
      await ImagePicker().pickImage(source: ImageSource.gallery);
  if (pickedImage != null) {
    controller.selectedimage.value = File(pickedImage.path);
  }
}

// ignore: camel_case_types
class custmtestfield extends StatelessWidget {
  final TextEditingController controller;
  final String labeltext;
  final TextInputType keybordtype;
  final FormFieldValidator<String>? validator;
  const custmtestfield(
      {super.key,
      required this.controller,
      required this.keybordtype,
      required this.labeltext,
      required this.validator});

  @override
  Widget build(BuildContext context) {
    AppBar(
      title: const Text('addstudent'),
    );
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey,
        ),
        child: TextFormField(
          keyboardType: keybordtype,
          validator: validator,
          controller: controller,
          decoration: InputDecoration(
              // ignore: prefer_const_constructors
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              labelText: labeltext,
              labelStyle: TextStyle(color: Colors.black)),
        ),
      ),
    );
  }
}

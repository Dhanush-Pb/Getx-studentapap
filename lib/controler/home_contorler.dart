import 'package:get/get.dart';
import 'package:getex_tudu/model/_dbstudent.dart';
import 'package:hive/hive.dart';

class homecontroler extends GetxController {
  // Define a RxList to hold the list of students
  RxList<Student> students = <Student>[].obs;

  // Getter to access the list of students
  List<Student> get student => students.toList();

  final studentbox = Hive.box<Student>('students');
  // Method to load students from Hive box
  Future<void> loadStudents() async {
    final box = await Hive.openBox<Student>('students');
    students.assignAll(box.values.toList());
    box.watch().listen((event) {
      students.assignAll(box.values.toList());
    });
  }

  void delete(Student student) {
    studentbox.delete(student.key);
    students.remove(student);
  }

  void updatestudent(
      Student student, String name, String age, String phone, String place) {
    final index = students.indexWhere((element) => element.key == student.key);
    students[index].name = name;
    students[index].phone = phone;
    students[index].age = age;
    students[index].place = place;
    studentbox.put(students[index].key, students[index]);
  }
}
  // Other methods or logic related to managing students can be added here


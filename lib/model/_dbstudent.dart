import 'package:hive/hive.dart';
part '_dbstudent.g.dart';

@HiveType(typeId: 0)
class Student extends HiveObject {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late String age;

  @HiveField(2)
  late String phone;

  @HiveField(3)
  late String image = '';

  @HiveField(4)
  late String place;
}

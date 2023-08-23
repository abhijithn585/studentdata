import 'package:hive/hive.dart';
part 'data_model.g.dart';

@HiveType(typeId: 1)
class StudentModel {
  @HiveField(0)
  final int? id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String age;

  @HiveField(3)
  final String number;

  @HiveField(4)
  final String address;

  @HiveField(5)
  final String? image;

  StudentModel(
      {required this.name,
      required this.age,
      required this.number,
      required this.address,
      this.id,
      this.image});
}

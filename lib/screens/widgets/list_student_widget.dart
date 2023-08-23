import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/db/functions/db_functions.dart';
import 'package:flutter_application_1/screens/widgets/add_student_widgets.dart';
import 'package:flutter_application_1/screens/widgets/edit_student_list.dart';
import '../../db/model/data_model.dart';

class ListStudentWidget extends StatefulWidget {
  const ListStudentWidget({super.key});

  @override
  State<ListStudentWidget> createState() => _ListStudentWidgetState();
}

class _ListStudentWidgetState extends State<ListStudentWidget> {
  @override
  Widget build(BuildContext context) {
    getAllStudents();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AddStudentWidget(),
              ));
            },
            icon: Icon(Icons.arrow_back)),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
      ),
      body: ValueListenableBuilder(
        valueListenable: studentListNotifier,
        builder:
            (BuildContext ctx, List<StudentModel> studentList, Widget? child) {
          return ListView.separated(
              itemBuilder: (ctx, index) {
                final data = studentList[index];
                return ListTile(
                  title: Text(data.name),
                  subtitle: Text(data.age),
                  leading: CircleAvatar(
                      backgroundImage: data.image != null
                          ? FileImage(File(data.image!))
                          : AssetImage('assets/images/profile.png')
                              as ImageProvider),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () {
                            deleteStudent(index);
                          },
                          icon: const Icon(Icons.delete)),
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => EditStudentList(
                                  index: index,
                                  name: data.name,
                                  age: data.age,
                                  number: data.number,
                                  address: data.address,
                                  imagePath: data.image,
                                ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.edit))
                    ],
                  ),
                );
              },
              separatorBuilder: (ctx, index) {
                return const Divider();
              },
              itemCount: studentList.length);
        },
      ),
    );
  }
}

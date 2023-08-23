import 'package:flutter/material.dart';
import 'dart:io';
import 'add_student_widgets.dart';
import 'list_student_widget.dart';
import 'package:flutter_application_1/db/functions/db_functions.dart';
import 'package:flutter_application_1/db/model/data_model.dart';
import '../widgets/edit_student_list.dart';
import 'package:image_picker/image_picker.dart';

class EditStudentList extends StatefulWidget {
  var name;
  var age;
  var number;
  var address;
  int index;

  dynamic imagePath;

  EditStudentList({
    required this.index,
    required this.name,
    required this.age,
    required this.number,
    required this.address,
    required this.imagePath,
  });

  @override
  State<EditStudentList> createState() => _EditStudentListState();
}

class _EditStudentListState extends State<EditStudentList> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _numberController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name);
    _ageController = TextEditingController(text: widget.age);
    _numberController = TextEditingController(text: widget.number);
    _addressController = TextEditingController(text: widget.address);
    _selectedImage = widget.imagePath != '' ? File(widget.imagePath) : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
      ),
      body: Container(
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                  height: 10,
                ),
                CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.grey,
                  backgroundImage: _selectedImage != null
                      ? FileImage(_selectedImage!)
                      : AssetImage("assets/images/profile-transformed.png")
                          as ImageProvider,
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () => {_pickImageFromGallery()},
                    child: Text("Pick Gallery")),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                    onPressed: () => {_pickImageFromcam()},
                    child: Text("Pick Camera")),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(), hintText: 'Name'),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: _ageController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Age',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: _numberController,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(), hintText: 'Number'),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: _addressController,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Address'),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            updateAll();
                          },
                          child: Text('Update')),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> updateAll() async {
    final name1 = _nameController.text.trim();
    final age1 = _ageController.text.trim();
    final number1 = _numberController.text.trim();
    final address1 = _addressController.text.trim();
    final image1 = _selectedImage!.path;

    if (name1.isEmpty ||
        age1.isEmpty ||
        number1.isEmpty ||
        address1.isEmpty ||
        image1.isEmpty) {
      return;
    } else {
      final update = StudentModel(
          name: name1,
          age: age1,
          number: number1,
          address: address1,
          image: image1);
      editStudent(widget.index, update);
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const ListStudentWidget()));
    }
  }

  Future _pickImageFromGallery() async {
    final returnedimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnedimage == null) {
      return;
    }
    setState(() {
      _selectedImage = File(returnedimage.path);
    });
  }

  _pickImageFromcam() async {
    final returnedimage =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (returnedimage == null) {
      return;
    }
    setState(() {
      _selectedImage = File(returnedimage.path);
    });
  }
}

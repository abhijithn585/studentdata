import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/db/functions/db_functions.dart';
import 'package:flutter_application_1/db/model/data_model.dart';
import 'package:flutter_application_1/screens/widgets/list_student_widget.dart';
import 'package:image_picker/image_picker.dart';

class AddStudentWidget extends StatefulWidget {
  AddStudentWidget({super.key});

  @override
  State<AddStudentWidget> createState() => _AddStudentWidgetState();
}

class _AddStudentWidgetState extends State<AddStudentWidget> {
  final _nameController = TextEditingController();

  final _ageController = TextEditingController();

  final _numberController = TextEditingController();

  final _addressController = TextEditingController();

  File? _selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Value is Empty';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _ageController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Age'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Value is Empty';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _numberController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Number'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Value is Empty';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _addressController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Address'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Value is Empty';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton.icon(
                  onPressed: () {
                    onAddStudentButtonClicked();
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add Student')),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ListStudentWidget(),
                    ));
                  },
                  child: const Text("View List"))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onAddStudentButtonClicked() async {
    final _name = _nameController.text.trim();
    final _age = _ageController.text.trim();
    final _number = _numberController.text.trim();
    final _address = _addressController.text.trim();
    if (_name.isEmpty || _age.isEmpty || _number.isEmpty || _address.isEmpty) {
      return;
    }
    print('$_name $_age $_number $_address');

    final _student = StudentModel(
        name: _name,
        age: _age,
        number: _number,
        address: _address,
        image: _selectedImage!.path);

    addStudent(_student);
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

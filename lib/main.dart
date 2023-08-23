import 'package:flutter/material.dart';
import 'package:flutter_application_1/db/model/data_model.dart';
import 'package:flutter_application_1/screens/screen_home.dart';
import 'package:flutter_application_1/screens/widgets/add_student_widgets.dart';
import 'package:flutter_application_1/screens/widgets/list_student_widget.dart';
import 'package:hive_flutter/adapters.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(StudentModelAdapter().typeId)) {
    Hive.registerAdapter(StudentModelAdapter());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: ListStudentWidget(),
      debugShowCheckedModeBanner: false,
    );
  }
}

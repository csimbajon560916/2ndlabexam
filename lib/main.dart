import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:labexam_2/firebase_options.dart';
import 'package:labexam_2/task_model.dart';



import 'firebase_options.dart';

import 'task_screen.dart';



void main() async {

 WidgetsFlutterBinding.ensureInitialized();



 await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);



 runApp(MyApp());

}



class MyApp extends StatelessWidget {

 @override

 Widget build(BuildContext context) {

  return MaterialApp(

   debugShowCheckedModeBanner: false,

   title: 'labexam2_magallon',

   home: TaskListScreen(),

  );

 }

}


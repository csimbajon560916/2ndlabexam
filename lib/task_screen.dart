import 'package:flutter/material.dart';



import 'task_model.dart';

import 'firestore_service.dart';



class TaskListScreen extends StatefulWidget {

 @override

 _TaskListScreenState createState() => _TaskListScreenState();

}



class _TaskListScreenState extends State<TaskListScreen> {

 TextEditingController textController = TextEditingController();

 TextEditingController editController = TextEditingController();



 FirestoreService firestoreService = FirestoreService();



 void addTask() {

  if (textController.text.isEmpty) {

   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('')));

   return;

  }



  firestoreService.addTask(textController.text);

  textController.clear();

 }



 void editTaskDialog(Task task) {

  editController.text = task.name;



  showDialog(

   context: context,

   builder: (context) {

    return AlertDialog(

     title: Text('Edit Task'),

     content: TextField(controller: editController),

     actions: [

      ElevatedButton(

       onPressed: () {

        if (editController.text.isEmpty) {

         return;

        }

        firestoreService.updateTask(task.id, editController.text);

        Navigator.pop(context);

       },

       child: Text('Update'),

      ),

     ],

    );

   },

  );

 }



 @override

 Widget build(BuildContext context) {

  return Scaffold(

   appBar: AppBar(

    title: Text('Labexam2 Simbajon'),

    actions: [IconButton(icon: Icon(Icons.more_vert), onPressed: () {})],

   ),

   body: Padding(

    padding: EdgeInsets.all(10.0),

    child: Column(

     children: [

      Row(

       children: [

        Expanded(

         child: TextField(

          controller: textController,

          decoration: InputDecoration(

           hintText: 'Add a new task...',

           border: OutlineInputBorder(),

          ),

         ),

        ),

        SizedBox(width: 10),

        ElevatedButton(onPressed: addTask, child: Icon(Icons.add)),

       ],

      ),

      SizedBox(height: 20),



      Expanded(

       child: StreamBuilder<List<Task>>(

        stream: firestoreService.getTasks(),

        builder: (context, snapshot) {

         if (snapshot.hasError) {

          return Text('Error: ${snapshot.error}');

         }



         if (snapshot.connectionState == ConnectionState.waiting) {

          return Center(child: CircularProgressIndicator());

         }



         List<Task> tasks = snapshot.data ?? [];



         if (tasks.isEmpty) {

          return Center(child: Text('No tasks available.'));

         }



         return ListView.builder(

          itemCount: tasks.length,

          itemBuilder: (context, index) {

           Task task = tasks[index];



           return Card(

            child: ListTile(

             title: Text(task.name),

             trailing: Row(

              mainAxisSize: MainAxisSize.min,

              children: [

               IconButton(

                icon: Icon(Icons.edit, color: Colors.grey),

                onPressed: () {

                 editTaskDialog(task);

                },

               ),

               IconButton(

                icon: Icon(Icons.delete, color: Colors.red),

                onPressed: () {

                 firestoreService.deleteTask(task.id);

                },

               ),

              ],

             ),

            ),

           );

          },

         );

        },

       ),

      ),

     ],

    ),

   ),

  );

 }

}
import 'package:cloud_firestore/cloud_firestore.dart';



import 'task_model.dart';



class FirestoreService {

 CollectionReference tasksCollection = FirebaseFirestore.instance.collection(

  'tasks',

 );



 Future<void> addTask(String name) async {

  await tasksCollection.add({'name': name, 'createdAt': DateTime.now()});

 }



 Stream<List<Task>> getTasks() {

  return tasksCollection

    .orderBy('createdAt', descending: true)

    .snapshots()

    .map((snapshot) {

     return snapshot.docs.map((doc) {

      return Task.fromFirestore(doc);

     }).toList();

    });

 }



 Future<void> updateTask(String id, String newName) async {

  await tasksCollection.doc(id).update({'name': newName});

 }



 Future<void> deleteTask(String id) async {

  await tasksCollection.doc(id).delete();

 }

}
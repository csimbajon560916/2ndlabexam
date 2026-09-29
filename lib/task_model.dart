import 'package:cloud_firestore/cloud_firestore.dart';



class Task {

 String id;

 String name;

 DateTime? createdAt;



 Task({required this.id, required this.name, this.createdAt});



 factory Task.fromFirestore(DocumentSnapshot doc) {

  Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

  return Task(

   id: doc.id,

   name: data['name'] ?? '',

   createdAt: data['createdAt'] != null

     ? (data['createdAt'] as Timestamp).toDate()

     : null,

  );

 }

}


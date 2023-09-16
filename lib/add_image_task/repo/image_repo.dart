import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class ImageTaskRepo {
  final _auth = FirebaseAuth.instance;
  final CollectionReference _imageTaskRef =
      FirebaseFirestore.instance.collection('ImageTasks');
  Future<void> createImageTask(String taskName, String taskDetails,
      String taskDuration, List<XFile> imageList) async {
    final uuid = Uuid();
    final taskId = uuid.v4();
    List<String>? image = [];

    try {
      for (final element in imageList) {
        final ref = FirebaseStorage.instance
            .ref()
            .child('taskImages')
            .child(element.name);

        final file = File(element.path);
        await ref.putFile(file);
        final taskImage = await ref.getDownloadURL();
        image.add(taskImage);
      }

      await _imageTaskRef.doc(taskId).set({
        'task name': taskName,
        'task details': taskDetails,
        'task duration': taskDuration,
        'image': image,
        'userid': _auth.currentUser!.uid,
      });
    } catch (e) {
      throw Exception('Failed To Add Task');
    }
  }
}

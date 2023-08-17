import 'package:flutter/material.dart';
import 'package:todo/add_image_task/repo/image_repo.dart';
import 'package:image_picker/image_picker.dart';

class AddImageTask extends StatelessWidget {
  AddImageTask({super.key});
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _taskNameController = TextEditingController();
  final TextEditingController _taskDetailsController = TextEditingController();
  final TextEditingController _taskDurationController = TextEditingController();

  List<XFile>? imageList;
  Future<dynamic> getImage() async {
    final imagePicker = ImagePicker();
    imageList = await imagePicker.pickMultiImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Image'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _taskNameController,
                decoration: InputDecoration(hintText: 'Task Name'),
              ),
              TextFormField(
                controller: _taskDetailsController,
                decoration: InputDecoration(hintText: 'Task Details'),
              ),
              TextFormField(
                controller: _taskDurationController,
                decoration: InputDecoration(hintText: 'Task Duration'),
              ),
              TextButton(
                onPressed: () {
                  getImage();
                },
                child: Text('Upload Image'),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await ImageTaskRepo().createImageTask(
                        _taskNameController.text,
                        _taskDetailsController.text,
                        _taskDurationController.text,
                        imageList!);
                    _taskNameController.clear();
                    _taskDetailsController.clear();
                    _taskDurationController.clear();
                  }
                },
                child: Text('Add Image Task'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

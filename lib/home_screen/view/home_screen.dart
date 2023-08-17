import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/add_image_task/view/add_image_task.dart';
import 'package:todo/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _taskNameController = TextEditingController();
  final TextEditingController _taskDetailsController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  late CollectionReference _todoRef;
  @override
  void initState() {
    super.initState();
    _todoRef = _firestore.collection('TaskCollection');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddImageTask(),
                ));
          },
          icon: Icon(Icons.image),
        )
      ]),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 100),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Welcome to TodoApp",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              UtilityWidget().heightSpace(40),
              TextFormField(
                controller: _taskNameController,
                decoration: InputDecoration(hintText: 'Task Name'),
              ),
              UtilityWidget().heightSpace(20),
              TextFormField(
                controller: _taskDetailsController,
                decoration: InputDecoration(hintText: 'Task Details'),
              ),
              UtilityWidget().heightSpace(40),
              ElevatedButton(
                onPressed: () async {
                  await _todoRef.add({
                    'task name': _taskNameController.text,
                    'task details': _taskDetailsController.text,
                    'userid': _auth.currentUser!.uid,
                  });
                  _taskNameController.clear();
                  _taskDetailsController.clear();
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Task Added Succesfully')));
                },
                child: Text(
                  "Add Task",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: _todoRef
                      .where('userid', isEqualTo: _auth.currentUser!.uid)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }
                    final List<DocumentSnapshot> documents =
                        snapshot.data!.docs;
                    return ListView.builder(
                      itemCount: documents.length,
                      itemBuilder: (BuildContext context, int index) {
                        final singleDoc = documents[index];
                        return ListTile(
                            title: Text(singleDoc['task name'] as String),
                            subtitle: Text(singleDoc['task details'] as String),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          final doc = documents[index];
                                          _taskNameController.text =
                                              doc['task name'] as String;
                                          _taskDetailsController.text =
                                              doc['task details'] as String;
                                          return AlertDialog(
                                            title: Text('Edit Task'),
                                            content: Column(
                                              children: [
                                                TextField(
                                                    controller:
                                                        _taskNameController,
                                                    decoration: InputDecoration(
                                                        hintText:
                                                            'Task Name: ')),
                                                TextField(
                                                  controller:
                                                      _taskDetailsController,
                                                  decoration: InputDecoration(
                                                      hintText: 'Task Details'),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    ElevatedButton(
                                                        onPressed: () {
                                                          _firestore
                                                              .collection(
                                                                  'TaskCollection')
                                                              .doc(singleDoc.id)
                                                              .update({
                                                            'task name':
                                                                _taskNameController
                                                                    .text,
                                                            'task detials':
                                                                _taskDetailsController
                                                                    .text
                                                          });
                                                          _taskNameController
                                                              .clear();
                                                          _taskDetailsController
                                                              .clear();
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text('Save')),
                                                    ElevatedButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text('Cancel'))
                                                  ],
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.blueAccent,
                                    )),
                                IconButton(
                                    onPressed: () async {
                                      final todo = _todoRef.doc(singleDoc.id);
                                      await todo.delete();
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.redAccent,
                                    )),
                              ],
                            ));
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

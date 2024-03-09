import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:equipohealth/utils/helper.dart';

class UsersPage extends StatelessWidget {
  final String? todoId;
  const UsersPage({super.key, required this.todoId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Todo users"),
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection("rapidusers").snapshots(),
            builder: (context, snapshot) =>
                snapshot.hasData && snapshot.data!.docs.isNotEmpty
                    ? ListView(
                        children: snapshot.data!.docs.map((document) {
                          Map<String, dynamic> data =
                              document.data() as Map<String, dynamic>;
                          return ListTile(
                            trailing: TextButton(
                              child: const Text("Share"),
                              onPressed: () async {
                                DocumentSnapshot<Map<String, dynamic>>
                                    todoSnapshot = await FirebaseFirestore
                                        .instance
                                        .collection('rapidtodo')
                                        .doc(todoId)
                                        .get();
                                List shared = todoSnapshot.data()!['shared'];
                                if (!shared.contains(document['uid'])) {
                                  shared.add(document['uid']);

                                  await FirebaseFirestore.instance
                                      .collection('rapidtodo')
                                      .doc(todoId)
                                      .update({"shared": shared}).then(
                                          (value) => Helper.showLog(
                                              "todo shared successfully"));
                                } else {
                                  Helper.showLog("already shared");
                                }
                              },
                            ),
                            title: Text(data['email']),
                          );
                        }).toList(),
                      )
                    : const Center(child: Text("No users found"))));
  }
}

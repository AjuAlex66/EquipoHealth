import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:equipohealth/offlinenotes/home/loginscreen.dart';
import 'package:equipohealth/offlinenotes/home/userspage.dart';
import 'package:equipohealth/offlinenotes/notes/addnotepage.dart';
import 'package:equipohealth/utils/helper.dart';
import 'package:equipohealth/utils/initializer.dart';
import 'package:equipohealth/utils/localstorage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AppOpenAd? myAppOpenAd;
  @override
  void initState() {
    // loadAppOpenAd();
    // context.read<MainBloc>().add(GetRecentNotes());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      // initialIndex: 1,
      child: Scaffold(
          drawer: Drawer(
            child: Column(
              children: [
                const DrawerHeader(
                    child: Center(
                  child: CircleAvatar(
                    radius: 46,
                    child: Text(
                      "R",
                      style: TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                )),
                Helper.allowHeight(20),
                ListTile(
                    leading: const Icon(
                      Icons.login_outlined,
                      color: Colors.black,
                    ),
                    title: const Text(
                      "Sign out",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    onTap: () async => await LocalStorage.clearAll().then(
                          (value) => Helper.pushReplacement(
                              const LoginScreen(), 'login'),
                        ))
              ],
            ),
          ),
          extendBodyBehindAppBar: false,
          floatingActionButton: FloatingActionButton(
            onPressed: () => Helper.push(const AddNotePage(), 'addnote'),
            child: const Icon(Icons.add),
          ),
          // BlocBuilder<MainBloc, MainState>(
          //   buildWhen: (previous, current) =>
          //       current is RecentNotesNotFound || current is RecentNotesFetched,
          //   builder: (context, state) =>
          //   state is RecentNotesFetched
          //       ? FloatingActionButton(
          //           onPressed: () =>
          //               Helper.push( const AddNotePage(), 'addnote'),
          //           child: const Icon(Icons.add),
          //         )
          //       : Helper.shrink(),
          // ),
          appBar: AppBar(
            actions: [const CircleAvatar(), Helper.allowWidth(10)],
            title: const Text("RapidTodo"),
            elevation: 1.0,
            bottom: const TabBar(
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white70,
              labelStyle: TextStyle(fontWeight: FontWeight.w700),
              indicatorColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.tab,
              unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
              isScrollable: false,
              tabs: [
                Tab(
                  text: "My Todos",
                ),
                Tab(
                  text: "Shared with me",
                )
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              MyTodo(),
              ShredTodo(),
            ],
          )
          // BlocConsumer<MainBloc, MainState>(
          //   listenWhen: (previous, current) => current is NoteDeleted,
          //   listener: (context, state) {
          //     // if(state is)
          //   },
          //   buildWhen: (previous, current) =>
          //       current is RecentNotesNotFound || current is RecentNotesFetched,
          //   builder: (context, state) {
          //     if (state is RecentNotesNotFound) {
          //       return Center(
          //         child: GestureDetector(
          //           onTap: () =>
          //               Helper.push( const AddNotePage(), 'addnote'),
          //           child: Column(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             crossAxisAlignment: CrossAxisAlignment.center,
          //             mainAxisSize: MainAxisSize.min,
          //             children: [
          //               Icon(Icons.add_circle_rounded,
          //                   size: 55, color: Colors.grey[400]),
          //               Helper.allowHeight(15),
          //               const Text(
          //                 'Tap here to create your first todo',
          //                 textAlign: TextAlign.center,
          //                 style: TextStyle(
          //                   fontSize: 16,
          //                   fontWeight: FontWeight.w500,
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //       );
          //     } else if (state is RecentNotesFetched) {
          //       return SingleChildScrollView(
          //         padding: const EdgeInsets.all(14.0),
          //         child: Column(
          //           mainAxisAlignment: MainAxisAlignment.start,
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           mainAxisSize: MainAxisSize.max,
          //           children: List.generate(
          //               state.notesData!.length,
          //               (index) => InkWell(
          //                     onTap: () => Helper.push(
          //                         context,
          //                         NoteViewPage(
          //                           noteData: state.notesData![index],
          //                         ),
          //                         'noteview'),
          //                     child: Column(
          //                       children: [
          //                         Row(
          //                           mainAxisAlignment:
          //                               MainAxisAlignment.spaceBetween,
          //                           crossAxisAlignment: CrossAxisAlignment.center,
          //                           mainAxisSize: MainAxisSize.max,
          //                           children: [
          //                             Flexible(
          //                               child: Column(
          //                                 mainAxisAlignment:
          //                                     MainAxisAlignment.start,
          //                                 crossAxisAlignment:
          //                                     CrossAxisAlignment.start,
          //                                 mainAxisSize: MainAxisSize.min,
          //                                 children: [
          //                                   Text(
          //                                     state.notesData![index].noteTitle!,
          //                                     maxLines: 2,
          //                                     style: const TextStyle(
          //                                         overflow: TextOverflow.ellipsis,
          //                                         fontSize: 18,
          //                                         fontWeight: FontWeight.w500),
          //                                   ),
          //                                   Helper.allowHeight(5),
          //                                   Text(
          //                                     state.notesData![index].noteContent!,
          //                                     maxLines: 3,
          //                                     style: const TextStyle(
          //                                         fontSize: 14,
          //                                         overflow: TextOverflow.ellipsis),
          //                                   ),
          //                                   Helper.allowHeight(5),
          //                                   Text(
          //                                     Initializer.updateHour(state
          //                                         .notesData![index].timestamp!),
          //                                     maxLines: 3,
          //                                     style: const TextStyle(
          //                                         fontSize: 12,
          //                                         overflow: TextOverflow.ellipsis),
          //                                   ),
          //                                 ],
          //                               ),
          //                             ),
          //                             Helper.allowWidth(15),
          //                             IconButton(
          //                                 onPressed: () => showDialog(
          //                                     context: context,
          //                                     builder: (context) => AlertDialog(
          //                                             title:
          //                                                 const Text('Delete note'),
          //                                             content: const Text(
          //                                                 'Are you sure, you want to delete this note?'),
          //                                             actions: [
          //                                               TextButton(
          //                                                 onPressed: () =>
          //                                                     Helper.pop(),
          //                                                 child:
          //                                                     const Text("Cancel"),
          //                                               ),
          //                                               TextButton(
          //                                                 onPressed: () {
          //                                                   Helper.pop();
          //                                                   context
          //                                                       .read<MainBloc>()
          //                                                       .add(DeleteNote(
          //                                                           noteId: state
          //                                                               .notesData![
          //                                                                   index]
          //                                                               .notesId,
          //                                                           userId: state
          //                                                               .notesData![
          //                                                                   index]
          //                                                               .userid));
          //                                                 },
          //                                                 child:
          //                                                     const Text("Delete"),
          //                                               ),
          //                                             ])),
          //                                 icon: const Icon(
          //                                     Icons.delete_forever_outlined))
          //                           ],
          //                         ),
          //                         if (index != state.notesData!.length - 1)
          //                           Column(
          //                             children: [
          //                               Helper.allowHeight(7.5),
          //                               const Divider(
          //                                 thickness: 0.3,
          //                               ),
          //                               Helper.allowHeight(7.5)
          //                             ],
          //                           ),
          //                       ],
          //                     ),
          //                   )),
          //         ),
          //       );
          //     }
          //     return const Center(child: CircularProgressIndicator());
          //   },
          // ),

          ),
    );
  }

  void loadAppOpenAd() {
    AppOpenAd.load(
        adUnitId: 'ca-app-pub-1921721310026993/6539525050',
        request: const AdRequest(),
        adLoadCallback: AppOpenAdLoadCallback(
          onAdFailedToLoad: (error) => {},
          onAdLoaded: (AppOpenAd ad) {},
        ),
        orientation: AppOpenAd.orientationPortrait);
  }
}

class MyTodo extends StatelessWidget {
  const MyTodo({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("rapidtodo")
            .where('userid', isEqualTo: Initializer.userId)
            .snapshots(),
        builder: (context, snapshot) => snapshot.hasData
            ? ListView(
                children: snapshot.data!.docs.map((document) {
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                  return ListTile(
                    trailing: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () => Helper.push(
                              UsersPage(
                                todoId: document.id,
                              ),
                              ''),
                          icon: const Icon(Icons.share),
                        ),
                        Helper.allowWidth(5.0),
                        IconButton(
                          onPressed: () async {
                            await FirebaseFirestore.instance
                                .collection('rapidtodo')
                                .doc(document.id)
                                .delete()
                                .then((value) => Helper.showLog("Success"));
                            Helper.showLog(document.id);
                          },
                          icon: const Icon(Icons.delete),
                        ),
                      ],
                    ),
                    title: Text(data['content']),
                    subtitle: Text(data['isEditable'].toString()),
                  );
                }).toList(),
              )
            : const CupertinoActivityIndicator());
  }
}

class ShredTodo extends StatelessWidget {
  const ShredTodo({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("rapidtodo")
            .where('shared', arrayContains: Initializer.userId)
            .snapshots(),
        builder: (context, snapshot) => snapshot.hasData &&
                snapshot.data!.docs.isNotEmpty
            ? ListView(
                children: snapshot.data!.docs.map((document) {
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                  return ListTile(
                    trailing: IconButton(
                      onPressed: () {
                        Initializer.updateTodoController!.text =
                            data['content'];
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  content: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextFormField(
                                        controller:
                                            Initializer.updateTodoController!,
                                        decoration: const InputDecoration(
                                            label: Text("Todo")),
                                      ),
                                      Helper.allowHeight(20),
                                      SizedBox(
                                        width: Helper.width(),
                                        child: MaterialButton(
                                          color: Colors.blueGrey,
                                          onPressed: () async {
                                            Helper.pop();
                                            await FirebaseFirestore.instance
                                                .collection('rapidtodo')
                                                .doc(document.id)
                                                .update({
                                              "content": Initializer
                                                  .updateTodoController!.text
                                            }).then((value) => Helper.showToast(
                                                    msg:
                                                        "todo updated successfully"));
                                          },
                                          child: const Text(
                                            "Update",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ));
                      },
                      icon: const Icon(Icons.edit),
                    ),
                    title: Text(data['content']),
                    subtitle: Text(data['isEditable'].toString()),
                  );
                }).toList(),
              )
            : const Center(
                child: Text("Nothing to shared to you"),
              ));
  }
}

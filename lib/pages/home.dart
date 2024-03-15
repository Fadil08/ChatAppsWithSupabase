// import 'dart:js_interop';

import 'package:flutter/material.dart';

import 'package:flutter_api/models/note_model.dart';
// import 'package:flutter_api/models/note_model.dart'
import 'package:flutter_api/services/serviceDatabase.dart';
import 'package:flutter_api/widget/constans.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final titlecontroler = TextEditingController();
  final description = TextEditingController();
  // final datecontroler = TextEditingController();
  bool isEditing = false;
  late DatabaseHelper dbHelper;
  late Notes _notes;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.dbHelper = DatabaseHelper();
    this.dbHelper.initDB().whenComplete(() async {
      setState(() {});
    });
  }

  Future<void> addOrEditNotes() async {
    if (!isEditing) {
      Notes notes = new Notes(
        title: titlecontroler.text.trim(),
        description: description.text.trim(),
        // date: datecontroler.text.trim()
      );

      await dbHelper.insertNotes(notes);
      print(notes);
    } else {
      _notes.title = titlecontroler.text.toString();
      _notes.description = description.text.trim();
      // _notes.date = datecontroler.text.trim();
      await dbHelper.updateUser(_notes);
    }
    setState(() {});
  }

  void resetdata() {
    titlecontroler.clear();
    description.clear();
  }

  final notestream = supabase.from('notes').stream(primaryKey: ['id']);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.search),
                color: Colors.black,
                onPressed: () {},
              ),
              Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    height: 20,
                    width: 20,
                    child: Center(
                      child: Text(
                        "2",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w800),
                      ),
                    ),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.red),
                  ))
            ],
          )
        ],
        title: Text(
          "Apps Notes",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: titlecontroler,
                    decoration: InputDecoration(labelText: "title"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: description,
                    decoration: InputDecoration(labelText: "Deskripsi"),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: TextFormField(
                //     controller: datecontroler,
                //     decoration: InputDecoration(labelText: "Date"),
                //   ),
                // ),
                TextButton(
                    onPressed: () {
                      final data = DatabaseHelper();
                      data.insertNote(
                          titlecontroler.text.trim(),
                          description.text.trim(),
                          supabase.auth.currentSession?.user.email.toString());
                      resetdata();
                    },
                    child: Text("Save")),
                Text("${supabase.auth.currentSession?.user.email}"),
                TextButton(
                    onPressed: () {
                      // final notes = new Notes(
                      //     // id: 1,
                      //     title: titlecontroler.text.trim(),
                      //     description: description.text.trim(),
                      //     name: 'dt'
                      //     // name: supabase.auth.currentSession?.user.email
                      //     //     .toString()
                      //     );
                      // this.dbHelper.createNote(notes: notes);
                      this.dbHelper.insertNote(
                          titlecontroler.text.trim(),
                          description.text.trim(),
                          supabase.auth.currentSession?.user.email.toString());
                    },
                    child: Text("Read")),
                Expanded(
                  flex: 1,
                  child: SafeArea(child: notesWidget()),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget notesWidget() {
    return StreamBuilder(
        stream: notestream,
        builder: (BuildContext context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          // print(snapshot.data);
          return ListView.builder(itemBuilder: (context, position) {
            try {
              print(snapshot.data);
              return Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Icon(Icons.delete_forever),
                ),
                onDismissed: (DismissDirection direction) async {
                  // ignore: unnecessary_this
                  this
                      .dbHelper
                      .deleteNote(snapshot.data![position]['id'].toString());
                  // await this
                  //     .dbHelper
                  //     .deleteNotes(snapshot.data![position].id!);
                },
                child: new GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  // onTap: () =>,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 6.0),
                                child: Text(
                                  snapshot.data![position]['title'],
                                  style: TextStyle(
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    12.0, 6.0, 12.0, 12.0),
                                child: Text(
                                  // "",
                                  snapshot.data![position]['description'],
                                  style: TextStyle(fontSize: 18.0),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.black26,
                                      borderRadius: BorderRadius.circular(100)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "",
                                      // snapshot.data![position]['id'],
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Divider(
                        height: 2.0,
                        color: Colors.grey,
                      )
                    ],
                  ),
                ),
              );
            } catch (e) {
              print(e);
            }
            // print(snapshot.data?[position].title);
          });
        });
  }

  void populateFields(Notes notes) {
    _notes = notes;
    titlecontroler.text = _notes.title;
    description.text = _notes.description.toString();
    // datecontroler.text = _notes.date;
    isEditing = true;
  }
}

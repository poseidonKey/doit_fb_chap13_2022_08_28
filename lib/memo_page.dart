import 'package:doit_chap13_fb/memo_add.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'memo.dart';

class MemoPage extends StatefulWidget {
  const MemoPage({Key? key}) : super(key: key);

  @override
  State<MemoPage> createState() => _MemoPageState();
}

class _MemoPageState extends State<MemoPage> {
  late FirebaseDatabase _database;
  late DatabaseReference reference;
  final String _databaseURL =
      "https://example-834ed-default-rtdb.asia-southeast1.firebasedatabase.app/";
  List<Memo> memos = [];
  @override
  void initState() {
    super.initState();
    _database = FirebaseDatabase.instance;
    _database.refFromURL(_databaseURL);
    reference = _database.ref().child("memo");
    reference.onChildAdded.listen((event) {
      print(event.snapshot.value.toString());
      setState(() {
        memos.add(
          Memo.fromSnapshot(event.snapshot),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('메모 앱'),
      ),
      body: Container(
        child: Center(
          child: memos.length == 0
              ? CircularProgressIndicator()
              : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return Card(
                      child: GridTile(
                        child: Container(
                          padding: EdgeInsets.only(top: 20, bottom: 20),
                          child: SizedBox(
                            child: GestureDetector(
                              onTap: () async {},
                              onLongPress: () {},
                              child: Text(memos[index].content),
                            ),
                          ),
                        ),
                        header: Text(memos[index].title),
                        footer: Text(memos[index].createTime.substring(0, 10)),
                      ),
                    );
                  },
                  itemCount: memos.length,
                ),
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 40),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => MemoAddPage(reference: reference),
              ),
            );
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

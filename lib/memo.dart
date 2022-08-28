import 'package:firebase_database/firebase_database.dart';

// class Memo {
//   String? key;
//   late String title;
//   late String content;
//   late String createTime;

//   Memo(this.title, this.content, this.createTime);

//   Memo.fromSnapshot(DataSnapshot snapshot) : key = snapshot.key {
//     this.title = (snapshot.value as Memo).title;
//     this.content = (snapshot.value as Memo).content;
//     this.createTime = (snapshot.value as Memo).createTime;
//   }
//   toJson() {
//     return {
//       'title': title,
//       'content': content,
//       'createTime': createTime,
//     };
//   }
// } 
class Memo {
  String? key;
  final String title;
  final String content;
  final String createTime;

  Memo(this.title, this.content, this.createTime);
  Memo.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        title = (snapshot.value as Memo).title,
        content = (snapshot.value as Memo).content,
        createTime = (snapshot.value as Memo).createTime;
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      'createTime': createTime,
    };
  }
}

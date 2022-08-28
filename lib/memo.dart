import 'package:firebase_database/firebase_database.dart';

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
  Map<String, String> toJson() {
    return {
      'title': title,
      'content': content,
      'createTime': createTime,
    };
  }
}

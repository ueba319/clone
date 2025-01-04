import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Firebaseの初期化処理
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

const collectionKey = 'ueba_todo';

class _MyHomePageState extends State<MyHomePage> {
  List<Item> items = [];
  final TextEditingController textEditingController = TextEditingController();
  late FirebaseFirestore firestore;

  @override
  void initState() {
    super.initState();
    firestore = FirebaseFirestore.instance;
    watch();
  }

  /// データ更新監視
  Future<void> watch() async {
    // collectionKeyで指定したものからデータをリアルタイムで変更があるかを監視し、変更があればsetStateを実行
    firestore.collection(collectionKey).snapshots().listen((event) {
      setState(() {
        // reversedによって逆順に表示され、itemsを更新する
        items = event.docs.reversed
            .map(
              (document) => Item.fromSnapShot(
                document.id,
                document.data(),
              ),
            )
            .toList(growable: false);
      });
    });
  }

  /// 保存する
  Future<void> save() async {
    final collection = firestore.collection(collectionKey);
    final now = DateTime.now();
    // 現在時刻とテキストをStringで保存する
    await collection.doc(now.millisecondsSinceEpoch.toString()).set({
      'date': now,
      'text': textEditingController.text,
    });
    // テキストを初期化する
    textEditingController.text = '';
  }

  /// 完了・未完了に変更する
  Future<void> complete(Item item) async {
    final collection = firestore.collection(collectionKey);

    // completedのBoolの反転したものをDBに保存するSetOptions:mergeでは、そのほかのフィールドは変換しないというオプション
    await collection.doc(item.id).set({
      'completed': !item.completed,
    }, SetOptions(merge: true));
  }

  /// 削除する
  Future<void> delete(String id) async {
    final collection = firestore.collection(collectionKey);
    await collection.doc(id).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TODO'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          if (index == 0) {
            return ListTile(
              title: TextField(
                controller: textEditingController,
              ),
              trailing: ElevatedButton(
                  onPressed: () {
                    save();
                  },
                  child: const Text('保存')),
            );
          }
          final item = items[index - 1];
          return Dismissible(
            key: Key(item.id),
            child: ListTile(
              leading: Icon(
                item.completed
                    ? Icons.check_box
                    : Icons.check_box_outline_blank,
              ),
              onTap: () {
                complete(item);
              },
              title: Text(item.text),
              subtitle: Text(
                  item.date.toString().replaceAll('-', '/').substring(0, 19)),
            ),
            onDismissed: (direction) {
              delete(item.id);
            },
          );
        },
        itemCount: items.length + 1,
      ),
    );
  }
}

class Item {
  const Item({
    required this.id,
    required this.text,
    required this.completed,
    required this.date,
  });
  final String id;
  final String text;
  final bool completed;
  final DateTime date;

  factory Item.fromSnapShot(String id, Map<String, dynamic> document) {
    return Item(
      id: id,
      text: document['text'].toString(),
      completed: document['completed'] ?? false,
      date: (document['date'] as Timestamp).toDate(),
    );
  }
}

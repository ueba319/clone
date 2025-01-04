import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
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

class _MyHomePageState extends State<MyHomePage> {
  String name = '';
  String room = '';

  /// エラー表示
  void showError(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(message),
          );
        });
  }

  /// 入室処理
  void enter() {
    if (name.isEmpty) {
      showError('あなたの名前を入力してください。');
      return;
    }
    if (room.isEmpty) {
      showError('部屋名を入力してください。');
      return;
    }
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ChatPage(name: name, room: room);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('チャット'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: TextField(
              decoration: const InputDecoration(hintText: 'あなたの名前'),
              onChanged: (value) {
                name = value;
              },
            ),
          ),
          ListTile(
            title: TextField(
              decoration: const InputDecoration(hintText: '部屋名'),
              onChanged: (value) {
                room = value;
              },
            ),
          ),
          ListTile(
              title: ElevatedButton(
            onPressed: () {
              enter();
            },
            child: const Text('入室する'),
          )),
        ],
      ),
    );
  }
}

class ChatPage extends StatefulWidget {
  const ChatPage({
    super.key,
    required this.name,
    required this.room,
  });

  final String name;
  final String room;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<Item> items = [];
  late FirebaseFirestore firestore;
  late CollectionReference<Map<String, dynamic>> collection;
  late final TextEditingController textEditingController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    firestore = FirebaseFirestore.instance;
    collection =
        firestore.collection('room').doc(widget.room).collection('items');
    watch();
  }

  /// データ更新管理
  Future<void> watch() async {
    collection.snapshots().listen((event) {
      if (mounted) {
        setState(() {
          items = event.docs.reversed
              .map(
                (document) => Item.fromSnapshot(
                  document.id,
                  document.data(),
                ),
              )
              .toList(growable: false);
        });
      }
    });
  }

  /// 保存する
  Future<void> save() async {
    final now = DateTime.now();

    await collection.doc(now.millisecondsSinceEpoch.toString()).set({
      'date': Timestamp.fromDate(now),
      'name': widget.name,
      'text': textEditingController.text,
    });

    textEditingController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.room),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemBuilder: (context, index) {
                final item = items[index];
                final isMe = item.name == widget.name;
                return Padding(
                  padding: isMe
                      ? const EdgeInsets.only(left: 80, right: 16, top: 16)
                      : const EdgeInsets.only(left: 16, right: 80, top: 16),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    tileColor: isMe ? Colors.tealAccent : Colors.black12,
                    title: Text(item.text),
                    subtitle: Text(
                        '${item.name} ${item.date.toString().replaceAll('-', '/').substring(0, 16)}'),
                  ),
                );
              },
              itemCount: items.length,
            ),
          ),
          SafeArea(
            child: ListTile(
              title: TextField(
                controller: textEditingController,
              ),
              trailing: ElevatedButton(
                  onPressed: () {
                    save();
                  },
                  child: const Text('送信')),
            ),
          ),
        ],
      ),
    );
  }
}

class Item {
  const Item({
    required this.id,
    required this.name,
    required this.text,
    required this.date,
  });
  final String id;
  final String name;
  final String text;
  final DateTime date;

  factory Item.fromSnapshot(String id, Map<String, dynamic> document) {
    return Item(
      id: id,
      text: document['text'].toString(),
      name: document['name'].toString(),
      date: (document['date'] as Timestamp).toDate(),
    );
  }
}

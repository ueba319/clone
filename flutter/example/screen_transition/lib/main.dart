import 'package:flutter/material.dart';

void main() {
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
  List<Map<String, String>> contacts = [
    {'name': '山田 太郎', 'number': '000-0000-0000', 'address': '東京都'},
    {'name': '鈴木 一郎', 'number': '111-1111-1111', 'address': '神奈川県'},
    {'name': '佐藤 花子', 'number': '222-2222-2222', 'address': '大阪府'},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.phone),
            title: Text(contacts[index]['name']!),
            subtitle: Text(contacts[index]['number']!),
            trailing: const Icon(Icons.keyboard_arrow_right),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return DetailView(contact: contacts[index]);
              }));
            },
          );
        },
      ),
    );
  }
}

class DetailView extends StatelessWidget {
  const DetailView({super.key, required this.contact});
  final Map<String, String> contact;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        '${contact['name']}',
      )),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const SizedBox(width: 30),
                  const Icon(Icons.people),
                  Text(
                    '名前: ${contact['name']}',
                    style: const TextStyle(fontSize: 20),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const SizedBox(width: 30),
                  const Icon(Icons.phone),
                  Text(
                    '電話: ${contact['number']}',
                    style: const TextStyle(fontSize: 20),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const SizedBox(width: 30),
                  const Icon(Icons.home),
                  Text(
                    '住所: ${contact['address']}',
                    style: const TextStyle(fontSize: 20),
                  )
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.call),
                  Text('電話を掛ける'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

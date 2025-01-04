import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mvvm_test/domain/todos/todo.dart';
import 'package:mvvm_test/view_models/todos_view_model.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
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
      home: TodosPage(),
    );
  }
}

class TodosPage extends ConsumerWidget {
  TodosPage({super.key});

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Todo> todos = ref.watch(todosViewmodelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('TODO'),
      ),
      body: ListView.builder(
        itemCount: todos.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return ListTile(
              title: TextField(
                controller: controller,
              ),
              trailing: ElevatedButton(
                onPressed: () {
                  ref
                      .read(todosViewmodelProvider.notifier)
                      .addTodoByTitle(controller.text);
                  controller.clear();
                },
                child: const Text('登録'),
              ),
            );
          }
          final todo = todos[index - 1];
          return ListTile(
            title: Text(todo.title),
            trailing: Checkbox(
              value: todo.isCompleted,
              onChanged: (bool? newValue) {
                ref
                    .read(todosViewmodelProvider.notifier)
                    .toggleTodoStatus(todo.id);
              },
            ),
          );
        },
      ),
    );
  }
}

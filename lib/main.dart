import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
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
  List<String> todos = [];
  TextEditingController todoNameEditingController = TextEditingController();
  TextEditingController updateTodoNameEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Todo Name',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                          controller: todoNameEditingController,
                          decoration: const InputDecoration(
                            hintText: 'Write Your Todo',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              if (todoNameEditingController.text
                                  .trim()
                                  .isNotEmpty) {
                                todos
                                    .add(todoNameEditingController.text.trim());
                              }
                              todoNameEditingController.text = '';
                              setState(() {

                              });

                              Navigator.pop(context);
                            },
                            child: const Text('Add Todo'))
                      ],
                    ),
                  );
                });
          },
          label: const Text('Add Todo')),
      body: ListView.builder(
          itemCount: todos.length,
          itemBuilder: (context, index) {
            final String todo1 = todos[(todos.length - 1) - index];

            print(todo1);
            return Card(
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Row(
                  children: [
                    Text(todo1, style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16),),
                    const Spacer(), 
                    IconButton(onPressed: (){
                      todos.removeAt((todos.length - 1 ) - index);
                      setState(() {

                      });
                    }, icon: const Icon(Icons.delete_forever_outlined, color: Colors.red,)),
                    IconButton(onPressed: (){
                      updateTodoNameEditingController.text = todo1;

                      showModalBottomSheet(context: context, builder: (context){
                        return Padding(padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Update todo name'),
                            const SizedBox(height: 16),
                            TextField(
                              controller: updateTodoNameEditingController,
                              decoration: const InputDecoration(
                                hintText: 'Write your todo',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            ElevatedButton(onPressed: (){
                              if(updateTodoNameEditingController.text.trim().isNotEmpty){
                                todos[(todos.length - 1) - index ] = updateTodoNameEditingController.text.trim();
                                setState(() {

                                });
                                Navigator.pop(context);
                              }
                            }, child: Text('Update Todo'))
                          ],
                        ),


                        );
                      });
                    }, icon: const Icon(Icons.edit, color: Colors.yellow,))
                    
                  ],
                ),
              ),
            );
          }),
    );
  }
}

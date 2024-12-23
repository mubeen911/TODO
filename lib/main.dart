import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/todo_app/screens/screen.dart';
import 'package:flutter/material.dart';
import 'package:todo/bloc/todo_block.dart';

// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:todo/todo_app/hive/modelclass.dart';
//import 'package:todo/todo_app/screens/screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //ApiService.getTodos();
  // await Hive.initFlutter();

  //Hive.registerAdapter(ModelClassAdapter());

  //await Hive.openBox<ModelClass>('tasks');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => TodoBloc(),
        child: const Screen(),
      ),
    );
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_isolate/services/compute.dart';
import 'package:flutter_isolate/services/spawn.dart';

import 'api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Person? person;

  final computeService = ComputeService();

  final spawnService = SpawnService();

  void _compute() {
    computeService.fetchUser().then((value) {
      setState(() {
        person = value;
      });
    });
  }

  void _spawn() {
    spawnService.fetchUser().then((value) {
      setState(() {
        person = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              person?.name ?? 'Hello World',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(
              height: 24,
            ),
            ElevatedButton(
                onPressed: _compute, child: const Text("Using Compute")),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(onPressed: _spawn, child: const Text("Using Spawn")),
          ],
        ),
      ),
    );
  }
}

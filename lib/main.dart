import 'package:flutter/material.dart';

// Local State
// Shared/App State

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final String appName = 'Flutter Demo';

  int _counter = 0;

  void _increment() {
    _counter++;
    setState(() {}); // Why we need setState()
  }

  @override
  Widget build(BuildContext context) {
    return CounterInheritedWidget(
      counter: _counter,
      incrementCounter: _increment,
      child: MaterialApp(
        title: appName,
        theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
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
  // State -> Obostha

  void _incrementCounter() {
    CounterInheritedWidget.of(context).incrementCounter();
  }

  @override
  Widget build(BuildContext context) {
    final counter = context
        .dependOnInheritedWidgetOfExactType<CounterInheritedWidget>()!
        .counter;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            const Text('You have pushed the button this many times:'),
            Text('$counter', style: Theme.of(context).textTheme.headlineMedium),
            FilledButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LastScreen()),
                );
              },
              child: Text('Go to Last Screen'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    final counter = CounterInheritedWidget.getValue(context);

    return Scaffold(
      appBar: AppBar(title: Text('First Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            const Text('You have pushed the button this many times:'),
            Text('$counter', style: Theme.of(context).textTheme.headlineMedium),
          ],
        ),
      ),
    );
  }
}

class LastScreen extends StatefulWidget {
  const LastScreen({super.key});

  @override
  State<LastScreen> createState() => _LastScreenState();
}

class _LastScreenState extends State<LastScreen> {
  void _incrementCounter() {
    CounterInheritedWidget.of(context).incrementCounter();
  }

  @override
  Widget build(BuildContext context) {
    final counter = CounterInheritedWidget.getValue(context);

    return Scaffold(
      appBar: AppBar(title: Text('Last Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            const Text('You have pushed the button this many times:'),
            Text('$counter', style: Theme.of(context).textTheme.headlineMedium),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CounterInheritedWidget extends InheritedWidget {
  final int counter;
  final VoidCallback incrementCounter;

  const CounterInheritedWidget({
    super.key,
    required super.child,
    required this.counter,
    required this.incrementCounter,
  });

  static int getValue(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<CounterInheritedWidget>()!
        .counter;
  }

  static CounterInheritedWidget of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<CounterInheritedWidget>()!;
  }

  @override
  bool updateShouldNotify(CounterInheritedWidget oldState) {
    return counter != oldState.counter;
  }
}

// class FrogColor extends InheritedWidget {
//   const FrogColor({
//     super.key,
//     required this.color,
//     required super.child,
//   });
//
//   final Color color;
//
//   static FrogColor? maybeOf(BuildContext context) {
//     return context.dependOnInheritedWidgetOfExactType<FrogColor>();
//   }
//
//   static FrogColor of(BuildContext context) {
//     final FrogColor? result = maybeOf(context);
//     assert(result != null, 'No FrogColor found in context');
//     return result!;
//   }
//
//   @override
//   bool updateShouldNotify(FrogColor oldWidget) => color != oldWidget.color;
// }

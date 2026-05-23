import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CounterController(),
      child: MaterialApp(
        title: appName,
        theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            const Text('You have pushed the button this many times:'),
            Consumer<CounterController>(
              builder: (context, counterController, _) {
                return Text(
                  '${counterController.counter}',
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            ),
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
        onPressed: context.read<CounterController>().increment,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('First Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            const Text('You have pushed the button this many times:'),
            Consumer<CounterController>(
              builder: (context, counterController, _) {
                return Text(
                  '${counterController.counter}',
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            ),
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
    context.read<CounterController>().increment();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Last Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            const Text('You have pushed the button this many times:'),
            Consumer<CounterController>(
              builder: (context, counterController, _) {
                return Text(
                  '${counterController.counter}',
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
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
//
// class CounterInheritedWidget extends InheritedWidget {
//   final int counter;
//   final VoidCallback incrementCounter;
//
//   const CounterInheritedWidget({
//     super.key,
//     required super.child,
//     required this.counter,
//     required this.incrementCounter,
//   });
//
//   static int getValue(BuildContext context) {
//     return context
//         .dependOnInheritedWidgetOfExactType<CounterInheritedWidget>()!
//         .counter;
//   }
//
//   static CounterInheritedWidget of(BuildContext context) {
//     return context
//         .dependOnInheritedWidgetOfExactType<CounterInheritedWidget>()!;
//   }
//
//   @override
//   bool updateShouldNotify(CounterInheritedWidget oldState) {
//     return counter != oldState.counter;
//   }
// }//

// 1. Notify Changes
class CounterController extends ChangeNotifier {
  int counter = 0;

  void increment() {
    counter++;
    notifyListeners();
  }

  void decrement() {
    counter--;
    notifyListeners();
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

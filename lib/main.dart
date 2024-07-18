import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdc_bloc_example/color_provider.dart';
import 'package:pdc_bloc_example/counter_provider.dart';

void main() {
  runApp(BlocProvider(
    create: (_) => CounterBLoC(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ColorBLoC(),
      child: BlocBuilder<ColorBLoC, MaterialColor>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Flutter Demo',
            // color: state,
            theme: ThemeData(
              colorSchemeSeed: state,
            ),
            home: const MyStatelessHomepage(title: 'A better counter'),
          );
        },
      ),
    );
  }
}

class MyStatelessHomepage extends StatelessWidget {
  final String title;

  const MyStatelessHomepage({Key? key, required this.title}) : super(key: key);

  void _incrementCounter(BuildContext context) {
    context.read<CounterBLoC>().add(CounterIncrementPressedEvent());
  }

  void _decrementCounter(BuildContext context) {
    context.read<CounterBLoC>().add(CounterDecrementPressedEvent());
  }

  void _changeBackgroundColor(BuildContext context) {
    context.read<ColorBLoC>().add(ColorChange());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: BlocConsumer<CounterBLoC, int>(
          listenWhen: (previous, current) {
            return current > previous && current % 3 == 0;
          },
          listener: (context, state) {
            if (state % 3 == 0) {
              context.read<ColorBLoC>().add(ColorChange());
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Divisible by 3! Background Color Changed!'),
                ),
              );
            }
          },
          builder: (BuildContext context, int count) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'You have pushed the button this many times:',
                ),
                Text(
                  '$count',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(
                onPressed: () => _changeBackgroundColor(context),
                tooltip: 'Change Background',
                child: const Icon(Icons.color_lens),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(
                onPressed: () => _incrementCounter(context),
                tooltip: 'Increment',
                child: const Icon(Icons.add),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(
                onPressed: () => _decrementCounter(context),
                tooltip: 'Decrement',
                child: const Icon(Icons.remove),
              ),
            ),
          ],
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}

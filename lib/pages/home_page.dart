import 'package:alan/router.dart';
import 'package:flutter/material.dart';

import '../blocs/theme_bloc.dart';
import '../blocs/voice_bloc.dart';
import '../widgets/design/background_blueprint_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  void initState() {
    super.initState();
    voiceBloc.addCommand('increment', _incrementCounter);
    voiceBloc.addCommand('decrement', _decrementCounter);
    voiceBloc.addCommand('reset', _resetCounter);
    voiceBloc.addCommand('help', () {
      AppRoutes.routeTo('help');
    });
    voiceBloc.addCommand('goBack', () {
      AppRoutes.goBack();
    });
    blocTheme;

  }

  @override
  Widget build(BuildContext context) {
    AppRoutes.setContext(context);
    voiceBloc.addButton();
    return BackgroundBlueprintWidget(
        widget: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'You have pushed the button this many times:',
          ),
          Text(
            '$_counter',
            style: Theme.of(context).textTheme.headline4,
          ),
          ElevatedButton(
              onPressed: () {
                AppRoutes.routeTo('help');
              },
              child: const Text('Open help pages'))
        ],
      ),
    ));
  }
}

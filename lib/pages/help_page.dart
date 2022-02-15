import 'package:flutter/material.dart';

import '../router.dart';
import '../widgets/design/background_blueprint_widget.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({Key? key}) : super(key: key);

  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  @override
  Widget build(BuildContext context) {
    return BackgroundBlueprintWidget(
        widget: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(),
          const _HelpTile(
            title: "hello world",
            subtitle: "Only returns a greeting",
          ),
          const Divider(),
          const _HelpTile(
            title: "What is your name?",
            subtitle: "Alan's name is pronounced",
          ),
          const Divider(),
          const _HelpTile(
            title: "increment the counter",
            subtitle: "Increment the counter by one",
          ),
          const Divider(),
          const _HelpTile(
            title: "decrement the counter",
            subtitle: "Decrement the counter by one, only in the first screen.",
          ),
          const Divider(),
          const _HelpTile(
            title: "reset the counter",
            subtitle: "Set the counter in zero.",
          ),
          const Divider(),
          const _HelpTile(
            title: "go back",
            subtitle: "Go to previous screen.",
          ),
          const Divider(),
          const Divider(),
          const _HelpTile(
            title: "Interactions",
            subtitle: "10.000 interactiosn allowed.",
          ),
          const Divider(),
          ElevatedButton(
              onPressed: () {
                AppRoutes.goBack();
              },
              child: const Text('Go back'))
        ],
      ),
    ));
  }
}

class _HelpTile extends StatelessWidget {
  const _HelpTile({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  final String title, subtitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }
}

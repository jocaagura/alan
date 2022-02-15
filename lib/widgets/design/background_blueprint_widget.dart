import 'package:flutter/material.dart';


class BackgroundBlueprintWidget extends StatelessWidget {
  const BackgroundBlueprintWidget({Key? key, required this.widget, this.title = 'Alan voice demo'}) : super(key: key);

  final Widget widget;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: widget,
    );
  }
}

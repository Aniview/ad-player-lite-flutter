import 'package:ad_player_lite_example/examples/basic.dart';
import 'package:ad_player_lite_example/examples/floating.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

enum Example {
  basic(screen: BasicExampleScreen(), description: "Shows a basic InRead functionality"),
  floating(
    screen: FloatingExampleScreen(),
    description:
        "Shows floating placement feature.\nThis requires a tag with floating feature enabled in the Aniview dashboard",
  );

  final Widget screen;
  final String description;

  const Example({required this.screen, required this.description});
}

class MainScreen extends HookWidget {
  const MainScreen({super.key});

  ////////////////////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Select example")),
      body: SafeArea(child: _buildContent(context)),
    );
  }

  ////////////////////////////////////////////////////////////////////////////////
  Widget _buildContent(BuildContext context) {
    return ListView.builder(
      itemCount: Example.values.length,
      itemBuilder: (context, index) {
        final example = Example.values[index];
        return InkWell(
          onTap: () => _showExample(context, example),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(example.name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                Text(example.description),
              ],
            ),
          ),
        );
      },
    );
  }

  ////////////////////////////////////////////////////////////////////////////////
  void _showExample(BuildContext context, Example example) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => example.screen));
  }
}

import 'package:adplayerlite_flutter_plugin/ad_player.dart';
import 'package:adplayerlite_flutter_plugin_example/main_screen.dart';
import 'package:flutter/material.dart';

final pubId = "655b78633181f4603178b4568";
final tagId = "69a85c4cf0207bb55009bba7";
final adPlayer = AdPlayer.initialize(iosStoreUrl: "https://apps.apple.com/us/app/demo-app/id1234567");

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "AdPlayerLite Demo",
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue), useMaterial3: true),
      home: const MainScreen(),
    );
  }
}

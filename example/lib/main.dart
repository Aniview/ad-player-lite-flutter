import 'package:ad_player_lite/ad_player.dart';
import 'package:ad_player_lite_example/main_screen.dart';
import 'package:flutter/material.dart';

final adPlayer = AdPlayer.initialize(
  iosStoreUrl: "https://apps.apple.com/us/app/demo-app/id1234567",
);

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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}

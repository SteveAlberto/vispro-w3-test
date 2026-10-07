import 'package:flutter/material.dart';
import 'home_screen.dart';

const Color kSeedColor = Color(0xFF00897B);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SplitBill App',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: kSeedColor),
      ),
      themeMode: ThemeMode.system,
      home: const LayarAwal(),
      debugShowCheckedModeBanner: false,
    );
  }
}
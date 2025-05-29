import 'package:flutter/material.dart';
import './screens/temp_converter.dart';

void main() => runApp(const TempConverterApp());

class TempConverterApp extends StatelessWidget {
  const TempConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TempConverterScreen(), // This must match the class name in temp_converter.dart
    );
  }
}

import 'package:flutter/material.dart';

class TempConverterScreen extends StatefulWidget {
  const TempConverterScreen({super.key});

  @override
  State<TempConverterScreen> createState() => _TempConverterScreenState();
}

class _TempConverterScreenState extends State<TempConverterScreen> {
  final TextEditingController _tempController = TextEditingController();
  String _conversionType = 'F to C';
  String _result = '';
  List<String> _history = [];

  void _convertTemperature() {
    final input = double.tryParse(_tempController.text);
    if (input == null) {
      setState(() {
        _result = 'Please enter a valid number.';
      });
      return;
    }

    double converted;
    String record;

    if (_conversionType == 'F to C') {
      converted = (input - 32) * 5 / 9;
      record = 'F to C: $input => ${converted.toStringAsFixed(2)}';
    } else {
      converted = input * 9 / 5 + 32;
      record = 'C to F: $input => ${converted.toStringAsFixed(2)}';
    }

    setState(() {
      _result = 'Result: ${converted.toStringAsFixed(2)}';
      _history.insert(0, record);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final inputSection = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: _tempController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(
            labelText: 'Enter temperature',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),
        DropdownButton<String>(
          value: _conversionType,
          isExpanded: true,
          onChanged: (value) {
            if (value != null) {
              setState(() {
                _conversionType = value;
              });
            }
          },
          items: const [
            DropdownMenuItem(
              value: 'F to C',
              child: Text('Fahrenheit to Celsius'),
            ),
            DropdownMenuItem(
              value: 'C to F',
              child: Text('Celsius to Fahrenheit'),
            ),
          ],
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: _convertTemperature,
          child: const Text('Convert'),
        ),
        const SizedBox(height: 10),
        Text(
          _result,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );

    final historySection = Expanded(
      child: ListView.builder(
        itemCount: _history.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.history),
            title: Text(_history[index]),
          );
        },
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Temperature Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLandscape
            ? Row(
                children: [
                  Expanded(child: inputSection),
                  const SizedBox(width: 16),
                  historySection,
                ],
              )
            : Column(
                children: [
                  inputSection,
                  const SizedBox(height: 16),
                  historySection,
                ],
              ),
      ),
    );
  }
}

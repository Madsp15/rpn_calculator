import 'package:flutter/material.dart';

import 'calculator.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'It is calculator time',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: CalculatorHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CalculatorHomePage extends StatefulWidget {
  @override
  _CalculatorHomePageState createState() => _CalculatorHomePageState();
}

class _CalculatorHomePageState extends State<CalculatorHomePage> {
  String output = '0';
  String sequence = '';
  final List<String> digitButtons = [
    '7',
    '8',
    '9',
    '4',
    '5',
    '6',
    '1',
    '2',
    '3',
    '0'
  ];
  final List<String> operatorButtons = ['+', '-', '*', '/', '=', 'C'];

// Create an instance of the Calculator class
  final Calculator calculator = Calculator([]);

  Widget buildNumberButtons(String digit) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            calculator.push(int.parse(digit));
            // Update the sequence string
            sequence += digit;
            // Update the output string
            output = sequence;
          });
        },
        child: Text(
          digit,
          style: TextStyle(fontSize: 20), // Customize button text style
        ),
      ),
    );
  }

  Widget buildOperatorButton(String operator) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            // Execute the corresponding command
            switch (operator) {
              case '+':
                sequence += ' + ';
                break;
              case '-':
                sequence += ' - ';
                break;
              case '*':
                sequence += ' * ';
                break;
              case '/':
                sequence += ' / ';
                break;
              case 'C':
                calculator.stack.clear();
                sequence = '';
                output = '0';
                break;
              case '=':
              // Display the result
                if (calculator.stack.isNotEmpty) {
                  if(sequence.contains('*')){
                    calculator.execute(Multiplication());
                  } else if(sequence.contains('/')){
                    calculator.execute(Division());
                  } else if(sequence.contains('+')){
                    calculator.execute(Addition());
                  } else if(sequence.contains('-')){
                    calculator.execute(Subtraction());
                  }
                  sequence += ' = ' + calculator.stack.last.toString();
                  output = sequence;
                }
                break;
            }
            // Update the output string
            output = sequence;
          });
        },
        child: Text(
          operator,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SafeArea(
            child: Text(
              output,
              style: TextStyle(fontSize: 24),
            ),
          ),
          Divider(),
          buttonDisplay(),
        ],
      ),
    );
  }

  Container buttonDisplay() {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              buildNumberButtons(digitButtons[0]),
              buildNumberButtons(digitButtons[1]),
              buildNumberButtons(digitButtons[2]),
              buildOperatorButton(operatorButtons[0]),
            ],
          ),
          Row(
            children: [
              buildNumberButtons(digitButtons[3]),
              buildNumberButtons(digitButtons[4]),
              buildNumberButtons(digitButtons[5]),
              buildOperatorButton(operatorButtons[1]),
            ],
          ),
          Row(
            children: [
              buildNumberButtons(digitButtons[6]),
              buildNumberButtons(digitButtons[7]),
              buildNumberButtons(digitButtons[8]),
              buildOperatorButton(operatorButtons[2]),
            ],
          ),
          Row(
            children: [
              buildNumberButtons(digitButtons[9]),
              buildOperatorButton(operatorButtons[3]),
              buildOperatorButton(operatorButtons[4]),
              buildOperatorButton(operatorButtons[5])
            ],
          ),
        ],
      ),
    );
  }
}

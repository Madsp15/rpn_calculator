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
  String output = '';
  String sequence = '';
  String temp = '';
  final List<String> digitButtons = ['7', '8', '9', '4', '5', '6', '1', '2', '3', '0'];
  final List<String> operatorButtons = ['+', '-', '*', '/', '=', 'C'];

  double buttonHeight = 100.0;
  double buttonWidth = 100.0;

// Create an instance of the Calculator class
  final Calculator calculator = Calculator([]);

  Widget buildNumberButtons(String digit) {
    return Expanded(
      child: Container(
        height: buttonHeight, // Specify your height
        width: buttonWidth, // Specify your width
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.purple, // background
            onPrimary: Colors.white, // foreground
            padding: EdgeInsets.all(5.0), // Set button padding
            shape: CircleBorder(
              side: BorderSide(
                color: Colors.black, // Set border color
                width: 0.5, // Set border width
              ),
            ),

          ),
          onPressed: () {
            setState(() {
              temp += digit;
              // Update the sequence string
              sequence += digit;
              // Update the output string
              output = sequence;
            });
          },
          child: Text(
            key: Key(digit.toString()),
            digit,
            style: TextStyle(fontSize: 30), // Customize button text style
          ),
        ),
      ),
    );
  }



  Widget buildOperatorButton(String operator) {
    return Expanded(
      child: Container(
        height: buttonHeight, // Specify your height
        width: buttonWidth, // Specify your width
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              // Execute the corresponding command
              switch (operator) {
                case '+':
                  sequence += ' + ';
                  calculator.push(int.parse(temp));
                  temp = '';
                  break;
                case '-':
                  sequence += ' - ';
                  calculator.push(int.parse(temp));
                  temp = '';
                  break;
                case '*':
                  sequence += ' * ';
                  calculator.push(int.parse(temp));
                  temp = '';
                  break;
                case '/':
                  sequence += ' / ';
                  calculator.push(int.parse(temp));
                  temp = '';
                  break;
                case 'C':
                  calculator.stack.clear();
                  sequence = '';
                  output = '0';
                  temp = '';
                  break;
                case '=':
                // Display the result
                  calculator.push(int.parse(temp));
                  temp = '';
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
            key: Key(operator.toString()),
            operator,
            style: TextStyle(fontSize: 30),
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end, // Add this line
        children: [
          SafeArea(
            child: Text(
              key: Key("Display"),
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

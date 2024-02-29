// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:rpn_calculator/calculator.dart';




void main() {
  // Create an instance of the Calculator class
  final Calculator calculator = Calculator([]);

  group('PushCommand', () {
    test('Pushes a value to the stack', () {
      final stack = [1,2];
      stack.add(3);
      expect(stack, [1,2,3]);
    });
  });
  group('RemoveCommand', () {
    test('Removes a value to the stack', () {
      final stack = [1,2];
      stack.removeLast();
      expect(stack, [1]);
    });
  });
  group('PlusCommand', () {
    test('adds two numbers together', () {
      calculator.stack= [1,2];
      calculator.execute(Addition());
      expect(calculator.stack, [3]);
    });
  });
  group('MinusCommand', () {
    test('minuses two numbers', () {
      calculator.stack= [2,1];
      calculator.execute(Subtraction());
      expect(calculator.stack, [1]);
    });
  });
  group('MultiplyCommand', () {
    test('multiplies two numbers', () {
      calculator.stack= [2,3];
      calculator.execute(Multiplication());
      expect(calculator.stack, [6]);
    });
  });
  group('DivideCommand', () {
    test('divides two numbers', () {
      calculator.stack= [6,3];
      calculator.execute(Division());
      expect(calculator.stack, [2]);
    });
  });

}

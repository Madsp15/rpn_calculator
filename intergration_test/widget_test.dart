// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rpn_calculator/main.dart';

extension TesterExtensions on WidgetTester {
  Future<void> enterDigits(String digits) async {
    for (var digit in digits.characters) {
      await tapByKey(Key(digit));
    }
  }
  Future<void> tapByKey(Key key) async {
    await tap(find.byKey(key));
    await pump();
  }
}
extension FinderExtensions on CommonFinders {
  String? displayText() {
    final text = byKey(const Key("Display")).evaluate().single.widget as Text;
    return text.data;
  }
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Enter a number', (tester) async {
    await tester.pumpWidget(CalculatorApp());

    expect(find.displayText(), equals(''));
    await tester.enterDigits('123');
    expect(find.displayText(), equals('123'));
  });

  testWidgets('Add two numbers', (tester) async {
    await tester.pumpWidget(CalculatorApp());

    expect(find.displayText(), equals(''));
    await tester.enterDigits('123');
    await tester.tapByKey(const Key('+'));
    await tester.enterDigits('456');
    await tester.tapByKey(const Key('='));
    expect(find.displayText(), equals('579'));
  });
  testWidgets('Subtract two numbers for negative number', (tester) async {
    await tester.pumpWidget(CalculatorApp());

    expect(find.displayText(), equals(''));
    await tester.enterDigits('123');
    await tester.tapByKey(const Key('-'));
    await tester.enterDigits('456');
    await tester.tapByKey(const Key('='));
    expect(find.displayText(), equals('-333'));
  });
  testWidgets('Subtract two numbers', (tester) async {
    await tester.pumpWidget(CalculatorApp());

    expect(find.displayText(), equals(''));
    await tester.enterDigits('666');
    await tester.tapByKey(const Key('-'));
    await tester.enterDigits('333');
    await tester.tapByKey(const Key('='));
    expect(find.displayText(), equals('333'));
  });

  testWidgets('Multiply two numbers', (tester) async {
    await tester.pumpWidget(CalculatorApp());

    expect(find.displayText(), equals(''));
    await tester.enterDigits('70');
    await tester.tapByKey(const Key('*'));
    await tester.enterDigits('10');
    await tester.tapByKey(const Key('='));
    expect(find.displayText(), equals('700'));
  });
  testWidgets('Divide two numbers', (tester) async {
    await tester.pumpWidget(CalculatorApp());

    expect(find.displayText(), equals(''));
    await tester.enterDigits('666');
    await tester.tapByKey(const Key('/'));
    await tester.enterDigits('333');
    await tester.tapByKey(const Key('='));
    expect(find.displayText(), equals('111'));
  });
}

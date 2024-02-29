
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
    await tester.enterDigits('1');
    expect(find.displayText(), equals('1'));
  });

  testWidgets('Add two numbers', (tester) async {
    await tester.pumpWidget(CalculatorApp());

    expect(find.displayText(), equals(''));
    await tester.enterDigits('1');
    await tester.tapByKey(const Key('+'));
    await tester.enterDigits('2');
    await tester.tapByKey(const Key('='));
    expect(find.displayText(), equals('1 + 2 = 3'));
  });
  testWidgets('Subtract two numbers for negative number', (tester) async {
    await tester.pumpWidget(CalculatorApp());

    expect(find.displayText(), equals(''));
    await tester.enterDigits('6');
    await tester.tapByKey(const Key('-'));
    await tester.enterDigits('3');
    await tester.tapByKey(const Key('='));
    expect(find.displayText(), equals('6 - 3 = 3'));
  });
  testWidgets('Subtract two numbers', (tester) async {
    await tester.pumpWidget(CalculatorApp());

    expect(find.displayText(), equals(''));
    await tester.enterDigits('6');
    await tester.tapByKey(const Key('-'));
    await tester.enterDigits('3');
    await tester.tapByKey(const Key('='));
    expect(find.displayText(), equals('6 - 3 = 3'));
  });

  testWidgets('Multiply two numbers', (tester) async {
    await tester.pumpWidget(CalculatorApp());

    expect(find.displayText(), equals(''));
    await tester.enterDigits('7');
    await tester.tapByKey(const Key('*'));
    await tester.enterDigits('2');
    await tester.tapByKey(const Key('='));
    expect(find.displayText(), equals('7 * 2 = 14'));
  });
  testWidgets('Divide two numbers', (tester) async {
    await tester.pumpWidget(CalculatorApp());

    expect(find.displayText(), equals(''));
    await tester.enterDigits('6');
    await tester.tapByKey(const Key('/'));
    await tester.enterDigits('3');
    await tester.tapByKey(const Key('='));
    expect(find.displayText(), equals('6 / 3 = 2.0'));
  });
}

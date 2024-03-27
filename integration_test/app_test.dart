import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tests_study/features/home/home_page.dart';
import 'package:tests_study/repositories/advice/advice_repository.dart';

class MockAdviceRepository implements AdviceRepository {
  final List<String> advices = [
    'id: 1,advice: teste 1',
    'id: 2,advice: teste 2',
    'id: 3,advice: teste 3',
    'id: 4,advice: teste 4',
  ];

  int currentIndex = 0;

  @override
  Future<String> getAdvice() async {
    return getNextAdvice();
  }

  String getNextAdvice() {
    if (currentIndex >= advices.length) {
      return advices[0];
    }
    String currentItem = advices[currentIndex];
    currentIndex++;

    return currentItem;
  }
}

void main() {
  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: HomePage(adviceRepository: MockAdviceRepository()),
    );
  }

  testWidgets(
    'Tapping on the New Advice button gives a diferente advice',
    (widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      await widgetTester.pump();

      expect(find.text('id: 1,advice: teste 1'), findsOneWidget);

      await widgetTester.tap(find.byKey(const Key('New Advice Button')));

      await widgetTester.pumpAndSettle();

      expect(find.text('id: 2,advice: teste 2'), findsOneWidget);
    },
  );
}

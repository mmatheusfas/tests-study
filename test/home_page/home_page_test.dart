import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tests_study/features/home/home_page.dart';
import 'package:tests_study/repositories/advice/advice_repository.dart';

class MockAdviceRepository implements AdviceRepository {
  @override
  Future<String> getAdvice() async {
    await Future.delayed(const Duration(seconds: 2));
    return 'id: 1,advice: teste,';
  }
}

void main() {
  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: HomePage(adviceRepository: MockAdviceRepository()),
    );
  }

  testWidgets('title is displayed', (widgetTester) async {
    // Pump Widget creates and build the widget that I want to test, it must have the MaterialApp as it's parent
    await widgetTester.pumpWidget(createWidgetUnderTest());

    expect(find.text('Advice of the day'), findsOneWidget);
  });

  testWidgets('loading indicator is displayed while waiting the advice', (widgetTester) async {
    await widgetTester.pumpWidget(createWidgetUnderTest());

    //Pump forces the widget to rebuild, in this case our future inside the MockAdviceRepository waits 2 seconds
    //so we give an Duration to the pump method that says, aftes 500 milliseconds rebuild the widget because the
    //circular progress indicator should be spinning for 2 seconds. Usually used to test dynamic widgets
    await widgetTester.pump(const Duration(milliseconds: 500));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    //PumpAndSettle waits until there is no more animation/rebuilds running, in this case our circular progress is
    //an animation so we called the pump after half a second so it still has 1.5 seconds to run, if we don't wait
    //this 1.5 seconds we have an error
    await widgetTester.pumpAndSettle();
  });

  testWidgets('advice is displayed', (widgetTester) async {
    await widgetTester.pumpWidget(createWidgetUnderTest());

    //Here we are calling the pump and settle to wait for the 2 seconds future ands and then check if we got the
    //response that we wanted
    await widgetTester.pumpAndSettle();
    expect(find.text('id: 1,advice: teste,'), findsOneWidget);
  });
}

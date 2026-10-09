// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:inclass_05/main.dart';

void main() {
  testWidgets('Profile points increment when the FAB is tapped', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const ProfileApp());

    expect(find.text('My Profile'), findsOneWidget);
    expect(find.text('Diluka'), findsOneWidget);
    expect(find.text('diluka.w@nsbm.ac.lk'), findsOneWidget);
    expect(find.byTooltip('Choose profile photo'), findsOneWidget);
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    await tester.tap(find.byTooltip('Add point'));
    await tester.pump();

    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:personal_trainer/main.dart';

void main() {
  testWidgets('exibe tela inicial do aplicativo', (tester) async {
    await tester.pumpWidget(const MainApp());

    expect(find.text('Personal Trainer'), findsOneWidget);
    expect(find.text('Meus alunos'), findsOneWidget);
  });
}
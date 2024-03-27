import 'package:flutter_test/flutter_test.dart';
import 'package:tests_study/features/home/home_controller.dart';
import 'package:tests_study/repositories/advice/advice_repository.dart';

class MockAdviceRepository implements AdviceRepository {
  @override
  Future<String> getAdvice() async {
    return 'id: 1,advice: teste,';
  }
}

// class MockAdviceRepository extends Mock implements AdviceRepository {}

void main() {
  late HomeController sut;
  late MockAdviceRepository mockAdviceRepository;

  setUp(() {
    mockAdviceRepository = MockAdviceRepository();
    sut = HomeController(mockAdviceRepository);
  });

  test('test if initial values are right', () async {
    expect(sut.isLoading, false);
  });

  group('getAdvice', () {
    test('getAdvice using the AdviceRepository', () async {
      /*  final mockArticle = {
        'slip_id': 1,
        'advice': 'teste',
      };
 */

      // when(mockAdviceRepository.getAdvice()).thenAnswer((_) async => mockArticle);
      await sut.getArticle();
      expect(sut.advice, 'id: 1,advice: teste,');
    });
  });
}

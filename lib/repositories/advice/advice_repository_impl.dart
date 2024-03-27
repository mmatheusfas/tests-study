import 'package:dio/dio.dart';
import 'package:tests_study/repositories/advice/advice_repository.dart';

class AdviceRepositoryImpl implements AdviceRepository {
  final Dio _dio = Dio();

  @override
  Future<String> getAdvice() async {
    try {
      final Response(:data) = await _dio.get('https://api.adviceslip.com/advice');

      return data;
    } catch (e) {
      throw Exception('It was not possible to get an advice');
    }
  }
}

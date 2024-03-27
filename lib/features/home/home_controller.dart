import 'package:flutter/material.dart';
import 'package:tests_study/models/article.dart';
import 'package:tests_study/repositories/advice/advice_repository.dart';

class HomeController extends ChangeNotifier {
  HomeController(this._adviceRepository);

  final AdviceRepository _adviceRepository;

  late Article _article;
  bool isLoading = false;
  String advice = '';

  Article get article => _article;

  Future<void> getArticle() async {
    changeIsLoading(true);
    try {
      final response = await _adviceRepository.getAdvice();
      advice = response;
      changeIsLoading(false);
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  void changeIsLoading(bool newIsLoading) {
    isLoading = newIsLoading;
    notifyListeners();
  }
}

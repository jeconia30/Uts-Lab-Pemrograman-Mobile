import 'package:flutter/foundation.dart';

import '../data/dummy_questions.dart';
import '../data/question.dart';

/// Menyimpan semua progres kuis. Provider berada di atas MaterialApp,
/// jadi data tidak hilang saat layar diputar atau pindah halaman.
class QuizProvider extends ChangeNotifier {
  String _name = '';
  int _currentIndex = 0;
  List<Question> _questions = List.of(dummyQuestions);
  List<int?> _answers = List.filled(dummyQuestions.length, null);

  String get name => _name;
  int get currentIndex => _currentIndex;
  List<Question> get questions => _questions;
  Question get currentQuestion => _questions[_currentIndex];
  int get total => _questions.length;

  int? get selectedOption => _answers[_currentIndex];
  int? answerAt(int index) => _answers[index];

  bool get isAnswered => selectedOption != null;
  bool get isFirst => _currentIndex == 0;
  bool get isLast => _currentIndex == _questions.length - 1;

  int get correctCount {
    var count = 0;
    for (var i = 0; i < _questions.length; i++) {
      if (_answers[i] == _questions[i].answerIndex) count++;
    }
    return count;
  }

  int get score => total == 0 ? 0 : ((correctCount / total) * 100).round();

  void start(String name) {
    _name = name.trim();
    _questions = List.of(dummyQuestions)..shuffle();
    _answers = List.filled(_questions.length, null);
    _currentIndex = 0;
    notifyListeners();
  }

  void select(int option) {
    _answers[_currentIndex] = option;
    notifyListeners();
  }

  void next() {
    if (!isLast) {
      _currentIndex++;
      notifyListeners();
    }
  }

  void previous() {
    if (!isFirst) {
      _currentIndex--;
      notifyListeners();
    }
  }

  void reset() {
    _name = '';
    _currentIndex = 0;
    _answers = List.filled(_questions.length, null);
    notifyListeners();
  }
}
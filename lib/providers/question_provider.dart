import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mms_interval_learning/controller/SqliteServiceController.dart';
import 'package:mms_interval_learning/model/Question.dart';
import 'package:mms_interval_learning/util/learn_algorithm.dart';

final questionProvider =
    StateNotifierProvider<QuestionsNotifier, List<Question>>(
        (ref) => QuestionsNotifier([]));

class QuestionsNotifier extends StateNotifier<List<Question>> {
  final service = SqliteServiceController();

  QuestionsNotifier(List<Question> state) : super(state);

  Future<void> setQuestionsForTopics(Set<int> topicIds) async {
    final questions = await service.getQuestionsForTopics(topicIds);
    state = [...questions];
  }

  void setQuestionsForTopic(int topicId) async {
    setQuestionsForTopics({topicId});
  }

  void addQuestion(String question, int topicId) async {
    var q = await service.insertQuestion(question, topicId);
    state = [...state, q];
  }

  void updateQuestion(Question question) {
    service.updateQuestion(question);
    state = state..map((e) => e.id == question.id ? question : e);
  }

  void markQuestionAsLearned(Question question, int evaluation) {
    service.insertProgress(question.id!, evaluation.toDouble());
    state = [
      for (final q in state)
        if (q.id != question.id) q
    ];
  }
}

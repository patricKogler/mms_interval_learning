import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mms_interval_learning/controller/SqliteServiceController.dart';
import 'package:mms_interval_learning/model/Question.dart';

final questionProvider =
    StateNotifierProvider<QuestionsNotifier, Set<Question>>(
        (ref) => QuestionsNotifier({}));

class QuestionsNotifier extends StateNotifier<Set<Question>> {
  final service = SqliteServiceController();

  QuestionsNotifier(Set<Question> state) : super(state);

  Future<void> setQuestionsForTopics(Set<int> topicIds) async {
    final questions = await service.getQuestionsForTopics(topicIds);
    state = questions;
  }

  void setQuestionsForTopic(int topicId) async {
    setQuestionsForTopics({topicId});
  }

  void addQuestion(String question, int topicId) async {
    var q = await service.insertQuestion(question, topicId);
    state = {...state, q};
  }

  void updateQuestion(Question question) {
    service.updateQuestion(question);
    state = state.map((e) => e.id == question.id ? question : e).toSet();
  }

  void markQuestionAsLearned(Question question) {
    state = {
      for (final q in state)
        if (q.id != question.id) q
    };
  }
}

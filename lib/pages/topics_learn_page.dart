import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mms_interval_learning/providers/question_provider.dart';
import 'package:mms_interval_learning/widgets/question_view.dart';

import '../model/Question.dart';

class TopicsLearnPage extends ConsumerStatefulWidget {
  final Set<int> topicIds;

  const TopicsLearnPage({Key? key, required this.topicIds}) : super(key: key);

  @override
  _TopicsLearnPageState createState() => _TopicsLearnPageState();
}

class _TopicsLearnPageState extends ConsumerState<TopicsLearnPage> {
  Question? currentQuestion;

  @override
  void initState() {
    super.initState();
    ref.read(questionProvider.notifier).setQuestionsForTopics(widget.topicIds);
  }

  @override
  Widget build(BuildContext context) {
    final watch = ref.watch(questionProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("Learn!"),
      ),
      body: watch.isEmpty
          ? null
          : QuestionView(
              onLearned: () {
                ref
                    .read(questionProvider.notifier)
                    .markQuestionAsLearned(watch.first);
              },
              question: watch.first),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';
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
  FlutterTts flutterTts = FlutterTts();
  bool playing = false;
  Question? currentQuestion;

  @override
  void initState() {
    super.initState();
    ref.read(questionProvider.notifier).setQuestionsForTopics(widget.topicIds);
    flutterTts.setLanguage("de-AT");
  }

  Future _speak(String question) async {
    setState(() => playing = true);
    var result = await flutterTts.speak(question);
    if (result == 1) setState(() => playing = false);
  }

  Future _stop() async {
    var result = await flutterTts.stop();
    if (result == 1) setState(() => playing = false);
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
          : Row(
              children: [
                QuestionView(
                    onLearned: () {
                      ref
                          .read(questionProvider.notifier)
                          .markQuestionAsLearned(watch.first);
                    },
                    question: watch.first),
                TextButton(
                    onPressed: () {
                      if (playing) {
                        _stop();
                      } else {
                        _speak(watch.first.text);
                      }
                    },
                    child: Icon(Icons.play_arrow))
              ],
            ),
    );
  }
}

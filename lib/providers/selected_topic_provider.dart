import 'package:mms_interval_learning/model/Topic.dart';
import 'package:riverpod/riverpod.dart';

final selectedTopicsProvider =
    StateNotifierProvider<SelectedTopicsNotifier, Set<int>>(
        (ref) => SelectedTopicsNotifier(Set.identity()));

class SelectedTopicsNotifier extends StateNotifier<Set<int>> {
  SelectedTopicsNotifier(Set<int> state) : super(state);

  void toggleSelectedTopic(Topic topic) {
    if (state.contains(topic.id)) {
      state = {...state..remove(topic.id)};
    } else {
      state = {...state..add(topic.id!)};
    }
  }
}

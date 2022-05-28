import 'package:mms_interval_learning/controller/SqliteServiceController.dart';
import 'package:mms_interval_learning/model/Lecture.dart';
import 'package:riverpod/riverpod.dart';

final lecturesProvider = StateNotifierProvider((ref) {
  return LecturesNotifier();
});

class LecturesNotifier extends StateNotifier<AsyncValue<List<Lecture>>> {
  final serviceController = SqliteServiceController();

  LecturesNotifier() : super(const AsyncValue.loading()) {
    _init();
  }

  void _init() async {
    state = const AsyncValue.loading();
    final List<Lecture> lectures = await serviceController.getAllLectures();
    state = AsyncValue.data(lectures);
  }

  void addLecture(String lecture) async {
    if (state.hasValue) {
      var insertLecture = await serviceController.insertLecture(lecture);
      state = AsyncValue.data([...state.value ?? [], insertLecture]);
    } else {
      state = const AsyncValue.error("There was an Error");
    }
  }

  void removeLecture(int id) async {
    if (state.hasValue) {
      await serviceController.removeLecture(id);
      state = AsyncValue.data([
        for (final lecture in state.value ?? [])
          if (lecture.id != id) lecture
      ]);
    } else {
      state = const AsyncValue.error("There was an Error");
    }
  }
}

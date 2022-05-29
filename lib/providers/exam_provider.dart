import 'package:mms_interval_learning/controller/SqliteServiceController.dart';
import 'package:mms_interval_learning/model/Exam.dart';
import 'package:mms_interval_learning/model/Lecture.dart';
import 'package:riverpod/riverpod.dart';

final examProvider =
    StateNotifierProvider<ExamNotifier, AsyncValue<List<Exam>>>((ref) {
  return ExamNotifier();
});

class ExamNotifier extends StateNotifier<AsyncValue<List<Exam>>> {
  final serviceController = SqliteServiceController();

  ExamNotifier() : super(const AsyncValue.loading()) {
    _init();
  }

  Future<void> _init() async {
    state = const AsyncValue.loading();
    final List<Exam> exams = await serviceController.getAllExams();
    state = AsyncValue.data(exams);
  }

  void addExam(int lectureId, String examDate) async {
    if (!state.hasValue) {
      await _init();
    }

    if (state.hasValue) {
      var insertExam = await serviceController.insertExam(lectureId, examDate);
      state = AsyncValue.data([...state.value ?? [], insertExam]);
    } else {
      state = const AsyncValue.error("There was an Error");
    }
  }

  void removeExam(int id) async {
    if (state.hasValue) {
      await serviceController.removeExam(id);
      state = AsyncValue.data([
        for (final lecture in state.value ?? [])
          if (lecture.id != id) lecture
      ]);
    } else {
      state = const AsyncValue.error("There was an Error");
    }
  }
}

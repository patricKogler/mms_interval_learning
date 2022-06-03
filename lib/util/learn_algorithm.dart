import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:mms_interval_learning/model/Question.dart';

import '../model/Progress.dart';

class LearnAlgorithm {
  static double getQuestionWeight(
      Question question, List<Progress> progresss, DateTime examDate) {
    DateTime nextLearningDate =
        getEFactorWithDate(question, progresss, examDate).shouldHaveReviewed;

    if (progresss.isEmpty) {
      return 4 + (0.2 * nextLearningDate.difference(DateTime.now()).inDays);
    }

    return progresss.last.evaluation +
        (0.2 * nextLearningDate.difference(DateTime.now()).inDays);
  }

  static double _plusEF(double answerQuality) {
    return 0.1 - (5 - answerQuality) * (0.08 + (5 - answerQuality) * 0.02);
  }

  static double _getEfFromAnswer(
      double oldEf, Progress progress, DateTime shouldHaveReviewedOn) {
    var evaluation = progress.evaluation;
    double plEf = 0;
    if (evaluation >= 4) plEf = _plusEF(0);
    if (evaluation >= 3) plEf = _plusEF(1.67);
    if (evaluation >= 2) {
      plEf = _plusEF(3.34);
    } else {
      plEf = _plusEF(5);
    }

    var answeredAt = DateTime.parse(progress.date);
    double ef = oldEf +
        plEf +
        (shouldHaveReviewedOn.isBefore(answeredAt)
            ? answeredAt.difference(shouldHaveReviewedOn).inDays * 0.05
            : answeredAt.difference(shouldHaveReviewedOn).inDays * 0.02);
    // according to pm 2 otherwise question comes to often
    return ef < 1.3 ? 1.3 : ef;
  }

  static _EFactorWithDate getEFactorWithDate(
      Question question, List<Progress> progresss, DateTime examDate) {
    DateTime firstReview = DateTime.parse(question.createdAt).add(Duration(
        days: _getDaysFromFirstLearn(
            DateTime.now().difference(examDate).inDays)));

    DateTime createdAt = DateTime.parse(question.createdAt);
    return progresss.fold(
        _EFactorWithDate(
            2.5,
            progresss.isNotEmpty
                ? DateTime.parse(progresss.first.date)
                : DateTime.now(),
            createdAt.difference(firstReview).inDays),
        (previousValue, element) {
      int daysFromLast = previousValue.daysFromLast;
      int nextDaysFromLast = min(
          90,
          ((daysFromLast == 0 ? 1 : daysFromLast) * previousValue.eFactor)
              .ceil());
      return _EFactorWithDate(
          _getEfFromAnswer(
              previousValue.eFactor, element, previousValue.shouldHaveReviewed),
          previousValue.shouldHaveReviewed
              .add(Duration(days: nextDaysFromLast)),
          nextDaysFromLast);
    });
  }

  static int _getDaysFromFirstLearn(int daysToExam) {
    if (daysToExam < 7) return 0;
    if (daysToExam < 15) return 2;
    if (daysToExam < 30) return 5;
    if (daysToExam < 60) return 8;
    if (daysToExam < 90) return 14;
    if (daysToExam < 180) {
      return 21;
    } else {
      return 30;
    }
  }
}

@immutable
class _EFactorWithDate {
  final double eFactor;
  final DateTime shouldHaveReviewed;
  final int daysFromLast;

  const _EFactorWithDate(
      this.eFactor, this.shouldHaveReviewed, this.daysFromLast);
}

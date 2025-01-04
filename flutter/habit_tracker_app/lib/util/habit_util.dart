// given a hibit list of completion days
// is the habit completed today
import 'package:habit_tracker_app/models/habit.dart';

bool isHabitCompeletedToday(List<DateTime> completionDays) {
  final today = DateTime.now();

  // check if habit is completed today
  return completionDays.any(
    (day) =>
        day.year == today.year &&
        day.month == today.month &&
        day.day == today.day,
  );
}

// prepare heat map dataset
Map<DateTime, int> prepHeatMapDataset(List<Habit> habits) {
  Map<DateTime, int> datasets = {};

  for (var habit in habits) {
    for (var date in habit.completedDays) {
      // normalize date to avoid time mismatch
      final normalizedDate = DateTime(date.year, date.month, date.day);

      // if the date already exits in the dataset, increment its count
      if (datasets.containsKey(normalizedDate)) {
        datasets[normalizedDate] = datasets[normalizedDate]! + 1;
      } else {
        // else initialize it with a count of 1
        datasets[normalizedDate] = 1;
      }
    }
  }
  return datasets;
}

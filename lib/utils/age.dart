library age;

class AgeDuration {
  int days;
  int months;
  int years;

  AgeDuration({this.days = 0, this.months = 0, this.years = 0});

  String toString() {
    return 'Years: $years, Months: $months, Days: $days';
  }
}

class Age {
  static const List<int> _daysInMonth = [
    31,
    28,
    31,
    30,
    31,
    30,
    31,
    31,
    30,
    31,
    30,
    31
  ];

  static bool isLeapYear(int year) =>
      (year % 4 == 0) && ((year % 100 != 0) || (year % 400 == 0));

  static int daysInMonth(int year, int month) =>
      (month == DateTime.february && isLeapYear(year))
          ? 29
          : _daysInMonth[month - 1];

  static AgeDuration dateDifference(
      {required DateTime fromDate,
      required DateTime toDate,
      bool includeToDate = false}) {
    DateTime endDate = (includeToDate) ? toDate.add(Duration(days: 1)) : toDate;

    int years = endDate.year - fromDate.year;
    int months = 0;
    int days = 0;

    if (fromDate.month > endDate.month) {
      years--;
      months = (DateTime.monthsPerYear + endDate.month - fromDate.month);

      if (fromDate.day > endDate.day) {
        months--;
        days = daysInMonth(fromDate.year + years,
                ((fromDate.month + months - 1) % DateTime.monthsPerYear) + 1) +
            endDate.day -
            fromDate.day;
      } else {
        days = endDate.day - fromDate.day;
      }
    } else if (endDate.month == fromDate.month) {
      if (fromDate.day > endDate.day) {
        years--;
        months = DateTime.monthsPerYear - 1;
        days = daysInMonth(fromDate.year + years,
                ((fromDate.month + months - 1) % DateTime.monthsPerYear) + 1) +
            endDate.day -
            fromDate.day;
      } else {
        days = endDate.day - fromDate.day;
      }
    } else {
      months = (endDate.month - fromDate.month);

      if (fromDate.day > endDate.day) {
        months--;
        days = daysInMonth(fromDate.year + years, (fromDate.month + months)) +
            endDate.day -
            fromDate.day;
      } else {
        days = endDate.day - fromDate.day;
      }
    }

    return AgeDuration(days: days, months: months, years: years);
  }

  static DateTime add({required DateTime date, required AgeDuration duration}) {
    int years = date.year + duration.years;
    years += (date.month + duration.months) ~/ DateTime.monthsPerYear;

    int months = ((date.month + duration.months) % DateTime.monthsPerYear);

    int days = date.day + duration.days - 1;

    return DateTime(years, months, 1).add(Duration(days: days));
  }

  static DateTime subtract(
      {required DateTime date, required AgeDuration duration}) {
    duration.days *= -1;
    duration.months *= -1;
    duration.years *= -1;

    return add(date: date, duration: duration);
  }
}

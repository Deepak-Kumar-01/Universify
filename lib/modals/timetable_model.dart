
class TimetableModal{
  final List<Semester> semesters;
  TimetableModal({required this.semesters});
}


class Semester {
  final String name;
  final List<Day> timetable;

  Semester({required this.name, required this.timetable});
}

class Day {
  final String day;
  final String dname;
  final List<Slot> slots;

  Day({required this.day,required this.dname, required this.slots});
}

class Slot {
  final String faculty;
  final String subCode;
  final String subject;
  final String time;

  Slot({required this.faculty,required this.subCode, required this.subject, required this.time});
}
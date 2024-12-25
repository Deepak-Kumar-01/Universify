class FacultyListModel {
  final String code;
  final String name;
  final String faculty;

  FacultyListModel({
    required this.code,
    required this.name,
    required this.faculty,
  });

  factory FacultyListModel.fromMap(String code, Map<String, dynamic> data) {
    return FacultyListModel(
      code: code,
      name: data['name'] ?? 'Unknown Subject',
      faculty: data['faculty'] ?? 'Unknown Faculty',
    );
  }

  @override
  String toString() {
    return 'Subject(code: $code, name: $name, faculty: $faculty)';
  }
}
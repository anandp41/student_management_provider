class StudentModel {
  final String admno;
  final String name;

  final String age;
  final String classInSchool;
  final String? image64bit;
  StudentModel(
      {required this.admno,
      required this.name,
      required this.age,
      required this.classInSchool,
      required this.image64bit});

  static StudentModel fromMap(Map<String, Object?> map) {
    final dynamic _newImage;
    if (map['image'] == null) {
      _newImage = 'empty';
    } else {
      _newImage = map['image'];
    }

    return StudentModel(
        admno: map['admno'] as String,
        name: map['name'] as String,
        age: map['age'] as String,
        classInSchool: map['class'] as String,
        image64bit: _newImage);
  }
}

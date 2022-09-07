class Person {
  String name;
  String gender;

  Person({required this.gender, required this.name});

  factory Person.fromJson(Map<String, dynamic> json) { // 1
    return Person(
      name: json['name'] as String,
      gender: json['gender'] as String,
    );
  }

  Map<String, dynamic> toJson() { // 2
    return {
      'name': this.name,
      'gender': this.gender,
    };
  }
}
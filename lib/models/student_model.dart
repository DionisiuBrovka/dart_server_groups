class StudentModel {
  int? id;
  String firstName;
  String secondName;
  String thirdName;
  int? group;
  DateTime birthday;

  StudentModel({
    this.id,
    required this.firstName,
    required this.secondName,
    required this.thirdName,
    this.group,
    required this.birthday,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) => StudentModel(
    id: json["id"],
    firstName: json["firstName"],
    secondName: json["secondName"],
    thirdName: json["thirdName"],
    group: json["group"],
    birthday: DateTime.parse(json["birthday"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "firstName": firstName,
    "secondName": secondName,
    "thirdName": thirdName,
    "group": group,
    "birthday": birthday.toString(),
  };

  factory StudentModel.fromDataRaw(List<dynamic> data) {
    return StudentModel(
      id: data[0],
      firstName: data[1],
      secondName: data[2],
      thirdName: data[3],
      group: data[4],
      birthday: data[6],
    );
  }
}

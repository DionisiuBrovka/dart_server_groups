class GroupModel {
  int? id;
  String name;
  int startYear;
  DateTime? createAt;

  GroupModel({
    this.id,
    required this.name,
    required this.startYear,
    this.createAt,
  });

  factory GroupModel.fromJson(Map<String, dynamic> json) => GroupModel(
    id: json["id"],
    name: json["name"],
    startYear: json["startYear"],
    createAt: DateTime.parse(json["createAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "startYear": startYear,
    "createAt": createAt.toString(),
  };

  factory GroupModel.fromDataRaw(List<dynamic> data) {
    return GroupModel(
      id: data[0],
      name: data[1],
      startYear: data[2],
      createAt: data[3],
    );
  }
}

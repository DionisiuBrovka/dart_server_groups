getAllGroupsQuery() =>
    "SELECT id, group_name, start_year, create_at FROM groups_table;";

getGroupByIdQuery(int id) =>
    "SELECT id, group_name, start_year, create_at FROM groups_table WHERE id=$id;";

createGroupQuery(String name, int startYear) =>
    "INSERT INTO groups_table (group_name, start_year) VALUES('$name', $startYear) RETURNING * ;";

updateGroupQuery(int id, String name, int startYear) =>
    "UPDATE groups_table SET group_name='$name', start_year=$startYear WHERE id=$id RETURNING * ;";

deleteGroupQuery(int id) => "DELETE FROM groups_table WHERE id=$id";

getAllStudentsQuery() =>
    "SELECT id, first_name, second_name, third_name, student_group, birthday FROM students_table;";

getStudentByIdQuery(int id) =>
    "SELECT id, first_name, second_name, third_name, student_group, birthday FROM students_table WHERE id=$id;";

getStudentByGroupIdQuery(int id) =>
    "SELECT students_table.id, first_name, second_name, third_name, student_group, groups_table.group_name, birthday  FROM students_table inner join groups_table on groups_table.id=student_group WHERE groups_table.id=$id;";

createStudentQuery(
  String firstName,
  String secondName,
  String thirdName,
  int? groupId,
  String birthday,
) =>
    "INSERT INTO students_table (first_name, second_name, third_name, student_group, birthday) VALUES('$firstName', '$secondName', '$thirdName', $groupId, '$birthday');";

updateStudentQuery(
  int id,
  String firstName,
  String secondName,
  String thirdName,
  int? groupId,
  String birthday,
) =>
    "UPDATE students_table SET first_name='$firstName', second_name='$secondName', third_name='$thirdName', student_group=$groupId, birthday='$birthday' WHERE id=$id;";

deleteStudentQuery(int id) => "DELETE FROM groups_table WHERE id=$id";

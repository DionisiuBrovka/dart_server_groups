getAllGroupsQuery() =>
    "SELECT id, group_name, start_year, create_at FROM groups_table;";

getGroupByIdQuery(int id) =>
    "SELECT id, group_name, start_year, create_at FROM groups_table WHERE id=$id;";

createGroupQuery(String name, int startYear) =>
    "INSERT INTO groups_table (group_name, start_year) VALUES('$name', $startYear) RETURNING * ;";

updateGroupQuery(int id, String name, int startYear) =>
    "UPDATE groups_table SET group_name='$name', start_year=$startYear WHERE id=$id RETURNING * ;";

deleteGroupQuery(int id) => "DELETE FROM groups_table WHERE id=$id";

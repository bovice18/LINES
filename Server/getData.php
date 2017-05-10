<?php include "../inc/dbinfo.inc"; ?>

<?php
$con = mysqli_connect(DB_SERVER, DB_USERNAME, DB_PASSWORD);
if (!$con)
  {
  die('Could not connect: ' . mysql_error());
  }
$database = mysqli_select_db($con, DB_DATABASE);

$result = mysqli_query($con, "SELECT * FROM lines_table_1"); 
$rows = array();
while($query_data = mysqli_fetch_assoc($result)) {
  $rows[] = $query_data;
}
print json_encode($rows);
?>
<?php include "../inc/dbinfo.inc"; ?>
<html>
<body>
<h1>LINES</h1>
<form action="insert.php" method="post">
Location: 
<select name="Location_Name">
  <option value="Chipotle">Chipotle</option>
  <option value="Bentley''s">Bentley's</option>
  <option value="Terrapin Turf">Terrapin Turf</option>
  <option value="Potbelly">Potbelly</option>
  <option value="Cornerstone">Cornerstone</option>
</select><br><br>
Line Rating: <input type="number" name="Line_Rating" maxlength="11" size="2" /><br><br>
Circle Rating: <input type="number" name="Circle_Rating" maxlength="11" size="2" /><br><br>
Comments: <input type="text" name="Comments" maxlength="45" size="45" /><br><br>

<input type="submit" />
</form>
<br><br>
<!-- Display table data. -->
<table border="1" cellpadding="2" cellspacing="2">
  <tr>
    <td>Rating Id</td>
    <td>Location Id</td>
    <td>Location Name</td>
    <td>Line Rating</td>
    <td>Circle Rating</td>
    <td>Comments</td>
    <td>Time String</td>
    <td>Time Date</td>
  </tr>

<?php
$con = mysqli_connect(DB_SERVER, DB_USERNAME, DB_PASSWORD);
if (!$con)
  {
  die('Could not connect: ' . mysql_error());
  }
$database = mysqli_select_db($con, DB_DATABASE);

$result = mysqli_query($con, "SELECT * FROM lines_table_1"); 

while($query_data = mysqli_fetch_row($result)) {
  echo "<tr>";
  echo "<td>",$query_data[0], "</td>",
       "<td>",$query_data[1], "</td>",
       "<td>",$query_data[2], "</td>",
       "<td>",$query_data[3], "</td>",
       "<td>",$query_data[4], "</td>",
       "<td>",$query_data[5], "</td>",
       "<td>",$query_data[6], "</td>",
       "<td>",$query_data[7], "</td>";
  echo "</tr>";
}
?>

</table>
</body>
</html>
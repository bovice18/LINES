<?php include "../inc/dbinfo.inc"; ?>
<html>
<body>
<h1>LINES</h1>
<form action="insert.php" method="post">
Location: 
<select name="Location_Name">
  <option value="Acme">Acme</option>
  <option value="Dock Street">Dock Street</option>
  <option value="McGarveys">McGarveys</option>
  <option value="Pussers">Pussers</option>
  <option value="Armadillos">Armadillos</option>
  <option value="Federal House">Federal House</option>
  <option value="Bentleys">Bentleys</option>
  <option value="Terrapins Turf">Terrapins Turf</option>
  <option value="Cornerstone">Cornerstone</option>
</select><br><br>
Circle Rating: <input type="number" name="Circle_Rating" maxlength="11" size="2" /><br><br>
<input type="submit" />
</form>
<br><br>
<!-- Display table data. -->
<table border="1" cellpadding="2" cellspacing="2">
  <tr>
    <td>Rating Id</td>
    <td>Location Name</td>
    <td>Circle Rating</td>
    <td>Time</td>
  </tr>

<?php
$con = mysqli_connect(DB_SERVER, DB_USERNAME, DB_PASSWORD);
if (!$con)
  {
  die('Could not connect: ' . mysql_error());
  }
$database = mysqli_select_db($con, DB_DATABASE);

$result = mysqli_query($con, "SELECT * FROM lines_table_2"); 

while($query_data = mysqli_fetch_row($result)) {
  echo "<tr>";
  echo "<td>",$query_data[0], "</td>",
       "<td>",$query_data[1], "</td>",
       "<td>",$query_data[2], "</td>",
       "<td>",$query_data[3], "</td>";
  echo "</tr>";
}
?>

</table>
</body>
</html>

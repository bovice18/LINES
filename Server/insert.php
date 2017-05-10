<?php include "../inc/dbinfo.inc"; ?>
<html>
<body>
 
 
<?php
$con = mysqli_connect(DB_SERVER, DB_USERNAME, DB_PASSWORD);
if (!$con)
  {
  die('Could not connect: ' . mysql_error());
  }

switch ($_POST['Location_Name']) {
	case "Chipotle":
		$Location_Id = "1";
		break;
	case "Bentley''s":
		$Location_Id = "2";
		break;
	case "Terrapin Turf":
		$Location_Id = "3";
		break;
	case "Potbelly":
		$Location_Id = "4";
		break;
	case "Cornerstone":
		$Location_Id = "5";
		break;
}
$database = mysqli_select_db($con, DB_DATABASE);
$date = date('Y-m-d H:i:s');
$sql="INSERT INTO lines_table_1 (locationId, locationName, lineRating, circleRating, comments, timeString, timeDate) 
      VALUES ('$Location_Id',
              '$_POST[Location_Name]',
              '$_POST[Line_Rating]',
              '$_POST[Circle_Rating]',
              '$_POST[Comments]',
              '$_POST[Time_String]',
              '$date')";
if (!mysqli_query($con,$sql))
  {
  die('Error: ' . mysqli_error($con));
  }
echo "1 record added";
 
mysql_close($con)
?>
</body>
</html>
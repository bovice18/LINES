<?php include "../inc/dbinfo.inc"; ?>
<html>
<body>
 
 
<?php
$con = mysqli_connect(DB_SERVER, DB_USERNAME, DB_PASSWORD);
if (!$con)
  {
  die('Could not connect: ' . mysql_error());
  }

$database = mysqli_select_db($con, DB_DATABASE);
date_default_timezone_set('US/Eastern');
$date = date('Y-m-d H:i:s');
$sql="INSERT INTO lines_table_2 (locationName, circleRating, timeDate) 
      VALUES ('$_POST[Location_Name]',
              '$_POST[Circle_Rating]',
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

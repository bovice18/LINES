<?php
$city = $_SERVER['QUERY_STRING'];
if ($city) {
    $cmdString = "python ../inc/fetchTest.py $city";
} else {
    $cmdString = "python ../inc/fetchTest.py";
}
$command = escapeshellcmd($cmdString);
$output = shell_exec($command);
print $output;
?>


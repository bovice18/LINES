<?php
$command = escapeshellcmd('python ../inc/fetchLocations.py');
$output = shell_exec($command);
print $output;

?>


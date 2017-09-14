<?php
$command = escapeshellcmd('python ../inc/test.py');
$output = shell_exec($command);
print $output;

?>

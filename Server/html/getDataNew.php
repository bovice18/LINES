
<?php
$command = escapeshellcmd('python ../inc/fetch.py');
$output = shell_exec($command);
print $output;

?>




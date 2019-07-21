<?php
//phpinfo();die;
$files = glob('*');
$cwd = __DIR__;
foreach ($files as $k => $file) {
    $path = $cwd . DIRECTORY_SEPARATOR . $file;

    if (is_dir($path)) {
        echo "<a href='/$file'>$file</a><br />";
    }

}
<?php
require_once 'connectPDO.php';

$sql = "SELECT * FROM todo";
$results = $dbh->query($sql);

echo "[";
foreach ($results as $result) {
    $array = array('todo' => $result['todo'], 'deadline' => $result["deadline"]);
    $json = json_encode($array);
    echo $json.',';
};
echo "]";
<?php
require_once 'config.php';

$database = "todo";
$dsn = 'mysql:host='.$hostName.';dbname='.$database.';charset=utf8';

try { 
    $dbh = new PDO($dsn, $userName, $password);
} catch (PDOException $e) {
      // エラーメッセージを表示させる
  echo 'データベースにアクセスできません！' . $e->getMessage();
  echo '<br>';
  // 強制終了
  exit;
}
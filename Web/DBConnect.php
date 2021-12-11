<?php

final class DBConnect {
    private $connectDb;

    function __construct() {
    }

    // データベース接続
    function connect() {
        require_once dirname(__FILE__).'/config.php';
        $database = "todo";
        $dsn = 'mysql:host='.$hostName.';dbname='.$database.';charset=utf8';
        try { 
            $dbh = new PDO($dsn, $userName, $password);
            $this -> connectDb = $dbh;
            return $this -> connectDb;
        } catch (PDOException $e) {
              // エラーメッセージを表示させる
          echo 'データベースにアクセスできません！' . $e->getMessage();
          echo '<br>';
          // 強制終了
          exit;
        }
    }
}
<?php

final class DBOperation {
    private $connection;

    // イニシャライザのイメージ
    function __construct() {
        require_once dirname(__FILE__).'/DBConnect.php';
        // DBに接続
        $db = new DBConnect();
        $this -> connection = $db->connect();
    }

    // 新しいtodoを作成
    public function saveUser($todo, $deadline) {
        // MySQLのクエリ
        $saveQuery = 'insert into todo(todo, deadline) values ("'.$todo.'", "'.$deadline.'");';
        $insertQuery = $this->connection->prepare($saveQuery);
        $result = $insertQuery -> execute();
        $insertQuery = null;
        return $result;
    }

}

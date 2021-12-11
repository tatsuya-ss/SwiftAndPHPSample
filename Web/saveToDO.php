<?php

$response = array();

if ($_SERVER['REQUEST_METHOD']=='POST') {
    // 値の取得
    $postOfTodo = $_POST['todo'];
    $postOfDeadline = $_POST['deadline'];

    // DBファイルの操作
    require_once dirname(__FILE__).'/DBOperation.php';
    $db = new DBOperation();

    if ($db->saveUser($postOfTodo, $postOfDeadline)) {
        $response['error']=false;
        $response['message']='保存完了';
    } else {
        $response['error']=false;
        $response['message']='保存完了';
    }

} else {
    $response['error'] = true;
    $response['message'] = 'あなたは認証されていません。';
}
echo json_encode($response);
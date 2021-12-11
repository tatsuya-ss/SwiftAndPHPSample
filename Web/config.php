<?php
// 環境変数を読み込むライブラリ
require 'vendor/autoload.php';
$dotenv = Dotenv\Dotenv::createImmutable(__DIR__);
$dotenv->load();

$hostName = $_ENV["HOST_NAME"];
$userName = $_ENV["USER_NAME"];
$password = $_ENV["PASSWORD"];
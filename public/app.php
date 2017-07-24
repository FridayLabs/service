<?php

require_once __DIR__ . '/../vendor/autoload.php';

use Monolog\Logger;
use Monolog\Handler\StreamHandler;

$log = new Logger('name');
$log->pushHandler(new StreamHandler('php://stdout', Logger::INFO));
$log->pushHandler(new StreamHandler('php://stderr', Logger::ERROR));
$log->addInfo('info!');
$log->addError('error!');

echo 'hello world!';

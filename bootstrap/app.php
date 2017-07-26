<?php

require_once __DIR__.'/../vendor/autoload.php';

$workingDir = __DIR__ . '/../';
try {
    (new Dotenv\Dotenv($workingDir))->load();
} catch (Dotenv\Exception\InvalidPathException $e) {
    //
}

$settings = [];
foreach (glob($workingDir . 'config/*.php') as $file) {
    $settings = array_merge_recursive($settings, (array) (require_once $file));
}

$app = new App\Application($settings);

$app->registerService(\App\Service\LoggingServiceProvider::class);
$app->registerService(\App\Service\RenderingServiceProvider::class);
$app->registerService(\App\Service\RoutesServiceProvider::class);

return $app;
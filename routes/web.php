<?php


$app->get('/[{name}]', function ($request, $response, $args) {

    $this->logger->info("Service '/' route");

    return $this->renderer->render($response, 'index.phtml', $args);
});
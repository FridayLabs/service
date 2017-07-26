<?php

if (!function_exists('working_dir')) {
    function working_dir($append = '')
    {
        return realpath(__DIR__  .'/../' . $append);
    }
}
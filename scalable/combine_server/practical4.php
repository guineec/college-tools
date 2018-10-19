<?php

/*
 * This script provides no validation other than checking the values it needs have been sent to it.
 */

const POTFILE_NAME = "practical4.pot";

header('Content-Type: application/json');

// Grab the input from post
$entry = $_POST['entry'];

if(!isset($entry)) {
    http_response_code(400);
    echo json_encode([
       "status" => 400,
       "error" => "Bad Request - no entry sent"
    ]);
    die();
}

// Add it to the file
$potfile_path = POTFILE_NAME;
if(file_put_contents($potfile_path, "$entry\n", FILE_APPEND)) {
    http_response_code(200);
    echo json_encode([
        "status" => 200,
        "message" => "entry added"
    ]);
}

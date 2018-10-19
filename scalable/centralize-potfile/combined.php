<?php

/*
 * This script provides no validation other than checking the values it needs have been sent to it.
 */

const POTFILE_NAME = "combined.pot";

header('Content-Type: application/json');

// Grab the input from post
$entry = trim($_POST['entry']);

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
$potfile_contents = file_get_contents($potfile_path);

if(strpos($potfile_contents, $entry) === false) {
    if (file_put_contents($potfile_path, "$entry\n", FILE_APPEND)) {
        http_response_code(200);
        echo json_encode([
            "status" => 200,
            "message" => "entry added"
        ]);
    } else {
        http_response_code(500);
        echo json_encode([
            "status" => 500,
            "error" => "Server error - couldn't add entry to file."
        ]);
    }
} else {
    http_response_code(303);
    echo json_encode([
        "status" => 303,
        "message" => "See Other - Entry already in potfile."
    ]);
}

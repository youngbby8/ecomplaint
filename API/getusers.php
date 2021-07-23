<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
require 'connection.php';

$sql = "SELECT * FROM e_login";

$stmt = $conn->prepare($sql);

$stmt->execute();

//CHECK WHETHER THERE IS ANY POST IN OUR DATABASE
if($stmt->rowCount() > 0){
    // CREATE POSTS ARRAY
    $response = array();
    $response['user'] = array();
    
    while($row = $stmt->fetch(PDO::FETCH_ASSOC)){
        array_push($response['user'], $row);  
     }

    //SHOW POST/POSTS IN JSON FORMAT
    $response['message'] = true;
    echo json_encode($response);
 

}
else{
    //IF THER IS NO POST IN OUR DATABASE
    echo json_encode(['message'=>'No data found']);
}
?>
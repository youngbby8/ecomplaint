<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
require 'connection.php';

$sql = "SELECT * FROM e_institution";
$sql2 = "SELECT * FROM e_category";

$stmt = $conn->prepare($sql);
$stmt2 = $conn->prepare($sql2);

$stmt->execute();
$stmt2->execute();

//CHECK WHETHER THERE IS ANY POST IN OUR DATABASE
if($stmt->rowCount() > 0){
    // CREATE POSTS ARRAY
    $response = array();
    $response['cat'] = array();
    $response['inst'] = array();
    
    while($row = $stmt->fetch(PDO::FETCH_ASSOC)){
        array_push($response['inst'], $row ['instname']);  
     }


     while($row = $stmt2->fetch(PDO::FETCH_ASSOC)){
        array_push($response['cat'], $row ['cat_name']);     
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
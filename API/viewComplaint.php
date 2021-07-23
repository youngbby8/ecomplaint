<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
require 'connection.php';
$sql = "select institution,cat_name,status,date,description,image from e_complaint inne join e_category using (cat_id)";

$stmt = $conn->prepare($sql);

$stmt->execute();

//CHECK WHETHER THERE IS ANY POST IN OUR DATABASE
if($stmt->rowCount() > 0){
    // CREATE POSTS ARRAY
    $response = array();
    
    while($row = $stmt->fetch(PDO::FETCH_ASSOC)){
        
        array_push($response,[
            'Institution'=> $row ['institution'],
            'Category'=> $row ['cat_name'],
            'Status'=> $row ['status'],
            'Date'=> $row ['date'],
            'Description' => $row ['description']
            'Image'=> $row ['image'],
        ]);
         
     }
    //SHOW POST/POSTS IN JSON FORMAT
    echo json_encode($response);
 

}
else{
    //IF THER IS NO POST IN OUR DATABASE
    echo json_encode(['message'=>'No data found']);
}
?>
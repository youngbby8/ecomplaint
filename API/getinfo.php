<?php
// SET HEADER
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: access");
header("Access-Control-Allow-Methods: POST");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

// INCLUDING DATABASE AND MAKING OBJECT
require 'connection.php';

// GET DATA FORM REQUEST
// $data = json_decode(file_get_contents("php://input"), true);
// 


//CREATE MESSAGE ARRAY AND SET EMPTY
$msg['message'] = '';


// CHECK IF RECEIVED DATA FROM THE REQUEST
if(isset($_GET["email"])){
    // CHECK DATA VALUE IS EMPTY OR NOT
    $name = $_GET["email"];

    try{
        $insert_query = "SELECT * FROM e_login WHERE email = :name";
        
        $insert_stmt = $conn->prepare($insert_query);
         
       
        // DATA BINDING
        $insert_stmt->bindParam(':name',$name, PDO::PARAM_STR);
        
        
        if($insert_stmt->execute()){
            $row = $insert_stmt->fetch();
            $msg['message'] = true;
            $msg['data'] = $row;
           
        }else{
            $msg['message'] = false;
        } 
    }
    catch(PDOException $msg){
        echo $msg;
    }
}else{
    $msg['message'] = 'Please fill all the fields';
}
//ECHO DATA IN JSON FORMAT
echo  json_encode($msg);
?>

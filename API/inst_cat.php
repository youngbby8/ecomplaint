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
if(isset($_GET["ready"])){
    // CHECK DATA VALUE IS EMPTY OR NOT
    $info = array();
    
    try{
        $insert_query = "SELECT * FROM e_category, e_institution";
        
        $insert_stmt = $conn->prepare($insert_query);
         
       
        // DATA BINDING
        //$insert_stmt->bindParam(':name',$name, PDO::PARAM_STR);
        
        
        if($insert_stmt->execute()){
            $info["cat"] = array();
            $info["inst"] = array();
            while($x = $insert_stmt->fetch()){
                array_push($info["cat"], $x["cat_name"]);
                array_push($info["inst"], $x["instname"]);
                
            }
            $msg['message'] = true;
            $msg['data'] = $info;
           
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

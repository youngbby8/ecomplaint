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
if(isset($_POST["Institution"]) && isset($_POST["Category"]) && isset($_POST["Comp_address"]) && isset($_POST["Description"]) && isset($_POST["name"])){
    // CHECK DATA VALUE IS EMPTY OR NOT
    $Institution = $_POST["Institution"];
    $Category = $_POST["Category"];
    $Comp_address = $_POST["Comp_address"];
    $Description = $_POST["Description"];
    $name = $_POST["name"];
    $date = date("Y-m-d h:i:s");
    try{
        $insert_query = "INSERT INTO `e_complaint`(institution,category,comp_address,description,customer,date,status) VALUES(:institution,:cat_name,:comp_address,:description,:name,:date,'pending')";
        
        $insert_stmt = $conn->prepare($insert_query);
         
       
        // DATA BINDING
        $insert_stmt->bindParam(':institution',$Institution, PDO::PARAM_STR);
        $insert_stmt->bindParam(':cat_name',$Category , PDO::PARAM_STR);
        $insert_stmt->bindParam(':comp_address',$Comp_address, PDO::PARAM_STR);
        $insert_stmt->bindParam(':description',$Description, PDO::PARAM_STR);
        $insert_stmt->bindParam(':date',$date, PDO::PARAM_STR);
        $insert_stmt->bindParam(':name',$name, PDO::PARAM_STR);


        
        
        if($insert_stmt->execute()){
            
            $msg['message'] = true;
           
        }else{
            $msg['message'] = false;
        } 
    }
    catch(PDOException $msg){
        $msg['message'] = false;
        $msg['error'] = $msg;
    }
}
else{
    $msg['message'] = false;
    $msg['error'] = "Please fill all the fields";
}
//ECHO DATA IN JSON FORMAT
echo  json_encode($msg);
?>

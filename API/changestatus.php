<?php
// SET HEADER
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: access");
header("Access-Control-Allow-Methods: POST");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

// INCLUDING DATABASE AND MAKING OBJECT
require 'connection.php';

//CREATE MESSAGE ARRAY AND SET EMPTY
$msg['message'] = '';
//$data = json_decode(file_get_contents("php://input"));

// CHECK IF RECEIVED DATA FROM THE REQUEST
if(isset($_POST['status']) && isset($_POST['id'])){
    $status = $_POST['status'];
    $id = $_POST['id'];
    // CHECK DATA VALUE IS EMPTY OR NOT
    try{

        if(isset($_POST['to'])){
            $to = $_POST['to'];
            $insert_query = "UPDATE e_complaint SET status = '$status',technician = '$to' WHERE comp_id = '$id'";
        }else{
            $insert_query = "UPDATE e_complaint SET status = '$status' WHERE comp_id = '$id'";
        }
        
        
        $insert_stmt = $conn->prepare($insert_query);
         
       
        // DATA BINDING
        // $insert_stmt->bindValue(':status',$status ,PDO::PARAM_STR);
        // $insert_stmt->bindValue(':id',$id ,PDO::PARAM_STR);
        // echo json_encode($data);
       // $insert_stmt->execute();
        if($insert_stmt->execute()){
            $msg['message'] = true;
            $msg['read'] = "the comp with id $id is set to $status";
        }else{
            $msg['message'] = false;
        } 
    }
    catch(PDOException $msg){
        $msg['read'] = $msg;
    }
  
}
else{
    $msg['message'] = 'Please fill all the fields ';
}
//ECHO DATA IN JSON FORMAT
echo  json_encode($msg);
?>

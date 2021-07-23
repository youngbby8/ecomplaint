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
if(isset($_POST['table']) && isset($_POST['id'])){
    $tab = $_POST['table'];
    $id = $_POST['id'];

    // CHECK DATA VALUE IS EMPTY OR NOT
    try{
        $insert_query = "DELETE FROM $tab WHERE id = :id ";
        
        $insert_stmt = $conn->prepare($insert_query);
         
       
        // DATA BINDING
        $insert_stmt->bindValue(':id',$id ,PDO::PARAM_STR);
        //$insert_stmt->bindValue(':tab',$tab ,PDO::PARAM_STR);
        // echo json_encode($data);
        

        if($insert_stmt->execute()){
    
            $msg['message'] = true;
            $msg['status'] = 200; 
           
        }else{
            $msg['message'] = false;
            $msg['info'] = "failed to delete";
            $msg['status'] = 403;
        } 
    }
    catch(PDOException $msg){
        echo $msg;
    }
  
}
else{
    $msg['message'] = 'requirnment required';
}
//ECHO DATA IN JSON FORMAT
echo  json_encode($msg);
?>

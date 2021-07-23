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
if(isset($_POST['Email']) && isset($_POST['Password'])){
    $email = $_POST['Email'];
    $password = $_POST['Password'];

    // CHECK DATA VALUE IS EMPTY OR NOT
    try{
        $insert_query = "SELECT * FROM  `e_login` WHERE email=:email and password=:password";
        
        $insert_stmt = $conn->prepare($insert_query);
         
       
        // DATA BINDING
        $insert_stmt->bindValue(':email',$email ,PDO::PARAM_STR);
        $insert_stmt->bindValue(':password',$password ,PDO::PARAM_STR);
        // echo json_encode($data);
        $insert_stmt->execute();
        if($insert_stmt->rowCount()){
            
            $row = $insert_stmt->fetch();
            $msg['message'] = true;
            $msg['role'] = $row["role"];
            $msg['name'] = $row["full_name"];
            $msg['status'] = 200; 
           
        }else{
            $msg['message'] = false;
            $msg['info'] = "incorrect username or password";
            $msg['status'] = 403;
        } 
    }
    catch(PDOException $msg){
        echo $msg;
    }
  
}
else{
    $msg['message'] = 'Please fill all the fields ';
}
//ECHO DATA IN JSON FORMAT
echo  json_encode($msg);
?>

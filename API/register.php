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
if(isset($_POST["Fullname"]) && isset($_POST["Address"]) && isset($_POST["Phoneno"]) && isset($_POST["Email"]) && isset($_POST["Password"])){
    // CHECK DATA VALUE IS EMPTY OR NOT
    $fullname = $_POST["Fullname"];
    $address = $_POST["Address"];
    $phone = $_POST["Phoneno"];
    $email = $_POST["Email"];
    $password = $_POST["Password"];
    try{
        $insert_query = "INSERT INTO `e_login`(full_name,address,phone_no,email,password,role) VALUES(:Fullname,:address,:phone,:email,:password,'customer')";
        
        $insert_stmt = $conn->prepare($insert_query);
         
       
        // DATA BINDING
        $insert_stmt->bindParam(':Fullname',$fullname, PDO::PARAM_STR);
        $insert_stmt->bindParam(':address',$address , PDO::PARAM_STR);
        $insert_stmt->bindParam(':phone',$phone, PDO::PARAM_STR);
        $insert_stmt->bindParam(':email',$email, PDO::PARAM_STR);
        $insert_stmt->bindParam(':password',$password, PDO::PARAM_STR);
        
        
        if($insert_stmt->execute()){
            
            $msg['message'] = true;
           
        }else{
            $msg['message'] = false;
        } 
    }
    catch(PDOException $msg){
        echo $msg;
    }
}else if(isset($_POST["name"]) && isset($_POST["Address"]) && isset($_POST["Phoneno"]) && isset($_POST["Email"]) && isset($_POST["Password"]) && isset($_POST["role"])){
    // CHECK DATA VALUE IS EMPTY OR NOT
    $fullname = $_POST["name"];
    $address = $_POST["Address"];
    $phone = $_POST["Phoneno"];
    $email = $_POST["Email"];
    $password = $_POST["Password"];
    $role = $_POST["role"];
    try{
        $insert_query = "INSERT INTO `e_login`(full_name,address,phone_no,email,password,role) VALUES(:Fullname,:address,:phone,:email,:password,:role)";
        
        $insert_stmt = $conn->prepare($insert_query);
         
       
        // DATA BINDING
        $insert_stmt->bindParam(':Fullname',$fullname, PDO::PARAM_STR);
        $insert_stmt->bindParam(':address',$address , PDO::PARAM_STR);
        $insert_stmt->bindParam(':phone',$phone, PDO::PARAM_STR);
        $insert_stmt->bindParam(':email',$email, PDO::PARAM_STR);
        $insert_stmt->bindParam(':password',$password, PDO::PARAM_STR);
        $insert_stmt->bindParam(':role',$role, PDO::PARAM_STR);
        
        
        if($insert_stmt->execute()){
            
            $msg['message'] = true;
           
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

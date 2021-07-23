<?php
     $db_host = 'localhost';
     $db_name = 'e_complaint';
     $db_username = 'root';
     $db_password= '';

    try{
        $complain='mysql:host='.$db_host.';dbname='.$db_name;
        $conn=new PDO($complain,$db_username,$db_password);
        //echo json_encode(['message'=>'connection successful']);
    }
    catch (PDOException $error){
        $error->getMessage();
        echo $error;
    }
 
   


?>
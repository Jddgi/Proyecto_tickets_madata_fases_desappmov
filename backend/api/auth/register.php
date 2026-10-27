<?php
require dirname(__DIR__).'/config/database.php';
if ($_SERVER['REQUEST_METHOD']!=='POST') respond(['success'=>false,'message'=>'Método no permitido'],405);
$d=jsonInput();
foreach(['name','email','password','phone','company'] as $f) if(empty(trim((string)($d[$f]??'')))) respond(['success'=>false,'message'=>'Debe completar todos los campos requeridos'],422);
if(!filter_var($d['email'],FILTER_VALIDATE_EMAIL)) respond(['success'=>false,'message'=>'Correo inválido'],422);
if(strlen($d['password'])<8) respond(['success'=>false,'message'=>'La contraseña debe tener al menos 8 caracteres'],422);
try{
 $q=db()->prepare('INSERT INTO users(name,email,password_hash,phone,company) VALUES(?,?,?,?,?)');
 $q->execute([$d['name'],strtolower($d['email']),password_hash($d['password'],PASSWORD_DEFAULT),$d['phone'],$d['company']]);
 respond(['success'=>true,'message'=>'Cuenta creada correctamente','token'=>null,'user'=>null],201);
}catch(PDOException $e){ if($e->getCode()==='23000') respond(['success'=>false,'message'=>'El correo electrónico ya se encuentra registrado en el sistema'],409); throw $e; }

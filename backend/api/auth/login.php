<?php
require dirname(__DIR__).'/config/database.php';
if ($_SERVER['REQUEST_METHOD']!=='POST') respond(['success'=>false,'message'=>'Método no permitido'],405);
$d=jsonInput(); $q=db()->prepare('SELECT id,name,email,password_hash,company FROM users WHERE email=?'); $q->execute([strtolower(trim($d['email']??''))]); $u=$q->fetch();
if(!$u || !password_verify($d['password']??'', $u['password_hash'])) respond(['success'=>false,'message'=>'Correo o contraseña incorrectos','token'=>null,'user'=>null],401);
unset($u['password_hash']); respond(['success'=>true,'message'=>'Acceso correcto','token'=>bin2hex(random_bytes(24)),'user'=>$u]);

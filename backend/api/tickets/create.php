<?php
require dirname(__DIR__).'/config/database.php';
if($_SERVER['REQUEST_METHOD']!=='POST') respond(['success'=>false,'message'=>'Método no permitido'],405);
$d=jsonInput(); if(empty($d['user_id'])||empty(trim($d['title']??''))||empty(trim($d['details']??''))) respond(['success'=>false,'message'=>'Debe completar todos los campos requeridos'],422);
$p=$d['priority']??'media'; if(!in_array($p,['baja','media','alta','critica'],true)) respond(['success'=>false,'message'=>'Prioridad inválida'],422);
$q=db()->prepare('INSERT INTO tickets(user_id,title,details,priority,status) VALUES(?,?,?,?,"abierto")');$q->execute([(int)$d['user_id'],$d['title'],$d['details'],$p]);respond(['success'=>true,'message'=>'Ticket creado correctamente','id'=>(int)db()->lastInsertId()],201);

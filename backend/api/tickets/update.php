<?php
require dirname(__DIR__).'/config/database.php';
if($_SERVER['REQUEST_METHOD']!=='PATCH') respond(['success'=>false,'message'=>'Método no permitido'],405);
$d=jsonInput();$states=['abierto','en_proceso','resuelto','cerrado'];if(empty($d['id'])||!in_array($d['status']??'', $states,true)) respond(['success'=>false,'message'=>'Datos inválidos'],422);
$q=db()->prepare('UPDATE tickets SET status=? WHERE id=?');$q->execute([$d['status'],(int)$d['id']]);respond(['success'=>true,'message'=>'Ticket actualizado']);

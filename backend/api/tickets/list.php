<?php
require dirname(__DIR__).'/config/database.php';
$uid=(int)($_GET['user_id']??0); if($uid<1) respond(['success'=>false,'data'=>[],'message'=>'Usuario inválido'],422);
$q=db()->prepare('SELECT id,title,details,priority,status,DATE_FORMAT(created_at,"%Y-%m-%d %H:%i:%s") created_at FROM tickets WHERE user_id=? ORDER BY id DESC');$q->execute([$uid]);respond(['success'=>true,'data'=>$q->fetchAll(),'message'=>null]);

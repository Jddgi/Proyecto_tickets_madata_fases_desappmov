<?php
require dirname(__DIR__).'/config/database.php';
$uid=(int)($_GET['user_id']??0);$q=db()->prepare('SELECT s.id,s.name,s.details,s.status,DATE_FORMAT(s.valid_until,"%Y-%m-%d") valid_until FROM services s JOIN user_services us ON us.service_id=s.id WHERE us.user_id=? ORDER BY s.name');$q->execute([$uid]);respond(['success'=>true,'data'=>$q->fetchAll(),'message'=>null]);

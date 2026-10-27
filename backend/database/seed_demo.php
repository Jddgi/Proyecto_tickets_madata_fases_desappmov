<?php
require dirname(__DIR__).'/api/config/database.php';
$pdo=db();
$email='demo@madata.mx';
$q=$pdo->prepare('SELECT id FROM users WHERE email=?');$q->execute([$email]);$id=$q->fetchColumn();
if(!$id){$q=$pdo->prepare('INSERT INTO users(name,email,password_hash,phone,company) VALUES(?,?,?,?,?)');$q->execute(['Usuario Demo',$email,password_hash('Demo1234!',PASSWORD_DEFAULT),'5555555555','Cliente Demo MADATA']);$id=(int)$pdo->lastInsertId();}
$pdo->prepare('INSERT IGNORE INTO user_services(user_id,service_id) SELECT ?,id FROM services')->execute([$id]);
$pdo->prepare('INSERT INTO tickets(user_id,title,details,priority,status) SELECT ?,?,?,?,? WHERE NOT EXISTS(SELECT 1 FROM tickets WHERE user_id=?)')->execute([$id,'Validar respaldo','Confirmar ejecución del respaldo nocturno','media','abierto',$id]);
echo "Usuario demo listo: demo@madata.mx / Demo1234!\n";

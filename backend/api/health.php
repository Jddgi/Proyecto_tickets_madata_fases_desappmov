<?php
require __DIR__.'/config/database.php';
try { db()->query('SELECT 1'); respond(['success'=>true,'message'=>'API MADATA operativa']); }
catch(Throwable $e){ respond(['success'=>false,'message'=>'No hay conexión con la base de datos'],500); }

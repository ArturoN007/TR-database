<?php
$claveUsuario = "SENATI";
$claveHASH = password_hash($claveUsuario, PASSWORD_BCRYPT);

$claveAcceso = "SENATI";

if (password_verify($claveAcceso,$claveHASH)){
  echo "Acceso correcto";
  echo "{$claveHASH}";
}
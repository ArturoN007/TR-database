<?php
session_start();
if (isset($_SESSION['login']) && $_SESSION['login']){
  header('Location:views/index.php');
}
?>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="./views/css/sesion.css">
  <title>Bienvenido</title>
</head>
<body>

  <div class="container">
    <h1>Login</h1>
    <form>
      <label for="usuario">Nombre de Usuario:</label>
      <input type="text" id="usuario" name="usuario" required>
      <label for="clave">Contraseña:</label>
      <input type="password" id="clave" name="clave" required>
      <input type="submit" id="iniciar-sesion" value="Login">
    </form>
  </div>










<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>

<script>
  $(document).ready(function (){

    function iniciarSesion(){
      const usuario = $("#usuario").val();
      const clave = $("#clave").val();

      if (usuario != "" && clave != ""){
        $.ajax({
          url: 'controllers/usuario.controller.php',
          type: 'POST',
          data: {
            operacion     : 'login',
            usuario : usuario,
            claveIngresada: clave
          },
          dataType: 'JSON',
          success: function (result){
            console.log(result);
            if (result["status"]){
              window.location.href = "views/index.php";
            }else{
              alert(result["mensaje"]);
            }
          }
        });
      }
    }

    $("#iniciar-sesion").click(iniciarSesion);

  })
</script>

</body>
</html>
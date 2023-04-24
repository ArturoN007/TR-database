  <?php

require_once '../models/Estudiante.php';

if(isset($_POST['operacion'])){

  $estudiante = new Estudiante();

  if($_POST['operacion'] == 'registrar'){

    //Paso 1: recolectar todos los valores enviadoes
    //por la vista y almacenarlos en un array asociativo
    $datosGuardar = [
      "apellidos"       => $_POST['apellidos'],
      "nombres"         => $_POST['nombres'],
      "tipodocumento"   => $_POST['tipodocumento'],
      "nrodocumento"    => $_POST['nrodocumento'],
      "fechanacimiento" => $_POST['fechanacimiento'],
      "idcarrera"       => $_POST['idcarrera'],
      "idsede"          => $_POST['idsede'],
      "fotografia"      => ''
    ];

    //vamos a verificcar si la vista envio una Fotografia
    if(isset($_FILES['fotografia'])){

      $rutaDestino = '../views/img/fotografias/';
      $fechaActual=date('c'); // c = complete, ano/mes/dia/hora/minuto/segundo
      $nombreArchivo = sha1($fechaActual) . ".jpg";
      $rutaDestino .= $nombreArchivo;

      //Guardamos la fotografia en el servidor
      if(move_uploaded_file($_FILES['fotografia']['tmp_name'], $rutaDestino)){
        $datosGuardar['fotografia'] = $nombreArchivo;
      }

    }

    // Paso 2: Enviar el array al metodo registrar
    $estudiante->registrarEstudiante($datosGuardar);


  }

  if($_POST['operacion'] == 'listar'){

    $datosObtenidos = $estudiante->listarEstudiante();

    
    if($datosObtenidos){
      $nfilas =1;
      $datosEstudiante = '';
      $botonNulo = "<a href='#' class='btn btn-sm btn-warning' title='No Tiene fotografia'><i class='bi bi-eye-slash-fill'></i></a>";


      foreach($datosObtenidos as $registro){
        $datosEstudiante = $registro['apellidos'].' '.$registro['nombres'];
       

        //La primera parte a renderizar, es lo estandar (siempre lo muestra)

        echo"
        <tr>
        <td>{$nfilas}</td>
        <td>{$registro['apellidos']}</td>
        <td>{$registro['nombres']}</td>  
        <td>{$registro['tipodocumento']}</td>
        <td>{$registro['nrodocumento']}</td>
        <td>{$registro['fechanacimiento']}</td>
        <td>{$registro['carrera']}</td>
        <td>
           <a href='#' data-idestudiante='{$registro['idestudiante']}' class='btn btn-danger btn-sm eliminar'><i class='bi bi-trash3'></i></a>
           <a href='#' data-idestudiante='{$registro['idestudiante']}' class='btn btn-info btn-sm editar'><i class='bi bi-pencil-fill'></i></a>";

        // la suegunda parate a RENDERIZAR, es el boton ver fotografia

        if($registro['fotografia']==''){
          echo $botonNulo;
        }else{
          echo "<a href='../views/img/fotografias/{$registro['fotografia']}' data-lightbox=registro'{$registro['idestudiante']}' data-title='{$datosEstudiante}' class='btn btn-warning btn-sm editar'><i class='bi bi-eye-fill'></i></i></a>";
        }

        // La tercera parte a renderizar seria el cierre de la fila   
        echo"
          </td>
         </tr>
        ";
        $nfilas++;
      }
    }
  }

}
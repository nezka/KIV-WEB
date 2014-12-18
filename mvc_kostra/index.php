<?php

session_start();

require_once './libs/Twig/Autoloader.php';
require_once './model/Model.php';

Twig_Autoloader::register();
$loader = new Twig_Loader_Filesystem('templates');
$twig = new Twig_Environment($loader);

if ($handle = opendir('templates')) {
    while (false !== ($entry = readdir($handle))) {
        if ($entry != "." || $entry != "..") {
            $povolene[] = strtolower(substr($entry, 0, -5));
        }
    }
    closedir($handle);
}

$model = new Model();

if (isset($_GET['page'])) {
    $page = $_GET['page'];
} else {
    $page = "homepage";
}
$sablona = $page . ".twig";
$data['page'] = $page;

if (isset($_SESSION['user'])) {
    $data['user'] = $_SESSION['user'];
} else {
    $data['user'] = null;
}

if (isset($_GET['logout'])) {
    unset($_SESSION['user']);
    $_SESSION['hlaska'] = "Byl jste odhlasen";
    header("Location: index.php");
}

if (isset($_POST['log'])) {
    $log = $_POST['login'];
    $admin = $model->loginUser($log);
    if (!$admin) {
        $_SESSION['hlaska'] = "Zadane udaje jsou neplatne";
    } else {
        $_SESSION['user'] = $admin;
    }
    header("Location: index.php");
}

     if (isset($_GET['upravit']) && $data['user'] != null) {
        $data['a'] = $_GET['a']; 
        $data['b'] = $_GET['b'];
        if (isset($_GET['c'])){
            $data['c'] = $_GET['c'];  
        }
        $data['id'] = $_GET['upravit'];
        $data['u'] = $_GET['stranka'];
    
    if (isset($_POST['uprav']) && $data['user'] != null) {
        
        $id = $data['id'];
        $d = $_POST['upr'];
        
        if ($data['u'] == "rozhodci") {
            $model->upravRozhodciho($id, $d);
            header("Location:index.php?page=rozhodci");
            unset($data['u']);
        }
        if ($data['u'] == "vystavovatele") {
            var_dump($id)  ;
            $model->upravVystavovatele($id, $d);
            header("Location:index.php?page=vystavovatele");
            unset($data['u']);
        }
        if ($data['u'] == "psi") {
            $model->upravPsa($id, $d);
            header("Location:index.php?page=psi");
            unset($data['u']);
        }
        
        
        $_SESSION['hlaska'] = "Úprava byla provedena!";
    }
}

if ($page === "vystavovatele") {
   if (isset($_GET['smazat']) && $data['user'] != null) {
        $id_vyst = $_GET['smazat'];
        $model->smazVystavovatele($id_vyst);
        header("Location:index.php?page=vystavovatele");
        $_SESSION['hlaska'] = "Byl smazán vystavovatel!";
    }
}

 

if ($page === "rozhodci") {
   if (isset($_GET['smazat']) && $data['user'] != null) {
        $id_rozh = $_GET['smazat'];
        $model->smazRozhodciho($id_rozh);
        header("Location:index.php?page=rozhodci");
        $_SESSION['hlaska'] = "Byl smazán rozhodčí!";
    }
    
     if (isset($_GET['upravit']) && $data['user'] != null) {
        $data['id'] = $_GET['upravit'];
        $data['u'] = "rozhodci";
        $page = "uprava";
    }
}

 if ($page === "psi") {
   if (isset($_GET['smazat']) && $data['user'] != null) {
        $id_pes = $_GET['smazat'];
        $model->smazPsa($id_pes);
        header("Location:index.php?page=psi");
        $_SESSION['hlaska'] = "Byl smazán pes!";
    }
    
    if (isset($_GET['upravit']) && $data['user'] != null) {
        $data['id'] = $_GET['upravit'];
        $data['u'] = "psi";
        $page = "uprava";
    }
 }

if ($page == "vystavovatele") {
    $data['vystavovatele'] = $model->getAllVystavovatele();
}

if ($page === "rozhodci") {
    $data['rozhodci'] = $model->getAllRozhodci();
}

if ($page === "psi") {
    $data['psi'] = $model->getAllPsy();
}

if ($page === "novyrozhodci") {
    
    if (isset($_POST['rozhod'])) {
        $d = $_POST['rozhod'];
        $model->pridejRozhodciho($d);
        $_SESSION['hlaska'] = "Byl přidán rozhodčí!";
    }
}

if ($page === "registrace") {

    if (isset($_POST['registrace'])) {
        $d = $_POST['reg'];

        //if ($d['heslo'] != $d['heslo2']) {
            //$_SESSION['hlaska'] = "Hesla se neshoduji";
       // } else if (false) {
            //todo..nejsou prazdne pole
       // } else {
            //unset($d['heslo2']);
            $model->registruj($d);
            $_SESSION['hlaska'] = "Registrace proběhla úspěšně!";
            //unset($_SESSION['hlaska']);
        //}
    }
}

if (!in_array($page, $povolene)) {
    $sablona = "404.twig";
}

if (isset($_SESSION['hlaska'])) {
    $data['hlaska'] = $_SESSION['hlaska'];
}

$template = $twig->loadTemplate($sablona);
echo $template->render($data);
unset($_SESSION['hlaska']);




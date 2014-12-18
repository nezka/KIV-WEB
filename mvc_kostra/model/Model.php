<?php

require_once './model/MainModel.php';

class Model extends MainModel {

    public function getAllVystavovatele() {
        return $this->DBSelectAll("anezkaj_vystavovatel", "*", array());
    }
    
    
    public function getAllRozhodci() {
        return $this->DBSelectAll("anezkaj_rozhodci", "*", array());
    }
    
    public function getAllPsy() {
        return $this->DBSelectAll("anezkaj_pes", "*", array());
    }
    
    public function pridejRozhodciho(array $data) {
         $stmt = $this->connection->prepare("INSERT INTO anezkaj_rozhodci VALUES (NULL, :jmeno, :prijmeni)");
            $stmt->bindParam(":jmeno", $data['jmeno'], PDO::PARAM_STR);
            $stmt->bindParam(":prijmeni", $data['prijmeni'], PDO::PARAM_STR);
            //$stmt->bindParam(":email", $data['kruh'], PDO::PARAM_STR);
            $stmt->execute();
    }
    
    public function pridejKruh($id_roz, $id_kruh) {
         $stmt = $this->connection->prepare("INSERT INTO anezkaj_posuzuje VALUES (:id_roz, :id_kruh)");
         $stmt->bindParam(":id_roz", $id_roz, PDO::PARAM_STR);
         $stmt->bindParam(":prijmeni", $id_kruh, PDO::PARAM_STR);
         $stmt->execute();
    }
    
    public function smazRozhodciho($id) {
        $stmt = $this->connection->prepare("DELETE FROM anezkaj_rozhodci WHERE id_rozhodci=:id");
        $stmt->bindParam(":id", $id, PDO::PARAM_INT);
        $stmt->execute();
      
    }
    
    public function smazPsa($id) {
        $stmt = $this->connection->prepare("DELETE FROM anezkaj_pes WHERE id_pes=:id");
        $stmt->bindParam(":id", $id, PDO::PARAM_INT);
        $stmt->execute();
      
    }

    public function smazVystavovatele($id) {
        $stmt = $this->connection->prepare("DELETE FROM anezkaj_vystavovatel WHERE id_vystavovatel=:id");
        $stmt->bindParam(":id", $id, PDO::PARAM_INT);
        $stmt->execute();
    }
    
    
     public function upravVystavovatele($id, $data) {
        $stmt = $this->connection->prepare("UPDATE anezkaj_vystavovatel SET jmeno_vystavovatel=:jmeno, prijmeni_vystavovatelcol=:prijmeni, email_vystavovatel=:email WHERE id_vystavovatel=:id");
        $stmt->bindParam(":id", $id, PDO::PARAM_STR);
        $stmt->bindParam(":jmeno", $data['jmeno'], PDO::PARAM_STR);
        $stmt->bindParam(":prijmeni", $data['prijmeni'], PDO::PARAM_STR);
        $stmt->bindParam(":email", $data['email'], PDO::PARAM_STR);
        $stmt->execute();
    }
    
    
     public function upravRozhodciho($id, $data) {
        $stmt = $this->connection->prepare("UPDATE anezkaj_rozhodci SET jmeno_rozhodci=:jmeno, prijmeni_rozhodcicol=:prijmeni WHERE id_rozhodci=:id");
        $stmt->bindParam(":id", $id, PDO::PARAM_STR);
        $stmt->bindParam(":jmeno", $data['jmeno'], PDO::PARAM_STR);
        $stmt->bindParam(":prijmeni", $data['prijmeni'], PDO::PARAM_STR);
        pridejKruh($id, $data['kruh']);
        //$stmt->bindParam(":email", $data['email'], PDO::PARAM_STR);
        $stmt->execute();
    }
    
     public function upravPsa($id, $data) {
        $stmt = $this->connection->prepare("UPDATE anezkaj_pes SET jmeno_pes=:jmeno, trida=:trida, pohlavi=:pohl WHERE id_pes=:id");
        $stmt->bindParam(":id", $id, PDO::PARAM_STR);
        $stmt->bindParam(":jmeno", $data['pes'], PDO::PARAM_STR);
        $stmt->bindParam(":trida", $data['trida'], PDO::PARAM_STR);
        $stmt->bindParam(":pohl", $data['pohl'], PDO::PARAM_STR);
        $stmt->execute();
    }
    
    public function loginUser(array $data) {
        $user = $data['login'];
        if ($data['login'] == "admin" && $data['password'] == "admin") {
            return true;
        }
        return false;
    }
    
    public function registruj(array $reg) {
        $stmt = $this->connection->prepare("SELECT id_vystavovatel FROM anezkaj_vystavovatel WHERE email_vystavovatel = :email");
        $stmt->bindParam(":email", $reg['email'], PDO::PARAM_STR);
        $stmt->execute();
        $vyst_id = $stmt->fetch();
        
        if($vyst_id['id_vystavovatel'] == NULL) {
            $stmt = $this->connection->prepare("INSERT INTO anezkaj_vystavovatel VALUES (NULL, :jmeno, :prijmeni, :email)");
            $stmt->bindParam(":jmeno", $reg['jmeno'], PDO::PARAM_STR);
            $stmt->bindParam(":prijmeni", $reg['prijmeni'], PDO::PARAM_STR);
            $stmt->bindParam(":email", $reg['email'], PDO::PARAM_STR);
            $stmt->execute();
            
            $stmt = $this->connection->prepare("SELECT id_vystavovatel FROM anezkaj_vystavovatel WHERE email_vystavovatel = :email");
            $stmt->bindParam(":email", $reg['email'], PDO::PARAM_STR);
            $stmt->execute();
            $vyst_id = $stmt->fetch();
        }
        $plemeno = 3;
         $stmt = $this->connection->prepare("INSERT INTO anezkaj_pes VALUES (NULL, :jmen, :pohl, :trida, :vyst, :plemeno)");
            $stmt->bindParam(":jmen", $reg['pes'], PDO::PARAM_STR);
            $stmt->bindParam(":pohl", $reg['pohl'], PDO::PARAM_STR);            
            $stmt->bindParam(":trida", $reg['trida'], PDO::PARAM_STR);
            $stmt->bindParam(":vyst", $vyst_id['id_vystavovatel'], PDO::PARAM_STR);
            $stmt->bindParam(":plemeno", $plemeno, PDO::PARAM_STR);
            $stmt->execute();
      
                
    }

}

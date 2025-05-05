<?php
require_once '../src/db.php';

class Cliente {
    public static function obtenerTodos() {
        $db = conectar();
        return $db->query('SELECT * FROM Agencia')->fetchAll(PDO::FETCH_ASSOC);
    }

    public static function agregar($nombre, $calle, $numero, $id_ciudad) {
        $db = conectar();
        $stmt = $db->prepare('INSERT INTO Agencia (nombre, calle, numero, id_ciudad) VALUES (?, ?, ?, ?)');
        return $stmt->execute([$nombre, $calle, $numero, $id_ciudad]);
    }

    public static function eliminar($id) {
        $db = conectar();
        $stmt = $db->prepare('DELETE FROM Agencia WHERE id_agencia = ?');
        return $stmt->execute([$id]);
    }

    public static function obtenerPorId($id) {
        $db = conectar();
        $stmt = $db->prepare('SELECT * FROM Agencia WHERE id_agencia = ?');
        $stmt->execute([$id]);
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    public static function actualizar($id_agencia, $nombre, $calle, $numero, $id_ciudad) {
        $db = conectar();
        $stmt = $db->prepare('UPDATE Cliente SET nombre=?, calle=?, numero=?, id_ciudad=? WHERE id_cliente=?');
        return $stmt->execute([$nombre, $calle, $numero, $id_ciudad, $id_agencia]);
    }
}
?>
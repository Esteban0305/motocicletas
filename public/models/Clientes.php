<?php
require_once '../src/db.php';

class Cliente {
    public static function obtenerTodos() {
        $db = conectar();
        return $db->query('SELECT * FROM Cliente')->fetchAll(PDO::FETCH_ASSOC);
    }

    public static function agregar($dni, $nombre, $apellido1, $apellido2, $direccion, $id_ciudad, $telefono) {
        $db = conectar();
        $stmt = $db->prepare('INSERT INTO Cliente (dni, nombre, apellido1, apellido2, direccion, id_ciudad, telefono) VALUES (?, ?, ?, ?, ?, ?, ?)');
        return $stmt->execute([$dni, $nombre, $apellido1, $apellido2, $direccion, $id_ciudad, $telefono]);
    }

    public static function eliminar($id) {
        $db = conectar();
        $stmt = $db->prepare('DELETE FROM Cliente WHERE id_cliente = ?');
        return $stmt->execute([$id]);
    }

    public static function obtenerPorId($id) {
        $db = conectar();
        $stmt = $db->prepare('SELECT * FROM Cliente WHERE id_cliente = ?');
        $stmt->execute([$id]);
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    public static function actualizar($id, $dni, $nombre, $apellido1, $apellido2, $direccion, $id_ciudad, $telefono) {
        $db = conectar();
        $stmt = $db->prepare('UPDATE Cliente SET dni=?, nombre=?, apellido1=?, apellido2=?, direccion=?, id_ciudad=?, telefono=? WHERE id_cliente=?');
        return $stmt->execute([$dni, $nombre, $apellido1, $apellido2, $direccion, $id_ciudad, $telefono, $id]);
    }
}
?>
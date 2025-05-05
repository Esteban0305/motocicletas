<?php
function conectar() {
    return new PDO('sqlite:./database.sqlite');
}
?>
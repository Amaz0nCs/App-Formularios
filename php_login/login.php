<?php
header("Content-Type: application/json");

// Configuración de la base de datos
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "controlvehiculos";

// Conectar con la base de datos
$conn = new mysqli($servername, $username, $password, $dbname);

// Verificar la conexión
if ($conn->connect_error) {
    echo json_encode([
        "success" => false, 
        "message" => "Error en la conexión a la base de datos: " . $conn->connect_error
    ]);
    exit();
}

$data = json_decode(file_get_contents("php://input"), true);

if (!isset($data["username"]) || !isset($data["password"])) {
    echo json_encode([
        "success" => false, 
        "message" => "Datos incompletos: falta el nombre de usuario o la contraseña"
    ]);
    exit();
}

$username = $conn->real_escape_string($data["username"]);
$password = $conn->real_escape_string($data["password"]);

$sql = "SELECT * FROM usuario WHERE Username = '$username' AND Password = '$password'";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    $user = $result->fetch_assoc();
    $rut = $user['Rut'];

    // Realizar la consulta JOIN para obtener patente, supervisor y jornada
    $query_additional = "
        SELECT v.Patente, s.Nombre AS Supervisor, r.Jornada 
        FROM registrouso r
        JOIN vehiculo v ON r.ID_Vehiculo = v.Patente
        JOIN supervisor s ON r.ID_Area = s.ID_Area
        WHERE r.ID_Usuario = '$rut'
        ORDER BY r.Fecha DESC, r.Hora DESC
        LIMIT 1
    ";

    $result_additional = $conn->query($query_additional);

    if ($result_additional) {
        if ($result_additional->num_rows > 0) {
            $additional_info = $result_additional->fetch_assoc();
            echo json_encode([
                "success" => true, 
                "user" => $user,
                "patente" => $additional_info['Patente'],
                "supervisor" => $additional_info['Supervisor'],
                "jornada" => $additional_info['Jornada']
            ]);
        } else {
            echo json_encode([
                "success" => false, 
                "message" => "Datos adicionales no encontrados"
            ]);
        }
    } else {
        echo json_encode([
            "success" => false, 
            "message" => "Error en la consulta de datos adicionales"
        ]);
    }
} else {
    echo json_encode([
        "success" => false, 
        "message" => "Credenciales inválidas"
    ]);
}

$conn->close();
?>

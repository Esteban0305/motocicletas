-- Tabla de ciudades
CREATE TABLE Ciudad (
    id_ciudad INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT NOT NULL,
    codigo_postal TEXT NOT NULL,
    provincia TEXT NOT NULL,
    num_habitantes INTEGER NOT NULL
);

-- Tabla de garajes
CREATE TABLE Garaje (
    id_garaje INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT NOT NULL,
    calle TEXT NOT NULL,
    numero TEXT NOT NULL,
    id_ciudad INTEGER NOT NULL,
    FOREIGN KEY (id_ciudad) REFERENCES Ciudad(id_ciudad),
    UNIQUE(calle, numero, id_ciudad) -- No puede haber misma dirección en una misma ciudad
);

-- Tabla de agencias
CREATE TABLE Agencia (
    id_agencia INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT NOT NULL UNIQUE,
    calle TEXT NOT NULL,
    numero TEXT NOT NULL,
    id_ciudad INTEGER NOT NULL,
    telefonos TEXT NOT NULL,
    FOREIGN KEY (id_ciudad) REFERENCES Ciudad(id_ciudad)
);

-- Tabla de motocicletas
CREATE TABLE Motocicleta (
    matricula TEXT PRIMARY KEY,
    num_bastidor TEXT NOT NULL UNIQUE,
    color TEXT NOT NULL,
    marca TEXT NOT NULL,
    modelo TEXT NOT NULL,
    id_agencia INTEGER NOT NULL,
    FOREIGN KEY (id_agencia) REFERENCES Agencia(id_agencia)
);

-- Tabla de ubicación de motocicletas en garajes
CREATE TABLE MotocicletaEnGaraje (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    matricula TEXT NOT NULL,
    id_garaje INTEGER NOT NULL,
    fecha_entrada DATE NOT NULL,
    FOREIGN KEY (matricula) REFERENCES Motocicleta(matricula),
    FOREIGN KEY (id_garaje) REFERENCES Garaje(id_garaje)
);

-- Tabla de clientes
CREATE TABLE Cliente (
    id_cliente INTEGER PRIMARY KEY AUTOINCREMENT,
    dni TEXT NOT NULL UNIQUE,
    nombre TEXT NOT NULL,
    apellido1 TEXT NOT NULL,
    apellido2 TEXT,
    direccion TEXT NOT NULL,
    id_ciudad INTEGER NOT NULL,
    telefono TEXT NOT NULL,
    FOREIGN KEY (id_ciudad) REFERENCES Ciudad(id_ciudad)
);

-- Tabla de reservas
CREATE TABLE Reserva (
    id_reserva INTEGER PRIMARY KEY AUTOINCREMENT,
    id_cliente INTEGER NOT NULL,
    matricula TEXT NOT NULL,
    id_agencia INTEGER NOT NULL,
    precio REAL NOT NULL,
    pagado BOOLEAN NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    fecha_reserva DATE NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
    FOREIGN KEY (matricula) REFERENCES Motocicleta(matricula),
    FOREIGN KEY (id_agencia) REFERENCES Agencia(id_agencia)
);

-- Restricción: un cliente no puede tener reservas simultáneas activas
CREATE UNIQUE INDEX idx_reserva_cliente_unica
ON Reserva(id_cliente)
WHERE fecha_inicio <= date('now') AND fecha_fin >= date('now');

-- CreateTable
CREATE TABLE `archivo_licencia` (
    `id_archivo` INTEGER NOT NULL AUTO_INCREMENT,
    `ruta_pin` TEXT NOT NULL,
    `ruta_pdf` TEXT NOT NULL,
    `id_asignacion` INTEGER NOT NULL,

    INDEX `id_asignacion`(`id_asignacion`),
    PRIMARY KEY (`id_archivo`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `asesores` (
    `id_asesor` INTEGER NOT NULL AUTO_INCREMENT,
    `nombre` VARCHAR(70) NOT NULL,
    `nombre_empresa` VARCHAR(70) NOT NULL,
    `pais` VARCHAR(30) NOT NULL,
    `ciudad` VARCHAR(30) NOT NULL,
    `prefijo` VARCHAR(10) NOT NULL,
    `numero` VARCHAR(30) NOT NULL,
    `cod_postal` INTEGER NOT NULL,
    `id_fiscal` VARCHAR(30) NOT NULL,
    `persona_contacto` VARCHAR(70) NOT NULL,
    `direccion_fiscal` VARCHAR(200) NOT NULL,
    `direccion_envio` VARCHAR(200) NOT NULL,
    `id_distribuidor` INTEGER NULL,
    `id_subdistribuidor` INTEGER NULL,
    `id_usuario` INTEGER NOT NULL,
    `permitirEditar` BOOLEAN NOT NULL DEFAULT false,

    INDEX `id_distribuidor`(`id_distribuidor`),
    INDEX `id_distribuidor_2`(`id_distribuidor`),
    INDEX `id_subdistribuidor`(`id_subdistribuidor`),
    INDEX `id_usuario`(`id_usuario`),
    INDEX `id_usuario_2`(`id_usuario`),
    PRIMARY KEY (`id_asesor`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `asignacion_licencias` (
    `id_asignacion` INTEGER NOT NULL AUTO_INCREMENT,
    `producto` VARCHAR(200) NOT NULL,
    `licencia` VARCHAR(200) NOT NULL,
    `status` BOOLEAN NOT NULL,
    `grupo` INTEGER NOT NULL,
    `id_usuario` INTEGER NOT NULL,
    `fecha_asignacion` TIMESTAMP(0) NULL,
    `tipo_documento` INTEGER NULL,
    `documento` VARCHAR(50) NULL,
    `fecha_emision_doc` DATE NULL,
    `pais` VARCHAR(50) NOT NULL,
    `cod_producto` VARCHAR(50) NOT NULL,
    `fecha_personalizada_en_espera` DATE NULL,
    `fecha_personalizada_asignada` DATE NULL,
    `detalle` TEXT NULL,

    INDEX `id_usuario`(`id_usuario`),
    PRIMARY KEY (`id_asignacion`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `atencion_actividad` (
    `id_atencion` INTEGER NOT NULL AUTO_INCREMENT,
    `fecha_atencion` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `status` TINYINT NOT NULL,
    `pospuesta` INTEGER NOT NULL,
    `fecha_pos` TIMESTAMP(0) NULL,
    `tipo_atencion` TINYINT NOT NULL,
    `id_actividad` INTEGER NOT NULL,
    `id_cliente` INTEGER NOT NULL,
    `id_asesor` INTEGER NOT NULL,

    INDEX `id_actividad`(`id_actividad`),
    INDEX `id_asesor`(`id_asesor`),
    INDEX `id_cliente`(`id_cliente`),
    PRIMARY KEY (`id_atencion`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `cartas_forma_libre_cliente_final` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `ruta_archivo` VARCHAR(500) NOT NULL,
    `id_cliente_final` INTEGER NOT NULL,

    INDEX `fk_carta_cliente_final`(`id_cliente_final`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ciudades` (
    `idCiudades` INTEGER NOT NULL AUTO_INCREMENT,
    `Paises_Codigo` VARCHAR(2) NOT NULL,
    `Ciudad` VARCHAR(100) NOT NULL,
    `latitud` DECIMAL(10, 8) NULL,
    `longitud` DECIMAL(11, 8) NULL,

    INDEX `Ciudad`(`Ciudad`),
    INDEX `Paises_Codigo`(`Paises_Codigo`),
    PRIMARY KEY (`idCiudades`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `clasificacion_acta` (
    `id_clasificacion` INTEGER NOT NULL AUTO_INCREMENT,
    `descripcion` TEXT NOT NULL,
    `fecha` DATE NOT NULL,
    `id_usuario` INTEGER NULL,

    INDEX `id_usuario`(`id_usuario`),
    PRIMARY KEY (`id_clasificacion`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `cliente` (
    `id_cliente` INTEGER NOT NULL AUTO_INCREMENT,
    `nombre` VARCHAR(70) NOT NULL,
    `nombre_empresa` VARCHAR(70) NOT NULL,
    `pais` VARCHAR(30) NOT NULL,
    `ciudad` VARCHAR(30) NOT NULL,
    `numero_contacto` VARCHAR(20) NOT NULL,
    `rama` VARCHAR(40) NOT NULL,
    `id_facebook` INTEGER NULL,
    `id_escala` INTEGER NOT NULL,
    `id_usuario` INTEGER NOT NULL,

    INDEX `id_escala`(`id_escala`),
    INDEX `id_facebook`(`id_facebook`),
    INDEX `id_usuario`(`id_usuario`),
    PRIMARY KEY (`id_cliente`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `cliente_final` (
    `id_cliente_final` INTEGER NOT NULL AUTO_INCREMENT,
    `nombre` VARCHAR(70) NOT NULL,
    `nombre_empresa` VARCHAR(70) NOT NULL,
    `pais` VARCHAR(30) NOT NULL,
    `ciudad` VARCHAR(30) NOT NULL,
    `prefijo` VARCHAR(5) NOT NULL,
    `numero_telefono` VARCHAR(30) NOT NULL,
    `numero_celular` VARCHAR(30) NOT NULL,
    `id_fiscal` VARCHAR(20) NOT NULL,
    `pagina` VARCHAR(30) NOT NULL,
    `correo` VARCHAR(70) NOT NULL,
    `direccion` VARCHAR(200) NOT NULL,
    `id_distribuidor` INTEGER NULL,
    `id_subdistribuidor` INTEGER NULL,
    `id_usuario` INTEGER NULL,
    `id_objeto_empresa` INTEGER NULL,
    `id_software_anterior` INTEGER NULL,
    `es_contribuyente_especial` TINYINT NULL,

    INDEX `id_distribuidor`(`id_distribuidor`),
    INDEX `id_distribuidor_2`(`id_distribuidor`),
    INDEX `id_objeto_empresa`(`id_objeto_empresa`),
    INDEX `id_software_anterior`(`id_software_anterior`),
    INDEX `id_software_anterior_2`(`id_software_anterior`),
    INDEX `id_subdistribuidor`(`id_subdistribuidor`),
    INDEX `id_usuario`(`id_usuario`),
    FULLTEXT INDEX `idx_busqueda`(`nombre`, `nombre_empresa`, `id_fiscal`),
    PRIMARY KEY (`id_cliente_final`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `clienteprecio` (
    `grupo` VARCHAR(12) NOT NULL,
    `empresa` VARCHAR(12) NOT NULL,
    `sucursal` VARCHAR(12) NOT NULL,
    `cliente` VARCHAR(12) NOT NULL,
    `tipoprecio` VARCHAR(12) NOT NULL,
    `estatus` CHAR(2) NOT NULL,
    `predeterminado` INTEGER NOT NULL
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `completardatos_usuario` (
    `id_completar` INTEGER NOT NULL AUTO_INCREMENT,
    `facebook` TEXT NOT NULL,
    `twitter` TEXT NOT NULL,
    `instagram` TEXT NOT NULL,
    `correo_alternativo` TEXT NOT NULL,
    `numero_alternativo` INTEGER NOT NULL,
    `aviso` TINYINT NOT NULL,
    `titulo1` VARCHAR(70) NULL,
    `resena1` TEXT NULL,
    `titulo2` VARCHAR(70) NULL,
    `resena2` TEXT NULL,
    `id_usuario` INTEGER NOT NULL,

    INDEX `id_usuario`(`id_usuario`),
    PRIMARY KEY (`id_completar`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `concepto_acta` (
    `id_concepto` INTEGER NOT NULL AUTO_INCREMENT,
    `descripcion` TEXT NOT NULL,
    `fecha` DATE NOT NULL,
    `id_usuario` INTEGER NULL,

    INDEX `id_usuario`(`id_usuario`),
    PRIMARY KEY (`id_concepto`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `condiciones_acta` (
    `id_condicion` INTEGER NOT NULL AUTO_INCREMENT,
    `condiciones` TEXT NOT NULL,
    `id_usuario` INTEGER NOT NULL,

    INDEX `id_usuario`(`id_usuario`),
    PRIMARY KEY (`id_condicion`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `configsidebar` (
    `id_config` INTEGER NOT NULL AUTO_INCREMENT,
    `dataColorActive` VARCHAR(7) NOT NULL,
    `imgBackground` VARCHAR(5) NOT NULL,
    `rutaImgBackground` TEXT NOT NULL,
    `dataBackground` VARCHAR(7) NOT NULL,
    `sidebarMini` VARCHAR(5) NOT NULL,
    `id_usuario` INTEGER NULL,

    INDEX `id_usuario`(`id_usuario`),
    PRIMARY KEY (`id_config`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `configuracion` (
    `grupo` VARCHAR(12) NULL,
    `empresa` VARCHAR(12) NOT NULL,
    `sucursal` VARCHAR(12) NOT NULL,
    `opcion` VARCHAR(20) NOT NULL,
    `apuntador` VARCHAR(20) NULL,
    `descripcion` VARCHAR(300) NULL,
    `estatus` VARCHAR(2) NULL
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `deposito` (
    `grupo` VARCHAR(12) NULL,
    `empresa` VARCHAR(12) NOT NULL,
    `sucursal` VARCHAR(12) NOT NULL,
    `deposito` VARCHAR(12) NOT NULL,
    `nombre` VARCHAR(200) NULL,
    `tipo` VARCHAR(3) NOT NULL,
    `estatus` CHAR(1) NULL DEFAULT 'A'
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `detalle_actividad` (
    `id_detalle_actividad` INTEGER NOT NULL AUTO_INCREMENT,
    `fecha_detalle` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `fecha_inicio` TIMESTAMP(0) NULL,
    `fecha_fin` TIMESTAMP(0) NULL,
    `id_acta` INTEGER NOT NULL,
    `acta_inicial` INTEGER NULL,
    `acta_final` INTEGER NULL,
    `status` TINYINT NOT NULL,
    `id_actividad` INTEGER NOT NULL,
    `id_usuario` INTEGER NOT NULL,
    `id_cliente` INTEGER NOT NULL,

    INDEX `id_acta`(`acta_inicial`),
    INDEX `id_acta_final`(`acta_final`),
    INDEX `id_acta_general`(`id_acta`),
    INDEX `id_actividad`(`id_actividad`),
    INDEX `id_asesor`(`id_usuario`),
    PRIMARY KEY (`id_detalle_actividad`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `distribuidores` (
    `id_distribuidor` INTEGER NOT NULL AUTO_INCREMENT,
    `nombre` VARCHAR(50) NOT NULL,
    `nombre_empresa` VARCHAR(70) NOT NULL,
    `pais` VARCHAR(50) NOT NULL,
    `ciudad` VARCHAR(50) NOT NULL,
    `prefijo` VARCHAR(5) NOT NULL,
    `numero_contacto` VARCHAR(20) NOT NULL,
    `cod_postal` VARCHAR(5) NOT NULL,
    `id_fiscal` VARCHAR(20) NOT NULL,
    `persona_contacto` VARCHAR(50) NOT NULL,
    `direccion_fiscal` TEXT NOT NULL,
    `direccion_envio` TEXT NOT NULL,
    `acreditado` BOOLEAN NOT NULL DEFAULT false,
    `id_escala` INTEGER NOT NULL,
    `id_usuario` INTEGER NOT NULL,

    UNIQUE INDEX `id_fiscal`(`id_fiscal`),
    INDEX `id_precio_escala`(`id_escala`),
    INDEX `id_usuario`(`id_usuario`),
    FULLTEXT INDEX `nombre`(`nombre`, `nombre_empresa`, `id_fiscal`),
    PRIMARY KEY (`id_distribuidor`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `empresa` (
    `grupo` VARCHAR(12) NULL,
    `empresa` VARCHAR(12) NOT NULL,
    `nombre` VARCHAR(200) NULL,
    `rif` VARCHAR(12) NULL,
    `diasevaluacion` INTEGER NULL,
    `fechainicio` DATE NULL,
    `fechafinal` DATE NULL,
    `estatus` CHAR(1) NULL
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `escalas` (
    `id_escala` INTEGER NOT NULL AUTO_INCREMENT,
    `nombre` VARCHAR(70) NOT NULL,
    `cantidad_desde` INTEGER NOT NULL,
    `cantidad_hasta` INTEGER NOT NULL,
    `id_lista` INTEGER NOT NULL,

    INDEX `id_lista`(`id_lista`),
    PRIMARY KEY (`id_escala`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `grupo` (
    `grupo` VARCHAR(12) NOT NULL,
    `nombre` VARCHAR(200) NULL,
    `estatus` CHAR(1) NULL
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `hybrid_coins` (
    `id_hc` INTEGER NOT NULL AUTO_INCREMENT,
    `serial` VARCHAR(30) NOT NULL,
    `grupo` INTEGER NOT NULL,
    `status` BOOLEAN NOT NULL,
    `tipo_documento` TINYINT NOT NULL,
    `documento` VARCHAR(20) NOT NULL,
    `fecha_emision_doc` DATE NOT NULL,
    `created_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `id_usuario` INTEGER NOT NULL,

    INDEX `grupo_solicitud`(`grupo`),
    INDEX `id_usuario`(`id_usuario`),
    PRIMARY KEY (`id_hc`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `impresoras_clientes` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `cantidad` INTEGER NOT NULL,
    `actualizada` TINYINT NOT NULL DEFAULT 0,
    `id_impresora_marca` INTEGER NOT NULL,
    `id_cliente` INTEGER NOT NULL,

    INDEX `id_cliente`(`id_cliente`),
    INDEX `id_impresora_marca`(`id_impresora_marca`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `impresoras_marcas` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `descripcion` VARCHAR(150) NOT NULL,

    UNIQUE INDEX `descripcion`(`descripcion`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `impuesto` (
    `grupo` VARCHAR(12) NOT NULL,
    `empresa` VARCHAR(12) NOT NULL,
    `sucursal` VARCHAR(12) NOT NULL,
    `impuesto` VARCHAR(12) NOT NULL,
    `descripcion` VARCHAR(200) NOT NULL,
    `texto` VARCHAR(50) NOT NULL,
    `porcentaje` DOUBLE NOT NULL,
    `estatus` CHAR(2) NOT NULL
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `insiteusuariosutils` (
    `USUARIO` CHAR(80) NOT NULL,
    `CLAVE` CHAR(10) NOT NULL,
    `STATUS` INTEGER NULL,
    `ULTFECHA` DATETIME(0) NULL,
    `ULTIP` VARCHAR(30) NULL
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `instaladores` (
    `id_instalador` INTEGER NOT NULL AUTO_INCREMENT,
    `titulo` VARCHAR(255) NOT NULL,
    `descripcion` TEXT NOT NULL,
    `fecha_registro` DATE NOT NULL,
    `ruta` VARCHAR(255) NOT NULL,
    `id_producto` INTEGER NOT NULL,

    INDEX `id_producto`(`id_producto`),
    PRIMARY KEY (`id_instalador`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ipmsoft` (
    `Dominio` VARCHAR(255) NOT NULL,
    `IP` VARCHAR(20) NOT NULL,
    `IdSec` VARCHAR(255) NOT NULL
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `lista_escala` (
    `id_listaescala` INTEGER NOT NULL AUTO_INCREMENT,
    `nombre_lista` VARCHAR(50) NOT NULL,
    `escala` TINYINT NOT NULL,
    `id_lista` INTEGER NOT NULL,

    INDEX `id_lista`(`id_lista`),
    PRIMARY KEY (`id_listaescala`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `lista_precios` (
    `id_lista` INTEGER NOT NULL AUTO_INCREMENT,
    `nombre` VARCHAR(50) NOT NULL,
    `vigencia_actual` VARCHAR(12) NOT NULL,
    `vigencia_anterior` VARCHAR(12) NOT NULL,

    PRIMARY KEY (`id_lista`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `lista_producto` (
    `id_listaproducto` INTEGER NOT NULL AUTO_INCREMENT,
    `cod_producto` VARCHAR(20) NOT NULL,
    `nombre_producto` VARCHAR(100) NOT NULL,
    `_id` INTEGER NOT NULL,
    `id_lista` INTEGER NULL,

    UNIQUE INDEX `cod_producto`(`cod_producto`),
    UNIQUE INDEX `_id`(`_id`),
    INDEX `id_lista`(`id_lista`),
    PRIMARY KEY (`id_listaproducto`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `listas` (
    `id_lista` INTEGER NOT NULL AUTO_INCREMENT,
    `nombre_lista` VARCHAR(100) NOT NULL,
    `fecha_hora` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),

    PRIMARY KEY (`id_lista`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `manuales` (
    `id_manual` INTEGER NOT NULL AUTO_INCREMENT,
    `titulo` VARCHAR(255) NOT NULL,
    `descripcion` TEXT NOT NULL,
    `fecha_registro` DATE NOT NULL,
    `ruta` VARCHAR(255) NOT NULL,
    `id_producto` INTEGER NOT NULL,

    INDEX `id_producto`(`id_producto`),
    PRIMARY KEY (`id_manual`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `menu` (
    `id_menu` INTEGER NOT NULL AUTO_INCREMENT,
    `descripcion` VARCHAR(255) NOT NULL,
    `fecha_creacion` DATE NOT NULL,

    PRIMARY KEY (`id_menu`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `objetos_empresas` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nombre` VARCHAR(30) NOT NULL,
    `descripcion` VARCHAR(100) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `pais` (
    `id` SMALLINT NOT NULL,
    `iso2` CHAR(2) NOT NULL,
    `iso3` CHAR(3) NOT NULL,
    `prefijo` SMALLINT UNSIGNED NOT NULL,
    `nombre` VARCHAR(100) NOT NULL,
    `continente` VARCHAR(16) NULL,
    `subcontinente` VARCHAR(32) NULL,
    `iso_moneda` VARCHAR(3) NULL,
    `nombre_moneda` VARCHAR(100) NULL,

    UNIQUE INDEX `iso2`(`iso2`),
    UNIQUE INDEX `iso3`(`iso3`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `paises` (
    `Codigo` VARCHAR(2) NOT NULL,
    `Pais` VARCHAR(100) NOT NULL,

    PRIMARY KEY (`Codigo`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `personalizacion` (
    `id_personalizacion` INTEGER NOT NULL AUTO_INCREMENT,
    `grupo` INTEGER NOT NULL,
    `id_usuario` INTEGER NOT NULL,
    `id_cliente` INTEGER NOT NULL,
    `id_asignacion` INTEGER NOT NULL,
    `fecha_hora` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `user` VARCHAR(255) NULL,
    `password` VARCHAR(255) NULL,
    `userAdmin` VARCHAR(255) NULL,
    `passwordAdmin` VARCHAR(255) NULL,

    INDEX `id_asignacion`(`id_asignacion`),
    PRIMARY KEY (`id_personalizacion`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `precios_escalas` (
    `id_precio_escala` INTEGER NOT NULL AUTO_INCREMENT,
    `monto_sin_iva` DECIMAL(10, 0) NOT NULL,
    `iva` DECIMAL(10, 0) NOT NULL,
    `monto_iva` DECIMAL(10, 0) NOT NULL,
    `monto_total` DECIMAL(10, 0) NOT NULL,
    `id_escala` INTEGER NOT NULL,

    INDEX `id_escala`(`id_escala`),
    PRIMARY KEY (`id_precio_escala`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `producto` (
    `grupo` VARCHAR(12) NULL,
    `empresa` VARCHAR(12) NOT NULL,
    `sucursal` VARCHAR(12) NOT NULL,
    `producto` VARCHAR(30) NOT NULL,
    `nombre` VARCHAR(200) NULL,
    `existencia` DOUBLE NULL DEFAULT 0.00,
    `existenciaanterior` DOUBLE NULL DEFAULT 0.00,
    `costopromedio` DOUBLE NULL DEFAULT 0.00,
    `costopromedioanterior` DOUBLE NULL DEFAULT 0.00,
    `exento` INTEGER NULL DEFAULT 0,
    `departamento` VARCHAR(30) NOT NULL,
    `clasificacion` INTEGER NOT NULL DEFAULT 1,
    `estatus` CHAR(1) NULL DEFAULT 'A',
    `tipoproducto` INTEGER NOT NULL,
    `referencia` VARCHAR(80) NULL,
    `_id` INTEGER NOT NULL AUTO_INCREMENT,
    `prefijo` VARCHAR(5) NOT NULL DEFAULT '02',
    `longitud` TINYINT NOT NULL DEFAULT 8,

    INDEX `BUSPRODUCTO`(`grupo`, `empresa`, `sucursal`, `producto`, `departamento`),
    PRIMARY KEY (`_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `productodeposito` (
    `grupo` VARCHAR(12) NULL,
    `empresa` VARCHAR(12) NOT NULL,
    `sucursal` VARCHAR(12) NOT NULL,
    `producto` VARCHAR(30) NOT NULL,
    `deposito` VARCHAR(12) NOT NULL,
    `existencia` DOUBLE NULL,
    `existenciaanterior` DOUBLE NULL,
    `costopromedio` DOUBLE NULL,
    `costopromedioanterior` DOUBLE NULL,
    `tipo` INTEGER NULL
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `productoimpuesto` (
    `grupo` VARCHAR(12) NOT NULL,
    `empresa` VARCHAR(12) NOT NULL,
    `sucursal` VARCHAR(12) NOT NULL,
    `producto` VARCHAR(12) NOT NULL,
    `impuesto` VARCHAR(12) NOT NULL,
    `estatus` CHAR(2) NOT NULL
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `productoprecio` (
    `grupo` VARCHAR(12) NOT NULL,
    `empresa` VARCHAR(12) NOT NULL,
    `sucursal` VARCHAR(12) NOT NULL,
    `producto` VARCHAR(30) NOT NULL,
    `tipoprecio` VARCHAR(12) NOT NULL,
    `monto` DOUBLE NOT NULL,
    `estatus` VARCHAR(2) NOT NULL DEFAULT 'A',
    `predeterminado` INTEGER NOT NULL,
    `montoconimp` DOUBLE NULL,
    `montoimp` DOUBLE NULL,
    `monto_dolares` DECIMAL(10, 2) NULL,
    `HC` TINYINT NULL DEFAULT 3,

    PRIMARY KEY (`grupo`, `empresa`, `sucursal`, `producto`, `tipoprecio`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `productopresentacion` (
    `grupo` VARCHAR(12) NOT NULL,
    `empresa` VARCHAR(12) NOT NULL,
    `sucursal` VARCHAR(12) NOT NULL,
    `producto` VARCHAR(12) NOT NULL,
    `descripcion` VARCHAR(250) NOT NULL,
    `unidadmedida` VARCHAR(12) NOT NULL,
    `cantidad` DOUBLE NOT NULL,
    `estatus` INTEGER NOT NULL
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `productos` (
    `id_producto` INTEGER NOT NULL AUTO_INCREMENT,
    `nombre` VARCHAR(100) NOT NULL,
    `descripcion` VARCHAR(200) NOT NULL,
    `cod_producto` INTEGER NOT NULL,
    `monto_prom_escala` DECIMAL(15, 0) NOT NULL,
    `id_lista` INTEGER NOT NULL,

    INDEX `id_lista`(`id_lista`),
    PRIMARY KEY (`id_producto`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `productotalla` (
    `grupo` VARCHAR(12) NOT NULL,
    `empresa` VARCHAR(12) NOT NULL,
    `sucursal` VARCHAR(12) NOT NULL,
    `producto` VARCHAR(30) NOT NULL,
    `talla` VARCHAR(50) NOT NULL,
    `descripcion` VARCHAR(200) NOT NULL,
    `existencia` INTEGER NOT NULL DEFAULT 0,
    `estatus` VARCHAR(2) NOT NULL,

    PRIMARY KEY (`grupo`, `empresa`, `sucursal`, `producto`, `talla`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `produtodatosadicionales` (
    `grupo` VARCHAR(12) NOT NULL,
    `empresa` VARCHAR(12) NOT NULL,
    `sucursal` VARCHAR(12) NOT NULL,
    `producto` VARCHAR(30) NOT NULL,
    `cidigoescaneo` VARCHAR(100) NOT NULL,
    `descripcion` VARCHAR(200) NOT NULL,
    `fechacaptura` DATE NOT NULL,
    `horacaptura` TIME(0) NOT NULL,
    `marca` VARCHAR(100) NOT NULL,
    `estatus` VARCHAR(2) NOT NULL,
    `usuario` VARCHAR(50) NOT NULL,
    `ubicacion` VARCHAR(50) NOT NULL,
    `nombrelocal` VARCHAR(200) NOT NULL
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `reporte_acta` (
    `id_acta` INTEGER NOT NULL AUTO_INCREMENT,
    `fecha_inicio` DATE NOT NULL,
    `fecha_fin` DATE NOT NULL,
    `fecha_elaboracion` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `hora_inicio` TEXT NOT NULL,
    `hora_fin` TEXT NOT NULL,
    `horas_totales` TEXT NOT NULL,
    `horas_efectivas` TEXT NOT NULL,
    `viaticos` TEXT NOT NULL,
    `act_solicitadas` TEXT NOT NULL,
    `act_realizadas` TEXT NOT NULL,
    `act_pendientes` TEXT NOT NULL,
    `clasificacion` TEXT NOT NULL,
    `concepto` TEXT NOT NULL,
    `condiciones` TEXT NOT NULL,
    `correlativo` VARCHAR(15) NOT NULL,
    `id_cliente` INTEGER NOT NULL,
    `id_responsable` INTEGER NOT NULL,
    `id_distribuidor` INTEGER NULL,
    `id_subdistribuidor` INTEGER NULL,
    `tipo_atencion` TINYINT NULL,
    `nroFactura` VARCHAR(50) NULL,
    `fecha_emisionF` DATE NULL,
    `fecha_cobroF` DATE NULL,
    `status` BOOLEAN NOT NULL DEFAULT true,
    `descripcion_anulada` TEXT NULL,

    UNIQUE INDEX `correlativo`(`correlativo`),
    INDEX `id_cliente`(`id_cliente`),
    INDEX `id_responsable`(`id_responsable`),
    INDEX `id_subdistribuidor`(`id_distribuidor`, `id_subdistribuidor`),
    INDEX `id_subdistribuidor_2`(`id_subdistribuidor`),
    PRIMARY KEY (`id_acta`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `serialesposhasta28012018` (
    `sp_serial` VARCHAR(30) NULL,
    `correoDistr` VARCHAR(100) NULL,
    `diaRegistro` VARCHAR(10) NULL,
    `diavencimiento` VARCHAR(10) NULL,
    `diasvencido` INTEGER NULL,
    `sp_nombre` VARCHAR(200) NULL,
    `sp_distribuidor` VARCHAR(30) NULL,
    `sp_descripciondistribuidor` VARCHAR(200) NULL,
    `sp_estatus` INTEGER NULL,
    `sp_auto` INTEGER NULL,
    `sp_descripcionproducto` VARCHAR(200) NULL
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `sleasing` (
    `sp_serial` VARCHAR(30) NOT NULL,
    `sp_nombre` VARCHAR(200) NOT NULL,
    `sp_fecha` DATETIME(0) NULL,
    `sp_distribuidor` VARCHAR(30) NULL,
    `sp_descripciondistribuidor` VARCHAR(200) NULL,
    `sp_producto` VARCHAR(30) NULL,
    `sp_descripcionproducto` VARCHAR(200) NULL,
    `sp_detalle` VARCHAR(200) NULL,
    `sp_contacto` VARCHAR(200) NULL,
    `sp_email` VARCHAR(80) NULL,
    `sp_estatus` INTEGER NOT NULL DEFAULT 1,
    `sp_auto` INTEGER NOT NULL,
    `sp_serialdsk` VARCHAR(50) NULL,
    `sp_veces` INTEGER NOT NULL DEFAULT 1,
    `sp_ultfecha` DATE NULL,
    `sp_ip` VARCHAR(20) NULL,
    `sp_ultip` VARCHAR(20) NULL,
    `sp_ultserialdsk` VARCHAR(50) NULL,
    `sp_id` INTEGER NOT NULL,
    `sp_fechavence` DATE NOT NULL,
    `sp_dias` INTEGER NOT NULL,
    `sp_tipolicencia` INTEGER NOT NULL
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `sleasingdetalle` (
    `Auto` INTEGER NOT NULL,
    `Serial` VARCHAR(50) NOT NULL,
    `fechaoriginal` DATE NOT NULL,
    `fecharenovacion` DATE NOT NULL,
    `fechavencimiento` DATE NOT NULL,
    `dias` INTEGER NOT NULL,
    `idproducto` INTEGER NOT NULL,
    `producto` VARCHAR(50) NOT NULL,
    `distribuidor` VARCHAR(50) NOT NULL,
    `emaildist` VARCHAR(100) NOT NULL,
    `emailclte` VARCHAR(100) NOT NULL,
    `serialRenovacion` VARCHAR(50) NULL,
    `tipoOperacion` INTEGER UNSIGNED NOT NULL DEFAULT 1
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `sleasinglic` (
    `sp_serial` VARCHAR(30) NOT NULL,
    `sp_nombre` VARCHAR(200) NOT NULL,
    `sp_fecha` DATETIME(0) NULL,
    `sp_distribuidor` VARCHAR(30) NULL,
    `sp_descripciondistribuidor` VARCHAR(200) NULL,
    `sp_producto` VARCHAR(30) NULL,
    `sp_descripcionproducto` VARCHAR(200) NULL,
    `sp_detalle` VARCHAR(200) NULL,
    `sp_contacto` VARCHAR(200) NULL,
    `sp_email` VARCHAR(80) NULL,
    `sp_estatus` INTEGER NOT NULL DEFAULT 1,
    `sp_auto` INTEGER NOT NULL,
    `sp_serialdsk` VARCHAR(50) NULL,
    `sp_veces` INTEGER NOT NULL DEFAULT 1,
    `sp_ultfecha` DATE NULL,
    `sp_ip` VARCHAR(20) NULL,
    `sp_ultip` VARCHAR(20) NULL,
    `sp_ultserialdsk` VARCHAR(50) NULL,
    `sp_id` INTEGER NOT NULL,
    `sp_fechavence` DATE NOT NULL,
    `sp_dias` INTEGER NOT NULL,
    `sp_tipolicencia` INTEGER NOT NULL
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `softwares_competidores` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `descripcion` VARCHAR(250) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `solicitud` (
    `id_solicitud` INTEGER NOT NULL AUTO_INCREMENT,
    `grupo` INTEGER NOT NULL,
    `id_producto` INTEGER NULL,
    `cod_producto` VARCHAR(20) NULL,
    `producto` VARCHAR(200) NOT NULL,
    `cantidad` INTEGER NOT NULL,
    `descuento` VARCHAR(3) NOT NULL,
    `subtotal` DECIMAL(20, 2) NOT NULL,
    `total_siniva` DECIMAL(20, 2) NOT NULL,
    `iva` DECIMAL(20, 2) NOT NULL,
    `monto_total` DECIMAL(30, 2) NOT NULL,
    `comprobante` VARCHAR(200) NOT NULL,
    `status` BOOLEAN NOT NULL,
    `tipo_pago` TINYINT NOT NULL,
    `fecha` DATE NOT NULL,
    `fecha_hora` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `id_usuario` INTEGER NOT NULL,

    INDEX `grupo`(`grupo`),
    INDEX `id_producto`(`id_producto`),
    INDEX `id_usuario`(`id_usuario`),
    PRIMARY KEY (`id_solicitud`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `solicitud_actividad` (
    `id_actividad` INTEGER NOT NULL AUTO_INCREMENT,
    `titulo` VARCHAR(255) NOT NULL,
    `descripcion` TEXT NOT NULL,
    `status` TINYINT NOT NULL,
    `fecha_solicitud` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `fecha_atencion` TIMESTAMP(0) NULL,
    `id_cliente` INTEGER NOT NULL,
    `id_acta` INTEGER NULL,
    `status_asignacion` TINYINT NULL,
    `calificacion` BOOLEAN NULL,

    INDEX `id_acta`(`id_acta`),
    INDEX `id_cliente`(`id_cliente`),
    PRIMARY KEY (`id_actividad`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `spersonalizacion` (
    `sp_serial` VARCHAR(30) NOT NULL,
    `sp_nombre` VARCHAR(200) NOT NULL,
    `sp_fecha` DATETIME(0) NULL,
    `sp_distribuidor` VARCHAR(30) NULL,
    `sp_descripciondistribuidor` VARCHAR(200) NULL,
    `sp_producto` VARCHAR(30) NULL,
    `sp_descripcionproducto` VARCHAR(200) NULL,
    `sp_detalle` VARCHAR(200) NULL,
    `sp_contacto` VARCHAR(200) NULL,
    `sp_email` VARCHAR(80) NULL,
    `sp_estatus` INTEGER NOT NULL DEFAULT 1,
    `sp_auto` INTEGER NOT NULL,
    `sp_serialdsk` VARCHAR(50) NULL,
    `sp_veces` INTEGER NOT NULL DEFAULT 1,
    `sp_ultfecha` DATE NULL,
    `sp_ip` VARCHAR(20) NULL,
    `sp_ultip` VARCHAR(20) NULL,
    `sp_ultserialdsk` VARCHAR(50) NULL,
    `sp_id` INTEGER NOT NULL,
    `sp_fechavence` DATE NOT NULL,
    `sp_dias` INTEGER NOT NULL,
    `sp_tipolicencia` INTEGER NOT NULL,
    `sp_direccion` VARCHAR(255) NOT NULL,
    `sp_telefonos` VARCHAR(200) NOT NULL,
    `sp_pais` VARCHAR(200) NOT NULL,
    `sp_rif` VARCHAR(100) NOT NULL,
    `sp_version` VARCHAR(150) NOT NULL
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `spersonalizacion042016` (
    `sp_serial` VARCHAR(30) NOT NULL,
    `sp_nombre` VARCHAR(200) NOT NULL,
    `sp_fecha` DATETIME(0) NULL,
    `sp_distribuidor` VARCHAR(30) NULL,
    `sp_descripciondistribuidor` VARCHAR(200) NULL,
    `sp_producto` VARCHAR(30) NULL,
    `sp_descripcionproducto` VARCHAR(200) NULL,
    `sp_detalle` VARCHAR(200) NULL,
    `sp_contacto` VARCHAR(200) NULL,
    `sp_email` VARCHAR(80) NULL,
    `sp_estatus` INTEGER NOT NULL DEFAULT 1,
    `sp_auto` INTEGER NOT NULL,
    `sp_serialdsk` VARCHAR(50) NULL,
    `sp_veces` INTEGER NOT NULL DEFAULT 1,
    `sp_ultfecha` DATE NULL,
    `sp_ip` VARCHAR(20) NULL,
    `sp_ultip` VARCHAR(20) NULL,
    `sp_ultserialdsk` VARCHAR(50) NULL
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `spersonalizacion2` (
    `sp_serial` VARCHAR(30) NOT NULL,
    `sp_nombre` VARCHAR(200) NOT NULL,
    `sp_fecha` DATETIME(0) NULL,
    `sp_distribuidor` VARCHAR(30) NULL,
    `sp_descripciondistribuidor` VARCHAR(200) NULL,
    `sp_producto` VARCHAR(30) NULL,
    `sp_descripcionproducto` VARCHAR(200) NULL,
    `sp_detalle` VARCHAR(200) NULL,
    `sp_contacto` VARCHAR(200) NULL,
    `sp_email` VARCHAR(80) NULL,
    `sp_estatus` INTEGER NOT NULL DEFAULT 1,
    `sp_auto` INTEGER NOT NULL,
    `sp_serialdsk` VARCHAR(50) NULL,
    `sp_veces` INTEGER NOT NULL DEFAULT 1,
    `sp_ultfecha` DATE NULL,
    `sp_ip` VARCHAR(20) NULL,
    `sp_ultip` VARCHAR(20) NULL,
    `sp_ultserialdsk` VARCHAR(50) NULL,
    `sp_id` INTEGER NOT NULL,
    `sp_fechavence` DATE NOT NULL,
    `sp_dias` INTEGER NOT NULL,
    `sp_tipolicencia` INTEGER NOT NULL,
    `sp_direccion` VARCHAR(255) NOT NULL,
    `sp_telefonos` VARCHAR(200) NOT NULL,
    `sp_pais` VARCHAR(200) NOT NULL,
    `sp_rif` VARCHAR(100) NOT NULL,
    `sp_version` VARCHAR(150) NOT NULL
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `spersonalizacionnotificacion` (
    `PK_NOTIFCACIONLIC` BIGINT UNSIGNED NOT NULL,
    `NF_SERIAL_LIC` VARCHAR(30) NOT NULL,
    `NF_DIA_DIFF_NOTIFICACION` INTEGER NOT NULL,
    `NF_FECHA_CREACION` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `srelacionserial` (
    `tiporelacion` INTEGER NOT NULL,
    `serial1` VARCHAR(50) NOT NULL,
    `serial2` VARCHAR(50) NOT NULL,
    `estatus` INTEGER NOT NULL,
    `vence` DATE NOT NULL,
    `auto1` INTEGER NOT NULL,
    `auto2` INTEGER NOT NULL,
    `nombre` VARCHAR(200) NOT NULL,
    `machine` VARCHAR(255) NOT NULL,
    `serie` VARCHAR(100) NOT NULL,
    `grupo` VARCHAR(50) NOT NULL,
    `empresa` VARCHAR(50) NOT NULL,
    `sucursal` VARCHAR(50) NOT NULL,
    `cntmod` INTEGER NOT NULL DEFAULT 0,
    `cntchg` INTEGER NOT NULL DEFAULT 0,
    `autoincrement` INTEGER NOT NULL
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `sseriales` (
    `FS_CODIGOP` VARCHAR(80) NOT NULL,
    `FS_SERIAL` VARCHAR(80) NOT NULL,
    `FS_AUTOINCREMENT` INTEGER NOT NULL,
    `FS_TIPOOPERACION` INTEGER NOT NULL,
    `FS_CLIENTE` VARCHAR(80) NOT NULL,
    `FS_DOCUMENTOVENTA` VARCHAR(80) NOT NULL,
    `FS_CONSUMIDA` BOOLEAN NOT NULL,
    `FS_FECHAVENTA` DATE NOT NULL,
    `FS_FECHAVENCE` DATE NOT NULL
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `subdistribuidores` (
    `id_subdistribuidor` INTEGER NOT NULL AUTO_INCREMENT,
    `nombre` VARCHAR(70) NOT NULL,
    `nombre_empresa` VARCHAR(70) NOT NULL,
    `pais` VARCHAR(50) NOT NULL,
    `ciudad` VARCHAR(50) NOT NULL,
    `prefijo` VARCHAR(50) NOT NULL,
    `numero_contacto` VARCHAR(20) NOT NULL,
    `cod_postal` INTEGER NOT NULL,
    `id_fiscal` VARCHAR(15) NOT NULL,
    `persona_contacto` VARCHAR(70) NOT NULL,
    `direccion_fiscal` VARCHAR(100) NOT NULL,
    `direccion_envio` VARCHAR(100) NOT NULL,
    `id_escala` INTEGER NOT NULL,
    `id_usuario` INTEGER NOT NULL,
    `id_distribuidor` INTEGER NULL,

    INDEX `id_distribuidor`(`id_distribuidor`),
    INDEX `id_escala`(`id_escala`),
    INDEX `id_usuario`(`id_usuario`),
    PRIMARY KEY (`id_subdistribuidor`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `suc_rel_serial` (
    `idRelSerial` INTEGER NOT NULL,
    `tiporelacion` TINYINT NOT NULL,
    `tipovariable` TINYINT NOT NULL,
    `fechaRelacion` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `serialAdmin` VARCHAR(30) NOT NULL,
    `statusSerial` CHAR(1) NOT NULL DEFAULT 'A',
    `FechaInicioSerial` DATE NOT NULL,
    `FechaFinalSerial` DATE NOT NULL,
    `idSucursal` INTEGER NOT NULL,
    `statusRelacion` CHAR(1) NOT NULL,
    `idUser` INTEGER NOT NULL
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `sucursal` (
    `grupo` VARCHAR(12) NULL,
    `empresa` VARCHAR(12) NOT NULL,
    `sucursal` VARCHAR(12) NOT NULL,
    `nombre` VARCHAR(200) NULL,
    `direccion` VARCHAR(350) NULL,
    `telefono` VARCHAR(50) NULL,
    `fax` VARCHAR(50) NULL,
    `correo` VARCHAR(200) NULL,
    `web` VARCHAR(200) NULL,
    `principal` INTEGER NULL,
    `estatus` CHAR(1) NULL
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tipoprecio` (
    `grupo` VARCHAR(12) NOT NULL,
    `empresa` VARCHAR(12) NOT NULL,
    `sucursal` VARCHAR(12) NOT NULL,
    `tipoprecio` VARCHAR(12) NOT NULL,
    `descripcion` VARCHAR(200) NOT NULL,
    `estatus` CHAR(2) NOT NULL
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `transaccion` (
    `grupo` VARCHAR(12) NULL,
    `empresa` VARCHAR(12) NOT NULL,
    `sucursal` VARCHAR(12) NOT NULL,
    `transaccion` VARCHAR(12) NOT NULL,
    `codcliente` VARCHAR(12) NULL,
    `nombrecliente` VARCHAR(200) NULL,
    `rif` VARCHAR(20) NULL,
    `tipocliente` INTEGER NULL DEFAULT 1,
    `exento` INTEGER NULL DEFAULT 0,
    `fecha` DATE NULL,
    `fechaanulacion` DATE NULL,
    `estatus` CHAR(1) NULL
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `transacciondetalle` (
    `grupo` VARCHAR(12) NULL,
    `empresa` VARCHAR(12) NOT NULL,
    `sucursal` VARCHAR(12) NOT NULL,
    `transaccion` VARCHAR(12) NOT NULL,
    `renglon` INTEGER NOT NULL,
    `producto` VARCHAR(30) NOT NULL,
    `sucursalorigen` VARCHAR(12) NULL,
    `deposito` VARCHAR(12) NULL,
    `depositoorigen` VARCHAR(12) NULL,
    `cantidad` DOUBLE NULL,
    `existencia` DOUBLE NULL,
    `existenciaanterior` DOUBLE NULL,
    `costopromedio` DOUBLE NULL,
    `costopromedioanterior` DOUBLE NULL
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `transacciones` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `grupo` INTEGER NOT NULL,
    `descripcion` VARCHAR(150) NOT NULL,
    `id_mp` VARCHAR(50) NOT NULL,
    `collector_id` INTEGER NOT NULL,
    `operation_type` VARCHAR(30) NOT NULL,
    `collection_status` VARCHAR(15) NULL,
    `created_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),

    UNIQUE INDEX `grupo-solicitud`(`grupo`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `transacciones_hc` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `tipo` TINYINT NOT NULL,
    `grupo` INTEGER NOT NULL,
    `created_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `id_hc` INTEGER NOT NULL,
    `id_usuario_emisor` INTEGER NOT NULL,
    `id_usuario_receptor` INTEGER NULL,

    INDEX `grupo`(`grupo`),
    INDEX `grupo_solicitud`(`grupo`),
    INDEX `id_hc`(`id_hc`),
    INDEX `id_hc_2`(`id_hc`),
    INDEX `id_usuario_emisor`(`id_usuario_emisor`),
    INDEX `id_usuario_emisor_2`(`id_usuario_emisor`),
    INDEX `id_usuario_receptor`(`id_usuario_receptor`),
    INDEX `id_usuario_receptor_2`(`id_usuario_receptor`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `usuario` (
    `grupo` VARCHAR(12) NULL,
    `empresa` VARCHAR(12) NOT NULL,
    `sucursal` VARCHAR(12) NOT NULL,
    `usuario` VARCHAR(30) NOT NULL,
    `nombre` VARCHAR(200) NULL,
    `perfil` INTEGER NULL DEFAULT 0,
    `estatus` CHAR(1) NULL DEFAULT 'A'
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `usuario_localizacion` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `pais` VARCHAR(100) NOT NULL,
    `ciudad` VARCHAR(100) NOT NULL,
    `direccion` VARCHAR(255) NOT NULL,
    `estatus` VARCHAR(20) NOT NULL,
    `lat` DECIMAL(16, 13) NOT NULL,
    `lng` DECIMAL(16, 13) NOT NULL,
    `id_usuario` INTEGER NOT NULL,
    `nivel` INTEGER NOT NULL,

    INDEX `fk_usuario_localizacion_usuarios`(`id_usuario`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `usuario_menu` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `id_usuario` INTEGER NOT NULL,
    `id_menu` INTEGER NOT NULL,
    `fecha_activacion` DATE NOT NULL,
    `fecha_vencimiento` DATE NOT NULL,

    INDEX `id_munu`(`id_menu`),
    INDEX `id_usuario`(`id_usuario`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `usuario_token` (
    `id_usuario_token` INTEGER NOT NULL AUTO_INCREMENT,
    `token` VARCHAR(255) NOT NULL,
    `estado` ENUM('CREADO', 'USADO', 'REVOCADO') NOT NULL,
    `fecha_creacion` DATETIME(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `fecha_actualizacion` DATETIME(0) NULL,
    `fecha_vencimiento` DATETIME(0) NOT NULL,
    `id_usuario` INTEGER NOT NULL,

    INDEX `fk_usuario_token_usuario`(`id_usuario`),
    PRIMARY KEY (`id_usuario_token`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `usuarioconfiguracion` (
    `grupo` VARCHAR(12) NULL,
    `empresa` VARCHAR(12) NOT NULL,
    `sucursal` VARCHAR(12) NOT NULL,
    `usuario` VARCHAR(30) NOT NULL,
    `opcion` VARCHAR(20) NOT NULL
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `usuarioperfil` (
    `grupo` VARCHAR(12) NULL,
    `empresa` VARCHAR(12) NOT NULL,
    `sucursal` VARCHAR(12) NOT NULL,
    `usuario` VARCHAR(30) NOT NULL,
    `perfil` VARCHAR(30) NOT NULL
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `usuarios` (
    `id_usuario` INTEGER NOT NULL AUTO_INCREMENT,
    `nombre` VARCHAR(70) NOT NULL,
    `nombre_emp` VARCHAR(70) NOT NULL,
    `correo` VARCHAR(70) NOT NULL,
    `password` VARCHAR(20) NULL,
    `password_hash` VARCHAR(255) NULL,
    `intentos_login` INTEGER NOT NULL DEFAULT 0,
    `fecha_bloqueo` DATETIME(0) NULL,
    `nivel` TINYINT NOT NULL,
    `status` TINYINT NOT NULL,
    `img_usuario` VARCHAR(100) NOT NULL,
    `img_empresa` VARCHAR(100) NOT NULL,
    `rutaPathEmpresa` TEXT NOT NULL,
    `fecha_registro` DATE NOT NULL,
    `tipo_moneda` TINYINT NULL,
    `tipo_usuario` TINYINT NULL,
    `fecha_activacion` DATE NULL,
    `fecha_vencimiento` DATE NULL,
    `lat` DECIMAL(16, 13) NULL,
    `lng` DECIMAL(16, 13) NULL,

    PRIMARY KEY (`id_usuario`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `RefreshToken` (
    `id` VARCHAR(191) NOT NULL,
    `userId` INTEGER NOT NULL,
    `tokenHash` VARCHAR(191) NOT NULL,
    `status` ENUM('ACTIVE', 'REVOKED', 'EXPIRED') NOT NULL DEFAULT 'ACTIVE',
    `expiresAt` DATETIME(3) NOT NULL,
    `revokedAt` DATETIME(3) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `ip` VARCHAR(191) NULL,
    `userAgent` VARCHAR(191) NULL,
    `deviceId` VARCHAR(191) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `archivo_licencia` ADD CONSTRAINT `archivo_licencia_ibfk_1` FOREIGN KEY (`id_asignacion`) REFERENCES `asignacion_licencias`(`id_asignacion`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `atencion_actividad` ADD CONSTRAINT `atencion_actividad_ibfk_1` FOREIGN KEY (`id_actividad`) REFERENCES `solicitud_actividad`(`id_actividad`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `atencion_actividad` ADD CONSTRAINT `atencion_actividad_ibfk_2` FOREIGN KEY (`id_asesor`) REFERENCES `asesores`(`id_asesor`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `atencion_actividad` ADD CONSTRAINT `atencion_actividad_ibfk_3` FOREIGN KEY (`id_cliente`) REFERENCES `cliente_final`(`id_cliente_final`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `cartas_forma_libre_cliente_final` ADD CONSTRAINT `fk_carta_cliente_final` FOREIGN KEY (`id_cliente_final`) REFERENCES `cliente_final`(`id_cliente_final`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `cliente_final` ADD CONSTRAINT `cliente_objeto_empresa` FOREIGN KEY (`id_objeto_empresa`) REFERENCES `objetos_empresas`(`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- AddForeignKey
ALTER TABLE `cliente_final` ADD CONSTRAINT `software_anterior` FOREIGN KEY (`id_software_anterior`) REFERENCES `softwares_competidores`(`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- AddForeignKey
ALTER TABLE `configsidebar` ADD CONSTRAINT `configsidebar_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios`(`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `RefreshToken` ADD CONSTRAINT `RefreshToken_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `usuarios`(`id_usuario`) ON DELETE RESTRICT ON UPDATE CASCADE;


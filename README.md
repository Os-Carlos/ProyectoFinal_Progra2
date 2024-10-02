# Proyecto Final Progra 2  
Aplicación web para la gestión interna de un punto de venta

## Funcionalidades:
- Iniciar sesión
- Cerrar sesión
- Despliegue de vistas por rol
  - Admin 
  - Ventas
  - Compras
  - Inventario
- Gestión de ventas
  - generar reporte de ventas por rango de fechas 
- Gestión de compras
- Gestión de inventario
- Gestión de clientes
  - buscar clientes 
- Gestión de proveedores
- Gestión de usuarios
- Gestión de grupos
- Gestión de permisos de grupos
- Gestión de permisos

### Ususarios existentes
- `Admin`       ahernandez / 1111
- `Ventas`      cosorio / 1212
- `Inventario`  ocaceres / 1313
- `Inventario`  rargueta / 0303
- `Compras`     jchocon / 1414
  
## Preparación de entorno de ejecución
### Instaladores
- [JDK 23](https://download.oracle.com/java/23/latest/jdk-23_windows-x64_bin.exe)
- [Apache Netbeans 23](https://dlcdn.apache.org/netbeans/netbeans-installers/23/Apache-NetBeans-23-bin-windows-x64.exe)
- [SQL Server 22 Express](https://go.microsoft.com/fwlink/p/?linkid=2216019&clcid=0x40A&culture=es-es&country=es)
- [Apache Tomcat 9](https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.95/bin/apache-tomcat-9.0.95-windows-x64.zip)

### Servidor Tomcat
- Click derecho en el proyecto -> Resolver problemas de servidor

  ![Captura de pantalla (271)](https://github.com/user-attachments/assets/e91defa0-a8e3-49c9-b02e-bac14f095cfa)
- Add server -> Apache Tomcat

  ![image](https://github.com/user-attachments/assets/d6768a25-7877-4fbb-82e6-519ee2e807d4)
  ![image](https://github.com/user-attachments/assets/828c0afb-15d0-49c1-b58b-9c35cc03becb)
- Colocar la ruta en la que se descomprimio Tomcat, definir usuario y contraseña

  ![image](https://github.com/user-attachments/assets/3082cc2a-acfd-430a-84c1-0ab9ca7a2c3c)
- Seleccionar el servidor creado

  ![image](https://github.com/user-attachments/assets/de9411d1-8a49-4b67-94c0-86fd1e841c47)

### Base de datos
- Restaurar la base de datos `PROYECTOPROGRA2.bak`
- Crear un login: Security -> Logins -> New login
  - Colocar nombre de usuario y contraseña
  - Asignar ese login como propietario de la base de datos
- Cambiar las propiedades de seguridad del servidor para permitir el ingreso con credenciales de SQL Server y Windows
- Habilitar el puerto tcp 1433 para permitir la conexión a la BD
- Modificar las credenciales de conexión en la aplicación

  ![image](https://github.com/user-attachments/assets/5640e478-30a0-45c3-aa03-cebea149fd7a)


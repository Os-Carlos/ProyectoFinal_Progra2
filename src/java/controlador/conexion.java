/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author Carlos A. Ordoñez O.
 */
public class conexion {

    private final String NombreBD = "PROYECTOPROGRA2";
    private final String UsuarioBD = "carlos";
    private final String ClaveBD = "123a";
    private final String url = "jdbc:sqlserver://localhost;databaseName=" + NombreBD + ";user=" + UsuarioBD + ";password=" + ClaveBD + ";";
    private final String nombreClase = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
    public Connection conexion = null;

    public void AbrirConexion() {
        try {
            Class.forName(nombreClase);
            conexion = DriverManager.getConnection(url);
        } catch (ClassNotFoundException | SQLException ex) {
            System.out.println("Error de conexion" + ex.getMessage());
        }
    }

    public void CerrarConexion() {
        try {
            conexion.close();
        } catch (SQLException ex) {
            System.out.println("Error de cierre" + ex.getMessage());
        }
    }

    public Connection ObtenerConexion() {
        return conexion;
    }
}

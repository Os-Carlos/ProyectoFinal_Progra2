/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

import controlador.conexion;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.swing.table.DefaultTableModel;

/**
 *
 * @author acer
 */
public class inventarioT {

    private String nombre, descripcion;
    private int idInventario, cantidad;
    private float precio;
    conexion con;

    public inventarioT() {
    }

    public inventarioT(String nombre, String descripcion, int idInventario, int cantidad, float precio) {
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.idInventario = idInventario;
        this.cantidad = cantidad;
        this.precio = precio;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public int getIdInventario() {
        return idInventario;
    }

    public void setIdInventario(int idInventario) {
        this.idInventario = idInventario;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

    public float getPrecio() {
        return precio;
    }

    public void setPrecio(float precio) {
        this.precio = precio;
    }

    public DefaultTableModel leer() {
        DefaultTableModel tabla = new DefaultTableModel();
        try {
            con = new conexion();
            con.AbrirConexion();
            String query = "select * from inventario;";
            ResultSet consulta = con.conexion.createStatement().executeQuery(query);
            String encabezado[] = {"idinventario", "nombre", "existencias", "precio", "Descripcion"};
            tabla.setColumnIdentifiers(encabezado);
            String datos[] = new String[5];
            while (consulta.next()) {
                datos[0] = consulta.getString("idinventario");
                datos[1] = consulta.getString("nombre");
                datos[2] = consulta.getString("existencias");
                datos[3] = consulta.getString("precio");
                datos[4] = consulta.getString("descripcion");
                tabla.addRow(datos);
            }
            con.CerrarConexion();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return tabla;
    }

    public int agregar() {
        int retorno;
        try {

            PreparedStatement parametro;
            con = new conexion();
            String query = "insert into inventario(nombre,existencias,precio,descripcion) Values(?,?,?,?);";
            con.AbrirConexion();
            parametro = (PreparedStatement) con.conexion.prepareStatement(query);            
            parametro.setString(1, getNombre());
            parametro.setInt(2, getCantidad());
            parametro.setFloat(3, getPrecio());
            parametro.setString(4, getDescripcion());
            retorno = parametro.executeUpdate();
            con.CerrarConexion();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
            retorno = 0;

        }
        return retorno;

    }

    public int modificar() {
        int retorno;
        try {
            PreparedStatement parametro;
            con = new conexion();
            String query = "update inventario set nombre=?,existencias=?,precio=?,descripcion=? where idinventario=?";
            con.AbrirConexion();
            parametro = (PreparedStatement) con.conexion.prepareStatement(query);
            parametro.setString(1, getNombre());
            parametro.setInt(2, getCantidad());
            parametro.setFloat(3, getPrecio());
            parametro.setString(4, getDescripcion());
            parametro.setInt(5, getIdInventario());
            retorno = parametro.executeUpdate();
            con.CerrarConexion();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
            retorno = 0;
        }
        return retorno;
    }

    public int eliminar() {
        int retorno;
        try {
            PreparedStatement parametro;
            con = new conexion();
            String query = "delete from inventario where idinventario=?;";
            con.AbrirConexion();
            parametro = (PreparedStatement) con.conexion.prepareStatement(query);
            parametro.setInt(1, getIdInventario());
            retorno = parametro.executeUpdate();
            con.CerrarConexion();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
            retorno = 0;
        }
        return retorno;
    }
}

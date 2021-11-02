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
 * @author Usuario
 */
public class comprador {

    private int idcompra;
    private String idproveedor, idfactura, idcompradetalle, fecha, producto, cantidad, precio;
    private conexion cn;

    public comprador() {
    }

    public comprador(int idcompra, String idproveedor, String idfactura, String idcompradetalle, String fecha, String producto, String cantidad, String precio) {
        this.idcompra = idcompra;
        this.idproveedor = idproveedor;
        this.idfactura = idfactura;
        this.idcompradetalle = idcompradetalle;
        this.fecha = fecha;
        this.producto = producto;
        this.cantidad = cantidad;
        this.precio = precio;
    }

    public int getIdcompra() {
        return idcompra;
    }

    public void setIdcompra(int idcompra) {
        this.idcompra = idcompra;
    }

    public String getIdproveedor() {
        return idproveedor;
    }

    public void setIdproveedor(String idproveedor) {
        this.idproveedor = idproveedor;
    }

    public String getIdfactura() {
        return idfactura;
    }

    public void setIdfactura(String idfactura) {
        this.idfactura = idfactura;
    }

    public String getIdcompradetalle() {
        return idcompradetalle;
    }

    public void setIdcompradetalle(String idcompradetalle) {
        this.idcompradetalle = idcompradetalle;
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    public String getProducto() {
        return producto;
    }

    public void setProducto(String producto) {
        this.producto = producto;
    }

    public String getCantidad() {
        return cantidad;
    }

    public void setCantidad(String cantidad) {
        this.cantidad = cantidad;
    }

    public String getPrecio() {
        return precio;
    }

    public void setPrecio(String precio) {
        this.precio = precio;
    }

    public DefaultTableModel leer() {
        DefaultTableModel tabla = new DefaultTableModel();

        try {
            cn = new conexion();
            cn.AbrirConexion();

            String query = "SELECT idcompra,idfactura,idproveedor,idcompradetalle,fecha,producto,cantidad,precio FROM compra";
            ResultSet consulta = cn.conexion.createStatement().executeQuery(query);
            String encabezado[] = {"idcompra", "idfactura", "idproveedor", "idcompradetalle", "fecha", "producto", "cantidad", "precio"};
            tabla.setColumnIdentifiers(encabezado);
            String datos[] = new String[8];
            while (consulta.next()) {
                datos[0] = consulta.getString("idcompra");
                datos[1] = consulta.getString("idfactura");
                datos[2] = consulta.getString("idproveedor");
                datos[3] = consulta.getString("idcompradetalle");
                datos[4] = consulta.getString("fecha");
                datos[5] = consulta.getString("producto");
                datos[6] = consulta.getString("cantidad");
                datos[7] = consulta.getString("precio");
                tabla.addRow(datos);
            }

            cn.CerrarConexion();

        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }

        return tabla;
    }

    public int agregar() {
        int retorno;

        try {

            PreparedStatement parametro;
            cn = new conexion();
            String query = "INSERT INTO compra(idfactura,idproveedor,idcompradetalle,fecha,producto,cantidad,precio)VALUES(?,?,?,?,?,?,?);";
            cn.AbrirConexion();

            parametro = (PreparedStatement) cn.conexion.prepareStatement(query);
            parametro.setString(1, getIdfactura());
            parametro.setString(2, getIdproveedor());
            parametro.setString(3, getIdcompradetalle());
            parametro.setString(4, getFecha());
            parametro.setString(5, getProducto());
            parametro.setString(6, getCantidad());
            parametro.setString(7, getPrecio());

            retorno = parametro.executeUpdate();

            cn.CerrarConexion();
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
            cn = new conexion();
            String query = "update compra set idfactura=?,idproveedor=?,idcompradetalle=?,fecha=?,producto=?,cantidad=?,precio=? where idcompra=?;";
            cn.AbrirConexion();

            parametro = (PreparedStatement) cn.conexion.prepareStatement(query);
            parametro.setString(1, getIdfactura());
            parametro.setString(2, getIdproveedor());
            parametro.setString(3, getIdcompradetalle());
            parametro.setString(4, getFecha());
            parametro.setString(5, getProducto());
            parametro.setString(6, getCantidad());
            parametro.setString(7, getPrecio());
            parametro.setInt(8, getIdcompra());

            retorno = parametro.executeUpdate();

            cn.CerrarConexion();
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
            cn = new conexion();
            String query = "delete from compra where idcompra=?;";
            cn.AbrirConexion();

            parametro = (PreparedStatement) cn.conexion.prepareStatement(query);

            parametro.setInt(1, getIdcompra());

            retorno = parametro.executeUpdate();

            cn.CerrarConexion();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
            retorno = 0;
        }
        return retorno;
    }
}

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
public class ventas {

    private String fecha, codigo;
    private int idventa, idcliente;
    conexion con;

    public ventas() {
    }

    public ventas(String fecha, String codigo, int idcliente, int idventa) {
        this.fecha = fecha;
        this.codigo = codigo;
        this.idcliente = idcliente;
        this.idventa = idventa;
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    public String getCodigo() {
        return codigo;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

    public int getIdcliente() {
        return idcliente;
    }

    public void setIdcliente(int idcliente) {
        this.idcliente = idcliente;
    }

    public int getIdventa() {
        return idventa;
    }

    public void setIdventa(int idventa) {
        this.idventa = idventa;
    }

    public DefaultTableModel leer() {
        DefaultTableModel tabla = new DefaultTableModel();
        try {
            con = new conexion();
            con.AbrirConexion();
            String query = "select v.Idventa,v.fecha,v.codigo,v.idcliente from ventas as v inner join ventas as ve on v.Idventa=ve.Idventa";
            ResultSet consulta = con.conexion.createStatement().executeQuery(query);
            String encabezado[] = {"idventa", "Fecha", "Codigo", "idcliente"};
            tabla.setColumnIdentifiers(encabezado);
            String datos[] = new String[4];
            while (consulta.next()) {
                datos[0] = consulta.getString("idventa");
                datos[1] = consulta.getString("fecha");
                datos[2] = consulta.getString("codigo");
                datos[3] = consulta.getString("idcliente");
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
            String query = "insert into ventas(fecha,codigo,idcliente) Values(?,?,?);";
            con.AbrirConexion();
            parametro = (PreparedStatement) con.conexion.prepareStatement(query);
            parametro.setString(1, getFecha());
            parametro.setString(2, getCodigo());
            parametro.setInt(3, getIdcliente());
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
            String query = "update ventas set fecha=?,codigo=?,Idcliente=? where Idventa=?";
            con.AbrirConexion();
            parametro = (PreparedStatement) con.conexion.prepareStatement(query);
            parametro.setString(1, getFecha());
            parametro.setString(2, getCodigo());
            parametro.setInt(3, getIdcliente());
            parametro.setInt(4, getIdventa());
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
            String query = "delete from ventas where Idventa=?;";
            con.AbrirConexion();
            parametro = (PreparedStatement) con.conexion.prepareStatement(query);
            parametro.setInt(1, getIdventa());
            retorno = parametro.executeUpdate();
            con.CerrarConexion();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
            retorno = 0;
        }
        return retorno;
    }
}

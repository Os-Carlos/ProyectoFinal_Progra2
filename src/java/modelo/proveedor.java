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
public class proveedor {

    private int idproveedor;
    private String telefono, nombreempresa, idpersona;
    private conexion cn;

    public proveedor() {
    }

    public proveedor(int idproveedor, String telefono, String nombreempresa, String idpersona) {
        this.idproveedor = idproveedor;
        this.telefono = telefono;
        this.nombreempresa = nombreempresa;
        this.idpersona = idpersona;
    }

    public int getIdproveedor() {
        return idproveedor;
    }

    public void setIdproveedor(int idproveedor) {
        this.idproveedor = idproveedor;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getNombreempresa() {
        return nombreempresa;
    }

    public void setNombreempresa(String nombreempresa) {
        this.nombreempresa = nombreempresa;
    }

    public String getIdpersona() {
        return idpersona;
    }

    public void setIdpersona(String idpersona) {
        this.idpersona = idpersona;
    }

    public DefaultTableModel leer() {
        DefaultTableModel tabla = new DefaultTableModel();

        try {
            cn = new conexion();
            cn.AbrirConexion();

            String query = "SELECT idproveedor,idpersona,telefono,empresa FROM proveedor";
            ResultSet consulta = cn.conexion.createStatement().executeQuery(query);
            String encabezado[] = {"idproveedor", "idpersona", "telefono", "empresa"};
            tabla.setColumnIdentifiers(encabezado);
            String datos[] = new String[4];
            while (consulta.next()) {
                datos[0] = consulta.getString("idproveedor");
                datos[1] = consulta.getString("idpersona");
                datos[2] = consulta.getString("telefono");
                datos[3] = consulta.getString("empresa");

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
            String query = "INSERT INTO proveedor(idpersona,telefono,empresa)VALUES(?,?,?);";
            cn.AbrirConexion();

            parametro = (PreparedStatement) cn.conexion.prepareStatement(query);
            parametro.setString(1, getIdpersona());
            parametro.setString(2, getTelefono());
            parametro.setString(3, getNombreempresa());

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
            String query = "update proveedor set idpersona=?,telefono=?,empresa=? where idproveedor=?;";
            cn.AbrirConexion();

            parametro = (PreparedStatement) cn.conexion.prepareStatement(query);
            parametro.setString(1, getIdpersona());
            parametro.setString(2, getTelefono());
            parametro.setString(3, getNombreempresa());
            parametro.setInt(4, getIdproveedor());

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
            String query = "delete from proveedor where idproveedor=?;";
            cn.AbrirConexion();

            parametro = (PreparedStatement) cn.conexion.prepareStatement(query);

            parametro.setInt(1, getIdproveedor());

            retorno = parametro.executeUpdate();

            cn.CerrarConexion();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
            retorno = 0;
        }
        return retorno;
    }
}

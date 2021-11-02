package modelo;

import java.sql.ResultSet;
import java.sql.PreparedStatement;
import controlador.conexion;
import java.sql.SQLException;
import javax.swing.table.DefaultTableModel;

/**
 *
 * @author ANDRES HERNANDEZ J
 */
public class permiso {

    private String nombre;
    private int id;
    conexion cn;

    public permiso() {
    }

    public permiso(String nombre, int id) {
        this.nombre = nombre;

        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int agregar() {
        int retorno;
        try {
            PreparedStatement parametro;
            cn = new conexion();
            cn.AbrirConexion();
            String query = "insert into permiso(nombre) values(?);";
            parametro = (PreparedStatement) cn.conexion.prepareStatement(query);
            parametro.setString(1, getNombre());

            retorno = parametro.executeUpdate();
            cn.CerrarConexion();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
            retorno = 0;

        }
        return retorno;

    }

    public DefaultTableModel leer() {
        DefaultTableModel tabla = new DefaultTableModel();
        try {
            cn = new conexion();
            cn.AbrirConexion();
            String query = "select * from permiso";
            ResultSet consulta = cn.conexion.createStatement().executeQuery(query);
            String encabezado[] = {"ID", "NOMBRE"};
            tabla.setColumnIdentifiers(encabezado);
            String datos[] = new String[2];
            while (consulta.next()) {
                datos[0] = consulta.getString("idPermiso");
                datos[1] = consulta.getString("nombre");

                tabla.addRow(datos);
            }
            cn.CerrarConexion();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return tabla;
    }

    public int modificar() {
        int retorno;
        try {

            PreparedStatement parametro;
            cn = new conexion();
            String query = "update permiso set nombre=? where idPermiso=?;";
            cn.AbrirConexion();
            parametro = (PreparedStatement) cn.conexion.prepareStatement(query);
            parametro.setString(1, getNombre());

            parametro.setInt(2, getId());
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
            String query = "delete from permiso where idPermiso=?;";
            cn.AbrirConexion();
            parametro = (PreparedStatement) cn.conexion.prepareStatement(query);
            parametro.setInt(1, getId());
            retorno = parametro.executeUpdate();
            cn.CerrarConexion();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
            retorno = 0;

        }
        return retorno;

    }

}

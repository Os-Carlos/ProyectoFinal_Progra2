package modelo;

import controlador.conexion;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import javax.swing.table.DefaultTableModel;

/**
 *
 * @author acer
 */
public class GrupoUsuarios {

    private String nombre_grupo;
    private int id;

    conexion cn;

    public GrupoUsuarios() {
    }

    public GrupoUsuarios(String nombre_grupo, int id) {
        this.nombre_grupo = nombre_grupo;
        this.id = id;
    }

    public String getNombre_grupo() {
        return nombre_grupo;
    }

    public void setNombre_grupo(String nombre_grupo) {
        this.nombre_grupo = nombre_grupo;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public HashMap TipoU() {
        HashMap<String, String> Utipo = new HashMap();
        try {
            cn = new conexion();
            cn.AbrirConexion();
            String query = "SELECT idGrupo as id, nombre from  grupos_usuario";
            ResultSet consulta = cn.conexion.createStatement().executeQuery(query);
            while (consulta.next()) {
                Utipo.put(consulta.getString("id"), consulta.getString("nombre"));
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return Utipo;
    }

    public DefaultTableModel leer() {
        DefaultTableModel tabla = new DefaultTableModel();
        try {
            cn = new conexion();
            cn.AbrirConexion();
            String query = "select * from grupos_usuario;";
            ResultSet consulta = cn.conexion.createStatement().executeQuery(query);
            String encabezado[] = {"Id Grupo", "Nombre"};
            tabla.setColumnIdentifiers(encabezado);
            String datos[] = new String[2];
            while (consulta.next()) {
                datos[0] = consulta.getString("IdGrupo");
                datos[1] = consulta.getString("nombre");
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
            String query = "insert into grupos_usuario(nombre) Values(?);";
            cn.AbrirConexion();
            parametro = (PreparedStatement) cn.conexion.prepareStatement(query);
            parametro.setString(1, getNombre_grupo());
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
            String query = "update grupos_usuario set nombre=? where IdGrupo=?";
            cn.AbrirConexion();
            parametro = (PreparedStatement) cn.conexion.prepareStatement(query);
            parametro.setString(1, getNombre_grupo());
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
            String query = "delete from grupos_usuario where IdGrupo=?;";
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

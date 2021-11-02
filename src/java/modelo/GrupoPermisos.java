package modelo;

import controlador.conexion;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.swing.table.DefaultTableModel;
import java.sql.ResultSet;
import java.util.HashMap;

/**
 *
 * @author ANDRES HERNANDEZ J
 */
public class GrupoPermisos {

    private int idGrupo, idPermiso, idGP;
    conexion con;

    public GrupoPermisos() {
    }

    public GrupoPermisos(int idGrupo, int idPermiso, int idGP) {
        this.idGrupo = idGrupo;
        this.idPermiso = idPermiso;
        this.idGP = idGP;
    }

    public int getIdGrupo() {
        return idGrupo;
    }

    public void setIdGrupo(int idGrupo) {
        this.idGrupo = idGrupo;
    }

    public int getIdPermiso() {
        return idPermiso;
    }

    public void setIdPermiso(int idPermiso) {
        this.idPermiso = idPermiso;
    }
    
    public int getIdGP() {
        return idGP;
    }

    public void setIdGP(int idGP) {
        this.idGP = idGP;
    }

    public HashMap Permiso() {
        HashMap<String, String> perms = new HashMap();
        try {
            con = new conexion();
            con.AbrirConexion();
            String query = "SELECT idPermiso as id, nombre from  permiso";
            ResultSet consulta = con.conexion.createStatement().executeQuery(query);
            while (consulta.next()) {
                perms.put(consulta.getString("id"), consulta.getString("nombre"));
            }
            con.CerrarConexion();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return perms;
    }

    public HashMap Grupo() {
        HashMap<String, String> Utipo = new HashMap();
        try {
            con = new conexion();
            con.AbrirConexion();
            String query = "SELECT idGrupo as id, nombre from  grupos_usuario";
            ResultSet consulta = con.conexion.createStatement().executeQuery(query);
            while (consulta.next()) {
                Utipo.put(consulta.getString("id"), consulta.getString("nombre"));
            }
            con.CerrarConexion();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return Utipo;
    }

    public DefaultTableModel leer() {
        DefaultTableModel tabla = new DefaultTableModel();
        try {
            con = new conexion();
            con.AbrirConexion();
            String query = "select gp.idGrupo_permiso, g.idGrupo, g.nombre, p.idPermiso, p.nombre as np from grupo_permisos as gp inner join grupos_usuario as g on g.idGrupo=gp.idGrupo  inner join permiso as p on p.idPermiso=gp.idPermiso;";
            ResultSet consulta = con.conexion.createStatement().executeQuery(query);
            String encabezado[] = {"Id", "idGrupo", "Grupo", "idPermiso", "Permiso"};
            tabla.setColumnIdentifiers(encabezado);
            String datos[] = new String[5];
            while (consulta.next()) {
                datos[0] = consulta.getString("idGrupo_permiso");
                datos[1] = consulta.getString("idGrupo");
                datos[2] = consulta.getString("nombre");
                datos[3] = consulta.getString("idPermiso");
                datos[4] = consulta.getString("np");
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
            String query = "insert into grupo_permisos(idGrupo,idPermiso) values(?,?);";
            con.AbrirConexion();
            parametro = (PreparedStatement) con.conexion.prepareStatement(query);
            parametro.setInt(1, getIdGrupo());
            parametro.setInt(2, getIdPermiso());
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
            String query = "update grupo_permisos set idGrupo=?, idPermiso=? where idGrupo_permiso=?;";
            con.AbrirConexion();
            parametro = (PreparedStatement) con.conexion.prepareStatement(query);
            parametro.setInt(1, getIdGrupo());
            parametro.setInt(2, getIdPermiso());
            parametro.setInt(3, getIdGP());
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
            String query = "delete from grupo_permisos where idGrupo_permiso=?;";
            con.AbrirConexion();
            parametro = (PreparedStatement) con.conexion.prepareStatement(query);
            parametro.setInt(1, getIdGP());
            retorno = parametro.executeUpdate();
            con.CerrarConexion();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
            retorno = 0;

        }
        return retorno;

    }
}

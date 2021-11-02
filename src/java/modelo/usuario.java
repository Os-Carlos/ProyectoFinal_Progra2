package modelo;

import controlador.conexion;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import javax.swing.table.DefaultTableModel;

public class usuario extends persona {

    private String Usuario, Clave;
    private int IdGrupo, Estado;
    conexion cn = null;
    ResultSet rs = null;

    public usuario() {
    }

    public usuario(String Usuario, String Clave, int IdGrupo, int Estado) {
        this.Usuario = Usuario;
        this.Clave = Clave;
        this.IdGrupo = IdGrupo;
        this.Estado = Estado;
    }

    public usuario(String Usuario, String Clave, int IdGrupo, int Estado, int Id, String Nombres, String Apellidos, String Direccion, String Telefono, String Correo) {
        super(Id, Nombres, Apellidos, Direccion, Telefono, Correo);
        this.Usuario = Usuario;
        this.Clave = Clave;
        this.IdGrupo = IdGrupo;
        this.Estado = Estado;
    }

    public String getUsuario() {
        return Usuario;
    }

    public void setUsuario(String Usuario) {
        this.Usuario = Usuario;
    }

    public String getClave() {
        return Clave;
    }

    public void setClave(String Clave) {
        this.Clave = Clave;
    }

    public int getIdGrupo() {
        return IdGrupo;
    }

    public void setIdGrupo(int IdGrupo) {
        this.IdGrupo = IdGrupo;
    }

    public int getEstado() {
        return Estado;
    }

    public void setEstado(int Estado) {
        this.Estado = Estado;
    }

    @Override
    public int agregar() {
        int vuelta;
        try {
            PreparedStatement parametro;
            cn = new conexion();
            String query = "insert into usuario(nombres,apellidos,usuario,clave,idGrupo,direccion,correo,telefono,estado) values(?,?,?,?,?,?,?,?,1);";
            cn.AbrirConexion();
            parametro = (PreparedStatement) cn.conexion.prepareStatement(query);
            parametro.setString(1, getNombres());
            parametro.setString(2, getApellidos());
            parametro.setString(3, getUsuario());
            parametro.setString(4, getClave());
            parametro.setInt(5, getIdGrupo());
            parametro.setString(6, getDireccion());
            parametro.setString(7, getCorreo());
            parametro.setString(8, getTelefono());
            vuelta = parametro.executeUpdate();
            cn.CerrarConexion();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
            vuelta = 0;
        }
        return vuelta;
    }

    @Override
    public int modificar() {
        int vuelta;
        try {

            PreparedStatement parametro;
            cn = new conexion();
            String query = "update usuario set nombres=?,apellidos=?,usuario=?,clave=?,estado=?,idGrupo=?,direccion=?,correo=?,telefono=? where IdUsuario=?;";
            cn.AbrirConexion();
            parametro = (PreparedStatement) cn.conexion.prepareStatement(query);
            parametro.setString(1, getNombres());
            parametro.setString(2, getApellidos());
            parametro.setString(3, getUsuario());
            parametro.setString(4, getClave());
            parametro.setInt(5, getEstado());
            parametro.setInt(6, getIdGrupo());
            parametro.setString(7, getDireccion());
            parametro.setString(8, getCorreo());
            parametro.setString(9, getTelefono());
            parametro.setInt(10, getId());
            vuelta = parametro.executeUpdate();
            cn.CerrarConexion();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
            vuelta = 0;
        }
        return vuelta;
    }

    @Override
    public int eliminar() {
        int vuelta;
        try {

            PreparedStatement parametro;
            cn = new conexion();
            String query = "delete from usuario where idUsuario=?;";
            cn.AbrirConexion();
            parametro = (PreparedStatement) cn.conexion.prepareStatement(query);
            parametro.setInt(1, getId());
            vuelta = parametro.executeUpdate();
            cn.CerrarConexion();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
            vuelta = 0;
        }
        return vuelta;
    }

    public int validar(usuario usr) {
        int retorno = 0;
        String query = "select IdUsuario, usuario, nombres, apellidos, direccion, telefono, correo, idGrupo from usuario where usuario='" + usr.getUsuario() + "' and clave='" + usr.getClave() + "' and estado=1;";

        try {
            cn = new conexion();
            cn.AbrirConexion();
            Statement stmt = cn.conexion.createStatement();
            rs = stmt.executeQuery(query);
            while (rs.next()) {
                usr.setId(rs.getInt("IdUsuario"));
                usr.setUsuario(rs.getString("usuario"));
                usr.setNombres(rs.getString("nombres"));
                usr.setApellidos(rs.getString("apellidos"));
                usr.setDireccion(rs.getString("direccion"));
                usr.setTelefono(rs.getString("telefono"));
                usr.setCorreo(rs.getString("correo"));
                usr.setIdGrupo(rs.getInt("idGrupo"));
                retorno = 1;
            }
            cn.CerrarConexion();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return retorno;
    }

    public HashMap obtenerPermiso(usuario usrp) {
        HashMap<String, String> dropPermiso = new HashMap();
        try {
            cn = new conexion();
            cn.AbrirConexion();
            String query = "SELECT p.idPermiso as id, p.nombre from permiso as p\n"
                    + "inner join grupo_permisos as gp on gp.idPermiso=p.idPermiso\n"
                    + "inner join usuario as u on u.idGrupo=gp.idGrupo \n"
                    + "where u.idGrupo='" + usrp.getIdGrupo() + "';";
            ResultSet consulta = cn.conexion.createStatement().executeQuery(query);

            while (consulta.next()) {
                dropPermiso.put(consulta.getString("id"), consulta.getString("nombre"));
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return dropPermiso;
    }   

    public DefaultTableModel listar() {
        DefaultTableModel tabla = new DefaultTableModel();
        String query = "select idUsuario,nombres,apellidos,direccion,telefono,correo,usuario,clave,estado,idGrupo from usuario;";
        String encabezado[] = {"Id", "Nombres", "Apellidos", "Dirección", "Teléfono", "Correo", "Usuario", "Contraseña", "Estado", "Grupo"};
        tabla.setColumnIdentifiers(encabezado);
        String datos[] = new String[10];
        try {
            cn = new conexion();
            cn.AbrirConexion();
            ResultSet consulta = cn.conexion.createStatement().executeQuery(query);
            while (consulta.next()) {
                datos[0] = consulta.getString("idUsuario");
                datos[1] = consulta.getString("nombres");
                datos[2] = consulta.getString("apellidos");
                datos[3] = consulta.getString("direccion");
                datos[4] = consulta.getString("telefono");
                datos[5] = consulta.getString("correo");
                datos[6] = consulta.getString("usuario");
                datos[7] = consulta.getString("clave");
                datos[8] = consulta.getString("estado");
                datos[9] = consulta.getString("idGrupo");
                tabla.addRow(datos);
            }
            cn.CerrarConexion();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return tabla;
    }
}

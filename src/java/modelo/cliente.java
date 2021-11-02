package modelo;

import controlador.conexion;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.swing.table.DefaultTableModel;

public class cliente extends persona {

    private String Nit;
    conexion cn = null;

    public cliente() {
    }

    public cliente(String Nit) {
        this.Nit = Nit;
    }

    public cliente(String Nit, int Id, String Nombres, String Apellidos, String Direccion, String Telefono, String Correo) {
        super(Id, Nombres, Apellidos, Direccion, Telefono, Correo);
        this.Nit = Nit;
    }

    public String getNit() {
        return Nit;
    }

    public void setNit(String Nit) {
        this.Nit = Nit;
    }

    public DefaultTableModel listar() {
        DefaultTableModel tabla = new DefaultTableModel();
        String query = "select IdCliente, Nit, nombres, apellidos, direccion, telefono, correo from clientes where estado=1 order by IdCliente asc;";
        String encabezado[] = {"Id", "Nit", "Nombres", "Apellidos", "Direccion", "Telefono", "Correo"};
        String datos[] = new String[7];
        tabla.setColumnIdentifiers(encabezado);

        try {
            cn = new conexion();
            cn.AbrirConexion();
            ResultSet consulta = cn.conexion.createStatement().executeQuery(query);
            while (consulta.next()) {
                datos[0] = consulta.getString("IdCliente");
                datos[1] = consulta.getString("Nit");
                datos[2] = consulta.getString("nombres");
                datos[3] = consulta.getString("apellidos");
                datos[4] = consulta.getString("direccion");
                datos[5] = consulta.getString("telefono");
                datos[6] = consulta.getString("correo");
                tabla.addRow(datos);
            }
            cn.CerrarConexion();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return tabla;
    }

    @Override
    public int agregar() {
        int retorno;
        try {
            cn = new conexion();
            PreparedStatement parametro;
            String query = "declare @idmax int;\n"
                    + "set @idmax=(select MAX(IdCliente)+1 from clientes);\n"
                    + "insert into clientes(IdCliente, Nit,nombres,apellidos,direccion,telefono,correo,estado)\n"
                    + "values (@idmax,?,?,?,?,?,?,1);";
            cn.AbrirConexion();

            parametro = (PreparedStatement) cn.conexion.prepareStatement(query);
            parametro.setString(1, getNit());
            parametro.setString(2, getNombres());
            parametro.setString(3, getApellidos());
            parametro.setString(4, getDireccion());
            parametro.setString(5, getTelefono());
            parametro.setString(6, getCorreo());
            retorno = parametro.executeUpdate();

            cn.CerrarConexion();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
            retorno = 0;
        }
        return retorno;
    }

    @Override
    public int modificar() {
        int retorno;
        try {
            cn = new conexion();
            PreparedStatement parametro;
            String query = "update clientes set Nit=?, nombres=?, apellidos=?, direccion=?, telefono=?, correo=? where IdCliente=?;";
            cn.AbrirConexion();

            parametro = (PreparedStatement) cn.conexion.prepareStatement(query);
            parametro.setString(1, getNit());
            parametro.setString(2, getNombres());
            parametro.setString(3, getApellidos());
            parametro.setString(4, getDireccion());
            parametro.setString(5, getTelefono());
            parametro.setString(6, getCorreo());
            parametro.setInt(7, getId());
            retorno = parametro.executeUpdate();

            cn.CerrarConexion();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
            retorno = 0;
        }
        return retorno;
    }

    @Override
    public int eliminar() {
        int retorno;
        try {
            cn = new conexion();
            PreparedStatement parametro;
            String query = "update clientes set estado=0 where IdCliente=?;";
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

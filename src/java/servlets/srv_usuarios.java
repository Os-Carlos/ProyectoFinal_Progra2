package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.usuario;

/**
 *
 * @author acer
 */
@WebServlet(name = "srv_usuario", urlPatterns = {"/srv_usuario"})
public class srv_usuarios extends HttpServlet {

    usuario datosusuario;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {

            //modificacion en el servelet por el constructo luego de seleccionar la opcion se agrega al grupo
            datosusuario = new usuario(request.getParameter("txt_usuario"),
                    request.getParameter("txt_contrasena"),
                    Integer.valueOf(request.getParameter("Drop_grupo")),
                    Integer.valueOf(request.getParameter("Drop_estado")),
                    Integer.valueOf(request.getParameter("txt_id")),
                    request.getParameter("txt_nombres"),
                    request.getParameter("txt_apellidos"),
                    request.getParameter("txt_direccion"),
                    request.getParameter("txt_telefono"),
                    request.getParameter("txt_correo"));

            if ("agregar".equals(request.getParameter("btn_agregar"))) {
                if (datosusuario.agregar() > 0) {
                    response.sendRedirect("vistas/frm_usuarios.jsp?accion=A");
                } else {
                    response.sendRedirect("vistas/frm_usuarios.jsp?accion=error");
                }
            }
            if ("modificar".equals(request.getParameter("btn_modificar"))) {
                if (datosusuario.modificar() > 0) {
                    response.sendRedirect("vistas/frm_usuarios.jsp?accion=M");
                } else {
                    response.sendRedirect("vistas/frm_usuarios.jsp?accion=error");
                }
            }
            if ("eliminar".equals(request.getParameter("btn_eliminar"))) {
                if (datosusuario.eliminar() > 0) {
                    response.sendRedirect("vistas/frm_usuarios.jsp?accion=E");
                } else {
                    response.sendRedirect("vistas/frm_usuarios.jsp?accion=error");
                }
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.cliente;

/**
 *
 * @author Usuario
 */
public class srv_clientes extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            cliente Dcliente = new cliente(request.getParameter("txt_nit"),
                    Integer.valueOf(request.getParameter("txt_id")),
                    request.getParameter("txt_nombres"),
                    request.getParameter("txt_apellidos"),
                    request.getParameter("txt_direccion"),
                    request.getParameter("txt_telefono"),
                    request.getParameter("txt_correo"));

            if ("agregar".equals(request.getParameter("btn_agregar"))) {
                if (Dcliente.agregar() > 0) {
                    response.sendRedirect("vistas/frm_clientes.jsp?accion=A");
                } else {
                    response.sendRedirect("vistas/frm_clientes.jsp?accion=error");
                }
            }
            if ("modificar".equals(request.getParameter("btn_modificar"))) {
                if (Dcliente.modificar() > 0) {
                    response.sendRedirect("vistas/frm_clientes.jsp?accion=M");
                } else {
                    response.sendRedirect("vistas/frm_clientes.jsp?accion=error");
                }
            }
            if ("eliminar".equals(request.getParameter("btn_eliminar"))) {
                if (Dcliente.eliminar() > 0) {
                    response.sendRedirect("vistas/frm_clientes.jsp?accion=E");
                } else {
                    response.sendRedirect("vistas/frm_clientes.jsp?accion=error");
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

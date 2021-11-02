package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.permiso;

/**
 *
 * @author ANDRES HERNANDEZ J
 */
public class srv_permisos extends HttpServlet {

    permiso permisos;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {

            permisos = new permiso(request.getParameter("txt_nombre"),
                    Integer.valueOf(request.getParameter("txt_id")));

            if ("agregar".equals(request.getParameter("btn_agregar"))) {
                if (permisos.agregar() > 0) {
                    response.sendRedirect("vistas/frm_permisos.jsp?accion=A");
                } else {
                    response.sendRedirect("vistas/frm_permisos.jsp?accion=error");
                }
            }
            if ("modificar".equals(request.getParameter("btn_modificar"))) {
                if (permisos.modificar() > 0) {
                    response.sendRedirect("vistas/frm_permisos.jsp?accion=M");
                } else {
                    response.sendRedirect("vistas/frm_permisos.jsp?accion=error");
                }
            }
            if ("eliminar".equals(request.getParameter("btn_eliminar"))) {
                if (permisos.eliminar() > 0) {
                    response.sendRedirect("vistas/frm_permisos.jsp?accion=E");
                } else {
                    response.sendRedirect("vistas/frm_permisos.jsp?accion=error");
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

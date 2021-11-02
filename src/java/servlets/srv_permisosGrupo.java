/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.GrupoPermisos;

/**
 *
 * @author ANDRES HERNANDEZ J
 */
public class srv_permisosGrupo extends HttpServlet {

    GrupoPermisos grupop;

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {

            grupop = new GrupoPermisos(Integer.valueOf(request.getParameter("Drop_grupo")),
                    Integer.valueOf(request.getParameter("Drop_permiso")),
                    Integer.valueOf(request.getParameter("txt_id")));

            if ("agregar".equals(request.getParameter("btn_agregar"))) {
                if (grupop.agregar() > 0) {
                    response.sendRedirect("vistas/frm_permisosGrupo.jsp?accion=A");
                } else {
                    response.sendRedirect("vistas/frm_permisosGrupo.jsp?accion=error");
                }
            }
            if ("modificar".equals(request.getParameter("btn_modificar"))) {
                if (grupop.modificar() > 0) {
                    response.sendRedirect("vistas/frm_permisosGrupo.jsp?accion=M");
                } else {
                    response.sendRedirect("vistas/frm_permisosGrupo.jsp?accion=error");
                }
            }
            if ("eliminar".equals(request.getParameter("btn_eliminar"))) {
                if (grupop.eliminar() > 0) {
                    response.sendRedirect("vistas/frm_permisosGrupo.jsp?accion=E");
                } else {
                    response.sendRedirect("vistas/frm_permisosGrupo.jsp?accion=error");
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

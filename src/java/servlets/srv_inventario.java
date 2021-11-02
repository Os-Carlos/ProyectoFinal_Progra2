/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.inventarioT;

/**
 *
 * @author acer
 */
@WebServlet(name = "srv_inventario", urlPatterns = {"/srv_inventario"})
public class srv_inventario extends HttpServlet {

    inventarioT inventarios;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {

            inventarios = new inventarioT(request.getParameter("txt_nombre"),
                    request.getParameter("txt_des"),
                    Integer.valueOf(request.getParameter("txt_id")),
                    Integer.valueOf(request.getParameter("txt_existencias")),
                    Float.valueOf(request.getParameter("txt_precio")));

            if ("agregar".equals(request.getParameter("btn_agregar"))) {
                if (inventarios.agregar() > 0) {
                    response.sendRedirect("vistas/frm_inventario.jsp?accion=A");
                } else {
                    response.sendRedirect("vistas/frm_inventario.jsp?accion=error");
                }
            }
            if ("modificar".equals(request.getParameter("btn_modificar"))) {
                if (inventarios.modificar() > 0) {
                    response.sendRedirect("vistas/frm_inventario.jsp?accion=M");
                } else {
                    response.sendRedirect("vistas/frm_inventario.jsp?accion=error");
                }
            }
            if ("eliminar".equals(request.getParameter("btn_eliminar"))) {
                if (inventarios.eliminar() > 0) {
                    response.sendRedirect("vistas/frm_inventario.jsp?accion=E");
                } else {
                    response.sendRedirect("vistas/frm_inventario.jsp?accion=error");
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

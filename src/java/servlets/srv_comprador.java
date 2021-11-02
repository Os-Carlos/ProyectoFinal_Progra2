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
import modelo.comprador;

/**
 *
 * @author Usuario
 */
public class srv_comprador extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    comprador Comprador;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            Comprador = new comprador(Integer.valueOf(request.getParameter("txt_idcompra")),
                    request.getParameter("txt_idproveedor"),
                    request.getParameter("txt_idfactura"),                                        
                    request.getParameter("txt_idcompradetalle"),
                    request.getParameter("txt_fecha"),
                    request.getParameter("txt_producto"),
                    request.getParameter("txt_cantidad"),
                    request.getParameter("txt_precio"));
           if ("agregar".equals(request.getParameter("btn_agregar"))) {
                if (Comprador.agregar() > 0) {
                    response.sendRedirect("vistas/frm_compras.jsp?accion=A");
                } else {
                    response.sendRedirect("vistas/frm_compras.jsp?accion=error");
                }
            }
            if ("modificar".equals(request.getParameter("btn_modificar"))) {
                if (Comprador.modificar() > 0) {
                    response.sendRedirect("vistas/frm_compras.jsp?accion=M");
                } else {
                    response.sendRedirect("vistas/frm_compras.jsp?accion=error");
                }
            }
            if ("eliminar".equals(request.getParameter("btn_eliminar"))) {
                if (Comprador.eliminar() > 0) {
                    response.sendRedirect("vistas/frm_compras.jsp?accion=E");
                } else {
                    response.sendRedirect("vistas/frm_compras.jsp?accion=error");
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

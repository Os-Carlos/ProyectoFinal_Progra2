package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.usuario;

public class srv_login extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            usuario usr = new usuario();            
            int validacion = 0;

            if (request.getParameter("btn_login") != null) {
                String usuario = request.getParameter("txt_usuario");
                String clave = request.getParameter("txt_clave");
                usr.setUsuario(usuario);
                usr.setClave(clave);

                try {
                    validacion = usr.validar(usr);
                } catch (Exception ex) {

                }
                if (validacion>0) {
                    request.getSession().setAttribute("id", usr.getId());
                    request.getSession().setAttribute("nombres", usr.getNombres());  
                    request.getSession().setAttribute("apellidos", usr.getApellidos());  
                    request.getSession().setAttribute("usuario", usr.getUsuario());                                                             
                    request.getSession().setAttribute("grupo", usr.getIdGrupo());
                    request.getSession().setAttribute("clave", clave);  
                    response.sendRedirect("vistas/menu.jsp");
                } else {
                    response.sendRedirect("index.jsp?msgLogin=error");
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

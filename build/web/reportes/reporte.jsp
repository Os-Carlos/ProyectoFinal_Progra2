<%-- 
    Document   : reporte
    Created on : 28/10/2021, 21:34:22
    Author     : Carlos Osorio
--%>
<%@page import ="java.io.*"%>
<%@page import ="java.util.*"%>
<%@page import ="net.sf.jasperreports.engine.*"%>
<%@page import ="net.sf.jasperreports.view.JasperViewer"%>
<%@page import ="javax.servlet.ServletResponse"%>
<%@page import ="net.sf.jasperreports.view.JasperViewer"%>
<%@page import ="java.sql.*"%>
<%@page import ="controlador.conexion"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">        
    </head>
    
    <body>
        <%
            String fecha1 = request.getParameter("txt_fecha1");
            String fecha2 = request.getParameter("txt_fecha2");
            Connection con;
            conexion cn = new conexion();
            cn.AbrirConexion();
            con = cn.ObtenerConexion();
            File reportfile = new File(application.getRealPath("reportes/reporteVentas.jasper")); // Ruta del reporte
            Map<String, Object> parameter = new HashMap<String, Object>();
            parameter.put("fecha1", new String(fecha1));
            parameter.put("fecha2", new String(fecha2));
            byte[] bytes = JasperRunManager.runReportToPdf(reportfile.getPath(), parameter, con);
            response.setContentType("application/pdf");
            response.setContentLength(bytes.length);
            ServletOutputStream outputstream = response.getOutputStream();
            outputstream.write(bytes, 0, bytes.length);
            outputstream.flush();
            outputstream.close();
        %>
    </body>
</html>

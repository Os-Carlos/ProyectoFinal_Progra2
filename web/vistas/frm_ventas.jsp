<%-- 
    Document   : index.jsp
    Created on : 17/10/2021, 23:47:23
    Author     : acer
--%>

<%@page import="javax.swing.table.DefaultTableModel"%>
<%@page import="modelo.ventas"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
        <link href="../recursos/estilos.css" rel="stylesheet" type="text/css"/>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>	
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    </head>

    <body>
        <nav class="navbar navbar-light my-0" style="background-color: #e3f2fd;"><h1>FORMULARIO VENTAS </h1></nav>  

        <!--alertas-->
        <div class="d-flex justify-content-center py-1" id="div_alertas">
            <%
                if (request.getParameter("accion") != null) {
                    if (request.getParameter("accion").equals("A")) {
                        out.println("<div class='alert alert-success alert-dismissible' role='alert'>");
                        out.println("Registro Realizado con Éxito!!");
                        out.println("<button type='button' class='close' data-dismiss='alert' aria-label='Close'><span aria-hidden='true'>&times;</span></button>");
                        out.println("</div>");
                    }
                    if (request.getParameter("accion").equals("M")) {
                        out.println("<div class='alert alert-info alert-dismissible' role='alert'>");
                        out.println("Registro Modificado con Éxito!!");
                        out.println("<button type='button' class='close' data-dismiss='alert' aria-label='Close'><span aria-hidden='true'>&times;</span></button>");
                        out.println("</div>");
                    }
                    if (request.getParameter("accion").equals("E")) {
                        out.println("<div class='alert alert-warning alert-dismissible' role='alert'>");
                        out.println("Registro Eliminado con Éxito!!");
                        out.println("<button type='button' class='close' data-dismiss='alert' aria-label='Close'><span aria-hidden='true'>&times;</span></button>");
                        out.println("</div>");
                    }
                    if (request.getParameter("accion").equals("error")) {
                        out.println("<div class='alert alert-danger alert-dismissible' role='alert'>");
                        out.println("Ha ocurrido un error!!");
                        out.println("<button type='button' class='close' data-dismiss='alert' aria-label='Close'><span aria-hidden='true'>&times;</span></button>");
                        out.println("</div>");
                    }
                }
            %>
        </div>

        <div class="container-fluid my-2 px-5">
            <div class="row" id="contenido">
                <div class="col">
                    <form action="../srv_ventas" method="POST">   
                        <label for="lbl_Idventa" id="lbl_venta" style="display:none"><b>Idventa</b></label>
                        <input type="text" class="form-control" name="txt_venta" id="txt_venta" style="display:none" readonly value="0">
                        <label for="lbl_fecha" ><b>Fecha</b></label>
                        <input type="date" class="form-control" name="txt_fecha" id="txt_fecha"required>
                        <label for="lbl_codigo" ><b>Codigo</b></label>
                        <input type="text" class="form-control" name="txt_codigo" id="txt_codigo"required>
                        <label for="lbl_idcliente" ><b>Id del Cliente</b></label>
                        <input type="text" class="form-control" name="txt_idcliente" id="txt_idcliente"required>
                        <br>
                        <button type="button" id="btn_limpiar" name="btn_limpiar" class="btn btn-primary" style="display:none" onclick="limpiar()"><i class="bi bi-eraser"></i>Limpiar</button> 
                        <button value="agregar" id="btn_agregar" name="btn_agregar" class="btn btn-success"><i class="bi bi-plus"></i>Agregar</button>                               
                        <button value="modificar" id="btn_modificar" name="btn_modificar" class="btn btn-warning" style="display:none"><i class="bi bi-pencil"></i>Modificar</button>                               
                        <button value="eliminar" id="btn_eliminar" name="btn_eliminar" class="btn btn-danger" style="display:none" onclick="javascript:if (!confirm('Desea eliminar este registro?'))
                                    return false"><i class="bi bi-trash"></i>Eliminar</button>                           
                    </form>                    

                    <!--formulario reportes-->
                    <div class="container py-4" style="text-align: center">
                        <label><b>Reporte de ventas</b></label>
                        <form action="../reportes/reporte.jsp">       
                            <div class="row">
                                <div class="col">
                                    <br><input type="date" class="form-control" name="txt_fecha1" id="txt_fecha1"required>
                                </div>
                                <div class="col">
                                    <br><input type="date" class="form-control" name="txt_fecha2" id="txt_fecha2"required>
                                </div>
                            </div>
                            <br><button value="generarReporte" id="btn_reporte" class="btn btn-info"><i class="bi bi-clipboard-data"></i>Generar Reporte</button>                               
                        </form>
                    </div>   

                </div>
                <div class="col">
                    <table class="table table-hover">
                        <thead align="center">
                            <tr>
                                <th>Idventa</th>
                                <th>Fecha</th>
                                <th>Codigo</th>
                                <th>Id_Cliente</th>
                            </tr>
                        </thead>
                        <tbody id="tbl_ventas" align="center">
                            <%
                                ventas venta = new ventas();
                                DefaultTableModel tabla = new DefaultTableModel();
                                tabla = venta.leer();
                                for (int t = 0; t < tabla.getRowCount(); t++) {
                                    out.println("<tr>");
                                    out.println("<td>" + tabla.getValueAt(t, 0) + "</td>");
                                    out.println("<td>" + tabla.getValueAt(t, 1) + "</td>");
                                    out.println("<td>" + tabla.getValueAt(t, 2) + "</td>");
                                    out.println("<td>" + tabla.getValueAt(t, 3) + "</td>");
                                    out.println("</tr>");
                                }
                            %>  
                        </tbody>
                    </table>
                </div>
            </div>



        </div>    

        <script type="text/javascript">
            function limpiar() {

                $("#txt_fecha").val('');
                $("#txt_codigo").val('');
                $("#txt_idcliente").val('');

                $("#txt_venta").hide(1);
                $("#lbl_venta").hide(1);
                $("#btn_limpiar").hide(1);
                $("#btn_modificar").hide(1);
                $("#btn_eliminar").hide(1);
                $("#btn_agregar").show(1);
            }

            $('#tbl_ventas').on('click', 'tr td', function (evt) {
                var target, Idventa, fecha, codigo, idcliente;
                target = $(event.target);

                Idventa = target.parent("tr").find("td").eq(0).html();
                fecha = target.parent("tr").find("td").eq(1).html();
                codigo = target.parent("tr").find("td").eq(2).html();
                idcliente = target.parent("tr").find("td").eq(3).html();
                $("#txt_venta").val(Idventa);
                $("#txt_fecha").val(fecha);
                $("#txt_codigo").val(codigo);
                $("#txt_idcliente").val(idcliente);

                $("#txt_venta").show(1);
                $("#lbl_venta").show(1);
                $("#btn_limpiar").show(1);
                $("#btn_modificar").show(1);
                $("#btn_eliminar").show(1);
                $("#btn_agregar").hide(1);

            });

        </script>
    </body>
</html>

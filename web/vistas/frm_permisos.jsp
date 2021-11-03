<%-- 
    Document   : index
    Created on : 30/09/2021, 10:31:53
    Author     : ANDRES HERNANDEZ J
--%>
<%@page import="modelo.permiso"%>

<%@page import="javax.swing.table.DefaultTableModel"%>
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

    <body >
        <nav class="navbar navbar-light justify-content-center my-0" style="background-color: #e3f2fd;"><h1>PERMISOS</h1></nav>  

        <!--alertas-->
        <div class="d-flex justify-content-center py-1" id="div_alertas">
            <%
                if (request.getParameter("accion") != null) {
                    if (request.getParameter("accion").equals("A")) {
                        out.println("<div class='alert alert-success alert-dismissible' role='alert'>");
                        out.println("Registro Realizado con �xito!!");
                        out.println("<button type='button' class='close' data-dismiss='alert' aria-label='Close'><span aria-hidden='true'>&times;</span></button>");
                        out.println("</div>");
                    }
                    if (request.getParameter("accion").equals("M")) {
                        out.println("<div class='alert alert-info alert-dismissible' role='alert'>");
                        out.println("Registro Modificado con �xito!!");
                        out.println("<button type='button' class='close' data-dismiss='alert' aria-label='Close'><span aria-hidden='true'>&times;</span></button>");
                        out.println("</div>");
                    }
                    if (request.getParameter("accion").equals("E")) {
                        out.println("<div class='alert alert-warning alert-dismissible' role='alert'>");
                        out.println("Registro Eliminado con �xito!!");
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

        <div class="container-fluid my-5 px-5">
            <div class="row" id="contenido">
                <div class="col">
                    <form action="../srv_permisos" method="POST">
                        <label for="lbl_id" id="lbl_id" style="display: none"><b>Id</b></label>
                        <input type="text" class="form-control " name="txt_id"  id="txt_id" readonly value="0" style="display: none">
                        <label for="lbl_nombre" ><b>Nombre</b></label>
                        <input type="text" class="form-control" name="txt_nombre" id="txt_nombre"  required>
                        <br>
                        <button type="button" id="btn_limpiar" name="btn_limpiar" class="btn btn-primary" style="display:none" onclick="limpiar()"><i class="bi bi-eraser"></i>Limpiar</button> 
                        <button value="agregar" id="btn_agregar" name="btn_agregar" class="btn btn-success"><i class="bi bi-plus"></i>Agregar</button>                               
                        <button value="modificar" id="btn_modificar" name="btn_modificar" class="btn btn-warning" style="display:none"><i class="bi bi-pencil"></i>Modificar</button>                               
                        <button value="eliminar" id="btn_eliminar" name="btn_eliminar" class="btn btn-danger" style="display:none" onclick="javascript:if (!confirm('Desea eliminar este registro?'))
                                    return false"><i class="bi bi-trash"></i>Eliminar</button> 
                    </form>
                </div>                
                <div class="col">
                    <table class="table table-hover">
                        <thead align="center">
                            <tr>
                                <th>ID</th>
                                <th>NOMBRE</th>                                
                            </tr>
                        </thead>
                        <tbody id="tbl_permisos" align="center">
                            <%
                                permiso p = new permiso();
                                DefaultTableModel tabla = new DefaultTableModel();
                                tabla = p.leer();
                                for (int t = 0; t < tabla.getRowCount(); t++) {
                                    out.println("<tr data-idp=" + tabla.getValueAt(t, 1) + ">");
                                    out.println("<td>" + tabla.getValueAt(t, 0) + "</td>");
                                    out.println("<td>" + tabla.getValueAt(t, 1) + "</td>");                                    
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

                $("#txt_nombre").val('');
                

                $("#lbl_id").hide(1);
                $("#txt_id").hide(1);
                $("#btn_limpiar").hide(1);
                $("#btn_modificar").hide(1);
                $("#btn_eliminar").hide(1);
                $("#btn_agregar").show(1);
            }

            $('#tbl_permisos').on('click', 'tr td', function (evt) {
                var target, idpermiso, nombres;
                target = $(event.target);
                idpermiso = target.parent("tr").find("td").eq(0).html();
                nombres = target.parent("tr").find("td").eq(1).html();
                
                $("#txt_id").val(idpermiso);
                $("#txt_nombre").val(nombres);
                

                $("#lbl_id").show(1);
                $("#txt_id").show(1);
                $("#btn_limpiar").show(1);
                $("#btn_modificar").show(1);
                $("#btn_eliminar").show(1);
                $("#btn_agregar").hide(1);
            });
        </script>
    </body>
</html>

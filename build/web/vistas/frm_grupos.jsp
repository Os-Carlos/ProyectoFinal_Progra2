<%-- 
    Document   : index.jsp
    Created on : 10/10/2021, 15:53:04
    Author     : alumno
--%>

<%@page import="javax.swing.table.DefaultTableModel"%>
<%@page import="modelo.GrupoUsuarios"%>
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

        <nav class="navbar navbar-light my-0" style="background-color: #e3f2fd;"><h1>FORMULARIO GRUPOS </h1></nav>  

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

        <div class="container-fluid py-5" style="padding-left: 90px">
            <div class="row">
                <div class="col">
                    <form action="../srv_Grupos" method="POST">   
                        <label for="lbl_IdGrupo" id="lbl_IdGrupo" style="display: none"><b>IdGrupo</b></label>
                        <input type="text" class="form-control" name="txt_IdGrupo" id="txt_IdGrupo" readonly value="0" style="display: none">
                        <label for="lbl_nombre" ><b>Nombre Grupo:</b></label>
                        <input type="text" class="form-control" name="txt_nombre" id="txt_nombre" required>      
                        </div>
                        <div class="col pt-4">                      
                            <button type="button" id="btn_limpiar" name="btn_limpiar" class="btn btn-primary" style="display:none" onclick="limpiar()"><i class="bi bi-eraser"></i>Limpiar</button> 
                            <button value="agregar" id="btn_agregar" name="btn_agregar" class="btn btn-success"><i class="bi bi-plus"></i>Agregar</button>                               
                            <button value="modificar" id="btn_modificar" name="btn_modificar" class="btn btn-warning" style="display:none"><i class="bi bi-pencil"></i>Modificar</button>                               
                            <br>
                            <br>
                            <button value="eliminar" id="btn_eliminar" name="btn_eliminar" class="btn btn-danger" style="display:none" onclick="javascript:if (!confirm('Desea eliminar este registro?'))
                                        return false"><i class="bi bi-trash"></i>Eliminar</button>
                        </div>
                    </form>              
                </div>
                <div class="row py-5">                    
                    <div class="col">
                        <table class="table table-hover" id="tbl_Grupousuarios" >
                            <thead align="center">
                                <tr>
                                    <th>IdGrupo</th>
                                    <th>nombre</th>
                                </tr>
                            </thead>
                            <tbody align="center">
                                <%
                                    GrupoUsuarios Gusuario = new GrupoUsuarios();
                                    DefaultTableModel tabla = new DefaultTableModel();
                                    tabla = Gusuario.leer();
                                    for (int t = 0; t < tabla.getRowCount(); t++) {
                                        out.println("<tr>");
                                        out.println("<td>" + tabla.getValueAt(t, 0) + "</td>");
                                        out.println("<td>" + tabla.getValueAt(t, 1) + "</td>");
                                        out.println("</tr>");

                                    }
                                %>  
                            </tbody>
                        </table>
                    </div>
                    <div class="col"></div>
                </div>
            </div>

            <script type="text/javascript">
                function limpiar() {

                    $("#txt_nombre").val('');

                    $("#lbl_IdGrupo").hide(1);
                    $("#txt_IdGrupo").hide(1);
                    $("#btn_limpiar").hide(1);
                    $("#btn_modificar").hide(1);
                    $("#btn_eliminar").hide(1);
                    $("#btn_agregar").show(1);
                }

                $('#tbl_Grupousuarios').on('click', 'tr td', function (evt) {
                    var target, IdGrupo, nombre;
                    target = $(event.target);

                    IdGrupo = target.parent("tr").find("td").eq(0).html();
                    nombre = target.parent("tr").find("td").eq(1).html();
                    $("#txt_IdGrupo").val(IdGrupo);
                    $("#txt_nombre").val(nombre);

                    $("#lbl_IdGrupo").show(1);
                    $("#txt_IdGrupo").show(1);
                    $("#btn_limpiar").show(1);
                    $("#btn_modificar").show(1);
                    $("#btn_eliminar").show(1);
                    $("#btn_agregar").hide(1);
                });
            </script>
    </body>
</html>

<%-- 
    Document   : grupop
    Created on : 13/10/2021, 16:31:05
    Author     : ANDRES HERNANDEZ J
--%>

<%@page import="javax.swing.table.DefaultTableModel"%>
<%@page import="modelo.GrupoPermisos"%>
<%@page import="java.util.HashMap"%>
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
        <nav class="navbar navbar-light my-0" style="background-color: #e3f2fd;"><h1>FORMULARIO PERMISOS DE GRUPO </h1></nav>  

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

        <div class="container-fluid my-3 px-5">
            <div class="row" id="contenido">
                <div class="col">
                    <form action="../srv_permisosGrupo" method="POST">   
                        <label for="txt_id" id="lbl_id" style="display: none"><b>Id Grupo Permiso</b></label>
                        <input type="text" class="form-control" name="txt_id" id="txt_id" style="display: none" readonly value="0">
                        <label for="lbl_nombre" ><b>GRUPO</b></label>
                        <select name="Drop_grupo" id="Drop_grupo" class="form-control">       
                            <%
                                GrupoPermisos Tusuario = new GrupoPermisos();
                                HashMap<String, String> Utipo = Tusuario.Grupo();
                                for (String i : Utipo.keySet()) {
                                    out.println("<option value='" + i + "'>" + Utipo.get(i) + "</option>");
                                }
                            %>
                        </select>
                        <label for="lbl_nombre" ><b>PERMISO PARA GRUPO</b></label>
                        <select name="Drop_permiso" id="Drop_permiso" class="form-control">       
                            <%
                                GrupoPermisos perm = new GrupoPermisos();
                                HashMap<String, String> perms = perm.Permiso();
                                for (String i : perms.keySet()) {
                                    out.println("<option value='" + i + "'>" + perms.get(i) + "</option>");
                                }
                            %>
                        </select>
                        <br>
                        <button type="button" id="btn_limpiar" name="btn_limpiar" class="btn btn-primary" style="display:none" onclick="limpiar()"><i class="bi bi-eraser"></i>Limpiar</button> 
                        <button value="agregar" id="btn_agregar" name="btn_agregar" class="btn btn-success"><i class="bi bi-plus"></i>Agregar</button>                               
                        <button value="modificar" id="btn_modificar" name="btn_modificar" class="btn btn-warning" style="display:none"><i class="bi bi-pencil"></i>Modificar</button>                               
                        <button value="eliminar" id="btn_eliminar" name="btn_eliminar" class="btn btn-danger" style="display:none" onclick="javascript:if (!confirm('Desea eliminar este registro?'))
                                    return false"><i class="bi bi-trash"></i>Eliminar</button> 
                    </form>
                    </form>
                </div>
                <div class="col">
                    <div class="table-responsive" style="max-height: 500px">
                        <table class="table table-hover">
                            <thead align="center">
                                <tr>
                                    <th>Id</th>
                                    <th style="display: none">IdGRUPO</th>
                                    <th>GRUPO</th>
                                    <th style="display: none">IdPERMISO</th>
                                    <th>PERMISOS</th>
                                </tr>
                            </thead>
                            <tbody id="tbl_Grupousuarios" align="center">
                                <%
                                    GrupoPermisos Gp = new GrupoPermisos();
                                    DefaultTableModel tabla = new DefaultTableModel();
                                    tabla = Gp.leer();
                                    for (int t = 0; t < tabla.getRowCount(); t++) {
                                        out.println("<tr>");
                                        out.println("<td>" + tabla.getValueAt(t, 0) + "</td>");
                                        out.println("<td style='display: none'>" + tabla.getValueAt(t, 1) + "</td>");
                                        out.println("<td>" + tabla.getValueAt(t, 2) + "</td>");
                                        out.println("<td style='display: none'>" + tabla.getValueAt(t, 3) + "</td>");
                                        out.println("<td>" + tabla.getValueAt(t, 4) + "</td>");
                                        out.println("</tr>");
                                    }
                                %>  
                            </tbody>
                        </table>
                    </div>                    
                </div>
            </div>
        </div>    
        <script type="text/javascript">
            function limpiar() {
                $("#Drop_grupo").val('');
                $("#Drop_permiso").val('');


                $("#lbl_id").hide(1);
                $("#txt_id").hide(1);
                $("#btn_limpiar").hide(1);
                $("#btn_modificar").hide(1);
                $("#btn_eliminar").hide(1);
                $("#btn_agregar").show(1);
            }

            $('#tbl_Grupousuarios').on('click', 'tr td', function (evt) {
                var target, IdGrupoP, grupo, permisos;
                target = $(event.target);

                IdGrupoP = target.parent("tr").find("td").eq(0).html();
                grupo = target.parent("tr").find("td").eq(1).html();
                permisos = target.parent("tr").find("td").eq(3).html();

                $("#Drop_grupo").val(grupo);
                $("#Drop_permiso").val(permisos);
                $("#txt_id").val(IdGrupoP);

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

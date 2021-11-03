<%-- 
    Document   : index.jsp
    Created on : 7/10/2021, 14:24:43
    Author     : acer
--%>
<%@page import="modelo.usuario"%>
<%@page import="javax.swing.table.DefaultTableModel"%>
<%@page import="modelo.GrupoUsuarios"%>
<%@page import="java.util.HashMap"%>
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
        <nav class="navbar navbar-light justify-content-center my-0" style="background-color: #e3f2fd;"><h1>USUARIOS</h1></nav>  

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
            <div class="row"  id="contenido">
                <div  class="col">             
                    <form action="../srv_usuarios" method="POST">
                        <div class="row"  style="display: none" id="div_id">
                            <div class="col">
                                <label for="lbl_id" id="lbl_id"><b>Id</b></label>
                                <input type="text" class="form-control" name="txt_id" id="txt_id" readonly value="0">
                            </div>
                            <div class="col"></div>
                            <div class="col"></div>
                            <div class="col"></div>
                        </div> 

                        <label for="lbl_nombres" ><b>Nombres</b></label>
                        <input type="text" class="form-control" name="txt_nombres" id="txt_nombres" required>
                        <label for="lbl_apellidos" ><b>Apellidos</b></label>
                        <input type="text" class="form-control" name="txt_apellidos" id="txt_apellidos" required>
                        <label for="lbl_direccion" ><b>Dirección</b></label>
                        <input type="text" class="form-control" name="txt_direccion" id="txt_direccion" required>
                        <label for="lbl_telefono" ><b>Teléfono</b></label>
                        <input type="text" class="form-control" name="txt_telefono" id="txt_telefono" required> 
                        <label for="lbl_correo" ><b>Correo</b></label>
                        <input type="email" class="form-control" name="txt_correo" id="txt_correo" required>

                        <div class="row">
                            <div class="col">
                                <label for="lbl_usuario" ><b>Usuario</b></label>
                                <input type="text" class="form-control" name="txt_usuario" id="txt_usuario"  required>
                            </div>
                            <div class="col">
                                <label for="lbl_contraseña" ><b>Contraseña</b></label>
                                <input type="text" class="form-control" name="txt_contrasena" id="txt_contrasena"  required>
                            </div>                            
                        </div> 

                        <div class="row">
                            <div class="col">
                                <label for="lbl_estado" ><b>Estado</b></label>
                                <select name="Drop_estado" id=Drop_estado class="form-control" required>
                                    <option value=1 >Activo</option>
                                    <option value=0 >Inactivo</option>
                                </select>
                            </div>
                            <div class="col">
                                <label for="lbl_grupo" ><b>Grupo</b></label>
                                <select name="Drop_grupo" id="Drop_grupo" class="form-control" required>       
                                    <%
                                        GrupoUsuarios Tusuario = new GrupoUsuarios();
                                        HashMap<String, String> Utipo = Tusuario.TipoU();
                                        for (String i : Utipo.keySet()) {
                                            out.println("<option value='" + i + "'>" + Utipo.get(i) + "</option>");
                                        }
                                    %>
                                </select>
                            </div>                            
                        </div> 
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
                                <th>Id</th>
                                <th style="display: none">Nombres</th>
                                <th style="display: none">Apellidos</th>
                                <th style="display: none">Dirección</th>  
                                <th style="display: none">Teléfono</th>
                                <th style="display: none">Correo</th>
                                <th>Usuario</th>
                                <th>Contraseña</th>
                                <th>Estado</th>
                                <th style="display: none">Grupo</th>
                            </tr>
                        </thead>
                        <tbody id="tbl_usuarios" align="center">
                            <%
                                usuario usuario = new usuario();
                                DefaultTableModel tabla = new DefaultTableModel();
                                tabla = usuario.listar();
                                for (int t = 0; t < tabla.getRowCount(); t++) {
                                    out.println("<tr>");
                                    out.println("<td>" + tabla.getValueAt(t, 0) + "</td>");
                                    out.println("<td style='display: none'>" + tabla.getValueAt(t, 1) + "</td>");
                                    out.println("<td style='display: none'>" + tabla.getValueAt(t, 2) + "</td>");
                                    out.println("<td style='display: none'>" + tabla.getValueAt(t, 3) + "</td>");
                                    out.println("<td style='display: none'>" + tabla.getValueAt(t, 4) + "</td>");
                                    out.println("<td style='display: none'>" + tabla.getValueAt(t, 5) + "</td>");
                                    out.println("<td>" + tabla.getValueAt(t, 6) + "</td>");
                                    out.println("<td>" + tabla.getValueAt(t, 7) + "</td>");
                                    out.println("<td>" + tabla.getValueAt(t, 8) + "</td>");
                                    out.println("<td style='display: none'>" + tabla.getValueAt(t, 9) + "</td>");
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

                $("#txt_nombres").val('');
                $("#txt_apellidos").val('');
                $("#txt_direccion").val('');
                $("#txt_telefono").val('');
                $("#txt_correo").val('');
                $("#txt_usuario").val('');
                $("#txt_contrasena").val('');
                $("#Drop_estado").val('');
                $("#Drop_grupo").val('');

                $("#div_id").hide(1);
                $("#btn_limpiar").hide(1);
                $("#btn_modificar").hide(1);
                $("#btn_eliminar").hide(1);
                $("#btn_agregar").show(1);
            }

            $('#tbl_usuarios').on('click', 'tr td', function (evt) {
                var target, id, nombres, apellidos, direccion, telefono, correo, usuario, clave, Estado, grupo;
                target = $(event.target);
                id = target.parent("tr").find("td").eq(0).html();
                nombres = target.parent("tr").find("td").eq(1).html();
                apellidos = target.parent("tr").find("td").eq(2).html();
                direccion = target.parent("tr").find("td").eq(3).html();
                telefono = target.parent("tr").find("td").eq(4).html();
                correo = target.parent("tr").find("td").eq(5).html();
                usuario = target.parent("tr").find("td").eq(6).html();
                clave = target.parent("tr").find("td").eq(7).html();
                Estado = target.parent("tr").find("td").eq(8).html();
                grupo = target.parent("tr").find("td").eq(9).html();
                $("#txt_id").val(id);
                $("#txt_nombres").val(nombres);
                $("#txt_apellidos").val(apellidos);
                $("#txt_direccion").val(direccion);
                $("#txt_telefono").val(telefono);
                $("#txt_correo").val(correo);
                $("#txt_usuario").val(usuario);
                $("#txt_contrasena").val(clave);
                $("#Drop_estado").val(Estado);
                $("#Drop_grupo").val(grupo);

                $("#div_id").show(1);
                $("#btn_limpiar").show(1);
                $("#btn_modificar").show(1);
                $("#btn_eliminar").show(1);
                $("#btn_agregar").hide(1);
            });
        </script>
    </body>                         
</html>

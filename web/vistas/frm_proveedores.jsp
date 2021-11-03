<%-- 
    Document   : index
    Created on : 31/10/2021, 17:37:24
    Author     : Jader
--%>

<%@page import="modelo.proveedor" %>
<%@page import="javax.swing.table.DefaultTableModel" %>

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
        <nav class="navbar navbar-light justify-content-center my-0" style="background-color: #e3f2fd;"><h1>PROVEEDORES</h1></nav>  

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
                    <form action="../srv_proveedor" method="post" class="form-group">
                        <label for="lbl_idproveedor" id="lbl_idproveedor" style="display: none"><b>Id Proveedor</b></label>
                        <input type="text" name="txt_idproveedor" id="txt_idproveedor" class="form-control" value="0"readonly style="display: none">
                        <label for="lbl_idpersona"><b>Id Persona</b></label>
                        <input type="text" name="txt_idpersona" id="txt_idpersona" class="form-control" placeholder="Ejemplo: A001" required>
                        <label for="lbl_telefono"><b>Telefono</b></label>
                        <input type="text" name="txt_telefono" id="txt_telefono" class="form-control" placeholder="Ejemplo: 78315685" required>
                        <label for="lbl_nombreempresa"><b>Nombre de la Empresa</b></label>
                        <input type="text" name="txt_nombreempresa" id="txt_nombreempresa" class="form-control" placeholder="Ejemplo:Logitech" required>
                        <br>
                        <button type="button" id="btn_limpiar" name="btn_limpiar" class="btn btn-primary" style="display:none" onclick="limpiar()"><i class="bi bi-eraser"></i>Limpiar</button> 
                        <button value="agregar" id="btn_agregar" name="btn_agregar" class="btn btn-success"><i class="bi bi-plus"></i>Agregar</button>                               
                        <button value="modificar" id="btn_modificar" name="btn_modificar" class="btn btn-warning" style="display:none"><i class="bi bi-pencil"></i>Modificar</button>                               
                        <button value="eliminar" id="btn_eliminar" name="btn_eliminar" class="btn btn-danger" style="display:none; margin-left: 10px" onclick="javascript:if (!confirm('Desea eliminar este registro?'))
                                    return false"><i class="bi bi-trash"></i>Eliminar</button> 
                    </form>
                </div>

                <div class="col">
                    <div class="table-responsive" style="max-height: 500px">
                        <table class="table table-hover">
                            <thead align="center">
                                <tr>
                                    <th>Id Persona</th>
                                    <th>Teléfono</th>
                                    <th>Empresa</th>
                                </tr>
                            </thead>
                            <tbody id="tbl_proveedores" align="center">
                                <%
                                    proveedor Proveedor = new proveedor();
                                    DefaultTableModel tabla = new DefaultTableModel();
                                    tabla = Proveedor.leer();
                                    for (int t = 0; t < tabla.getRowCount(); t++) {
                                        out.println("<tr data-idproveedor=" + tabla.getValueAt(t, 0) + ">");
                                        out.println("<td>" + tabla.getValueAt(t, 1) + "</td>");
                                        out.println("<td>" + tabla.getValueAt(t, 2) + "</td>");
                                        out.println("<td>" + tabla.getValueAt(t, 3) + "</td>");
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

                $("#txt_idpersona").val('');
                $("#txt_telefono").val('');
                $("#txt_nombreempresa").val('');

                $("#lbl_idproveedor").hide(1);
                $("#txt_idproveedor").hide(1);
                $("#btn_limpiar").hide(1);
                $("#btn_modificar").hide(1);
                $("#btn_eliminar").hide(1);
                $("#btn_agregar").show(1);
            }

            $('#tbl_proveedores').on('click', 'tr td', function (evt) {
                var target, idproveedor, idpersona, telefono, nombreempresa;
                target = $(event.target);
                idproveedor = target.parent().data('idproveedor');
                idpersona = target.parent("tr").find("td").eq(0).html();
                telefono = target.parent("tr").find("td").eq(1).html();
                nombreempresa = target.parent("tr").find("td").eq(2).html();
                $("#txt_idproveedor").val(idproveedor);
                $("#txt_idpersona").val(idpersona);
                $("#txt_telefono").val(telefono);
                $("#txt_nombreempresa").val(nombreempresa);

                $("#lbl_idproveedor").show(1);
                $("#txt_idproveedor").show(1);
                $("#btn_limpiar").show(1);
                $("#btn_modificar").show(1);
                $("#btn_eliminar").show(1);
                $("#btn_agregar").hide(1);
            });
        </script>
    </body>
</html>

<%-- 
    Document   : index.jsp
    Created on : 18/10/2021, 00:28:54
    Author     : acer
--%>

<%@page import="modelo.inventarioT"%>
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

    <body>
        <nav class="navbar navbar-light justify-content-center my-0" style="background-color: #e3f2fd;"><h1>INVENTARIO</h1></nav>  

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
                    <form action="../srv_inventario" method="POST">   
                        <label for="lbl_id" id="lbl_id" style="display:none"><b>Id</b></label>
                        <input type="text" class="form-control" name="txt_id" id="txt_id" style="display:none" readonly value="0">
                        <label for="lbl_nombre" ><b>Nombre</b></label>
                        <input type="text" class="form-control" name="txt_nombre" id="txt_nombre"  required>
                        <label for="lbl_existencias" ><b>Existencias</b></label>
                        <input type="text" class="form-control" name="txt_existencias" id="txt_existencias"  required>
                        <label for="lbl_precio" ><b>Precio (Q)</b></label>
                        <input type="text" class="form-control" name="txt_precio" id="txt_precio"  required>
                        <label for="lbl_des" ><b>Descripción</b></label>
                        <input type="text" class="form-control" name="txt_des" id="txt_des"  required>
                        <br>
                        <button type="button" id="btn_limpiar" name="btn_limpiar" class="btn btn-primary" style="display:none" onclick="limpiar()"><i class="bi bi-eraser"></i>Limpiar</button> 
                        <button value="agregar" id="btn_agregar" name="btn_agregar" class="btn btn-success"><i class="bi bi-plus"></i>Agregar</button>                               
                        <button value="modificar" id="btn_modificar" name="btn_modificar" class="btn btn-warning" style="display:none"><i class="bi bi-pencil"></i>Modificar</button>                               
                        <button value="eliminar" id="btn_eliminar" name="btn_eliminar" class="btn btn-danger" style="display:none" onclick="javascript:if (!confirm('Desea eliminar este registro?'))
                                    return false"><i class="bi bi-trash"></i>Eliminar</button>
                    </form>
                </div>
                <div class="col">
                    <div class="table-responsive" style="max-height: 500px">
                        <table class="table table-hover">
                            <thead align="center">
                                <tr>
                                    <th>Id</th>
                                    <th>Nombre</th>
                                    <th>Existencias</th>
                                    <th>Precio (Q)</th>
                                    <th>Descripción</th>
                                </tr>
                            </thead>
                            <tbody id="tbl_inventario" align="center">
                                <%
                                    inventarioT inventario = new inventarioT();
                                    DefaultTableModel tabla = new DefaultTableModel();
                                    tabla = inventario.leer();
                                    for (int t = 0; t < tabla.getRowCount(); t++) {
                                        out.println("<td>" + tabla.getValueAt(t, 0) + "</td>");
                                        out.println("<td>" + tabla.getValueAt(t, 1) + "</td>");
                                        out.println("<td>" + tabla.getValueAt(t, 2) + "</td>");
                                        out.println("<td>" + tabla.getValueAt(t, 3) + "</td>");
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

                $("#txt_nombre").val('');
                $("#txt_existencias").val('');
                $("#txt_precio").val('');
                $("#txt_des").val('');

                $("#lbl_id").hide(1);
                $("#txt_id").hide(1);
                $("#btn_limpiar").hide(1);
                $("#btn_modificar").hide(1);
                $("#btn_eliminar").hide(1);
                $("#btn_agregar").show(1);
            }
            $('#tbl_inventario').on('click', 'tr td', function (evt) {
                var target, idinventario, nombre, cantidad, precio, descripcion;
                target = $(event.target);
                idinventario = target.parent("tr").find("td").eq(0).html();
                nombre = target.parent("tr").find("td").eq(1).html();
                cantidad = target.parent("tr").find("td").eq(2).html();
                precio = target.parent("tr").find("td").eq(3).html();
                descripcion = target.parent("tr").find("td").eq(4).html();

                $("#txt_id").val(idinventario);
                $("#txt_nombre").val(nombre);
                $("#txt_existencias").val(cantidad);
                $("#txt_precio").val(precio);
                $("#txt_des").val(descripcion);

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
<%-- 
    Document   : index
    Created on : 31/10/2021, 17:37:24
    Author     : Jader
--%>

<%@page import="modelo.comprador" %>
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
        <nav class="navbar navbar-light justify-content-center my-0 justify-content-center" style="background-color: #e3f2fd;"><h1>COMPRAS</h1></nav>  

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
                    <form action="../srv_comprador" method="post" class="form-group">
                        <label for="lbl_idcompra" id="lbl_idcompra"  style="display: none"><b>Id compra</b></label>
                        <input type="text" name="txt_idcompra" id="txt_idcompra" class="form-control" value="0"readonly style="display: none">
                        <label for="lbl_idfactura"><b>N# Factura</b></label>
                        <input type="text" name="txt_idfactura" id="txt_idfactura" class="form-control" placeholder="Ejemplo: A001" required>
                        <label for="lbl_idproveedor"><b>Codigo del proveedor</b></label>
                        <input type="text" name="txt_idproveedor" id="txt_idproveedor" class="form-control" placeholder="Ejemplo: 001" required>
                        <label for="lbl_idcompradetalle"><b>Id Detalle de la compra </b></label>
                        <input type="text" name="txt_idcompradetalle" id="txt_idcompradetalle" class="form-control" placeholder="Ejemplo:DC001" required>
                        <label for="lbl_fecha" ><b>Fecha </b></label>
                        <input type="date"  name="txt_fecha" id="txt_fecha" class="form-control" required>
                        <label for="lbl_idproducto"><b>producto</b></label>
                        <input type="text" name="txt_producto" id="txt_producto" class="form-control" placeholder="Ejemplo:Galletas" required>

                        <div class="row">
                            <div class="col">
                                <label for="lbl_cantidad"><b>Cantidades</b></label>
                                <input type="text" name="txt_cantidad" id="txt_cantidad" class="form-control" placeholder="Ejemplo: 10" required>
                            </div>
                            <div class="col">
                                <label for="lbl_idfactura"><b>Precio</b></label>
                                <input type="text" name="txt_precio" id="txt_precio" class="form-control" placeholder="Ejemplo: 100" required>
                            </div>
                        </div>

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
                            <thead align="center" class="align-middle">
                                <tr>
                                    <th>
                                        Id
                                        Factura
                                    </th>
                                    <th>
                                        Id 
                                        Proveedor
                                    </th>
                                    <th>
                                        Id
                                        Compra
                                        Detalle
                                    </th>
                                    <th>Fecha</th>
                                    <th>Producto</th>
                                    <th>Cantidad</th>
                                    <th>Precio</th>
                                </tr>
                            </thead>
                            <tbody id="tbl_compradores" align="center" class="align-middle">
                                <%
                                    comprador Comprador = new comprador();
                                    DefaultTableModel tabla = new DefaultTableModel();
                                    tabla = Comprador.leer();
                                    for (int t = 0; t < tabla.getRowCount(); t++) {
                                        out.println("<tr data-idcompra=" + tabla.getValueAt(t, 0) + ">");
                                        out.println("<td>" + tabla.getValueAt(t, 1) + "</td>");
                                        out.println("<td>" + tabla.getValueAt(t, 2) + "</td>");
                                        out.println("<td>" + tabla.getValueAt(t, 3) + "</td>");
                                        out.println("<td>" + tabla.getValueAt(t, 4) + "</td>");
                                        out.println("<td>" + tabla.getValueAt(t, 5) + "</td>");
                                        out.println("<td>" + tabla.getValueAt(t, 6) + "</td>");
                                        out.println("<td>" + tabla.getValueAt(t, 7) + "</td>");
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

                $("#txt_idfactura").val('');
                $("#txt_idproveedor").val('');
                $("#txt_idcompradetalle").val('');
                $("#txt_fecha").val('');
                $("#txt_producto").val('');
                $("#txt_cantidad").val('');
                $("#txt_precio").val('');

                $("#lbl_idcompra").hide(1);
                $("#txt_idcompra").hide(1);
                $("#btn_limpiar").hide(1);
                $("#btn_modificar").hide(1);
                $("#btn_eliminar").hide(1);
                $("#btn_agregar").show(1);
            }
            $('#tbl_compradores').on('click', 'tr td', function (evt) {
                var target, idcompra, idfactura, idproveedor, idcompradetalle, fecha, producto, cantidad, precio;
                target = $(event.target);
                idcompra = target.parent().data('idcompra');
                idfactura = target.parent("tr").find("td").eq(0).html();
                idproveedor = target.parent("tr").find("td").eq(1).html();
                idcompradetalle = target.parent("tr").find("td").eq(2).html();
                fecha = target.parent("tr").find("td").eq(3).html();
                producto = target.parent("tr").find("td").eq(4).html();
                cantidad = target.parent("tr").find("td").eq(5).html();
                precio = target.parent("tr").find("td").eq(6).html();
                $("#txt_idcompra").val(idcompra);
                $("#txt_idfactura").val(idfactura);
                $("#txt_idproveedor").val(idproveedor);
                $("#txt_idcompradetalle").val(idcompradetalle);
                $("#txt_fecha").val(fecha);
                $("#txt_producto").val(producto);
                $("#txt_cantidad").val(cantidad);
                $("#txt_precio").val(precio);

                $("#lbl_idcompra").show(1);
                $("#txt_idcompra").show(1);
                $("#btn_limpiar").show(1);
                $("#btn_modificar").show(1);
                $("#btn_eliminar").show(1);
                $("#btn_agregar").hide(1);
            });
        </script>
    </body>
</html>

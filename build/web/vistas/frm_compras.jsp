<%-- 
    Document   : index
    Created on : 31/10/2021, 17:37:24
    Author     : Jader
--%>

<%@page import="modelo.comprador" %>
<%@page import="javax.swing.table.DefaultTableModel" %>
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
        <div class="jumbotron text-center">
            <h4 class="text-success">Solicitud de Compras</h4>
        </div>
        <div class="container">
            <form action="srvcomprador" method="post" class="form-group">

                <label for="lbl_idcompra"><b>Id compra</b></label>
                <input type="text" name="txt_idcompra" id="txt_idcompra" class="form-control" value="0"readonly>


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

                <label for="lbl_cantidad"><b>Cantidades</b></label>
                <input type="text" name="txt_cantidad" id="txt_cantidad" class="form-control" placeholder="Ejemplo: 10" required>

                <label for="lbl_idfactura"><b>Precio</b></label>
                <input type="text" name="txt_precio" id="txt_precio" class="form-control" placeholder="Ejemplo: 100" required>

                <br>

                <button name="btn_agregar" id="btn_agregar"  value="agregar" class="btn btn-primary btn-lg">Agregar</button>
                <button name="btn_modificar" id="btn_modificar"  value="modificar" class="btn btn-warning btn-lg">Modificar</button>
                <button name="btn_eliminar" id="btn_eliminar"  value="eliminar" class="btn btn-danger btn-lg" onclick="javascript:if (!confirm('!Desea eliminar?!'))
                            return false">Eliminar</button>

            </form>
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>idfactura</th>
                        <th>idproveedor</th>
                        <th>idcompradetalle</th>
                        <th>fecha</th>
                        <th>producto</th>
                        <th>cantidad</th>
                        <th>precio</th>
                    </tr>
                </thead>
                <tbody id="tbl_compradores">
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

        <script type="text/javascript">

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

                    });

        </script>




    </body>
</html>

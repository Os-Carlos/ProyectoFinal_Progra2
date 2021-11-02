<%@page import="modelo.cliente"%>
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

    <body id="body_frm_clientes" style="overflow: hidden">        
        <div class="container-fluid" style="margin: 0 !important; padding: 0!important">   

            <!--ventana modal-->
            <div class="modal" id="ModalCliente">
                <div class="modal-dialog">
                    <div class="modal-content">                            
                        <div class="modal-body">
                            <form action="../srv_clientes" method="POST">       
                                <div class="row">                                        
                                    <div class="col" style="display:none" id="div_id">
                                        <label for="lbl_id" id="lbl_id"><b>Id</b></label>
                                        <input type="text" class="form-control" name="txt_id" id="txt_id" readonly value="0">
                                    </div>
                                    <div class="col">
                                        <label for="lbl_nit"><b>Nit</b></label>
                                        <input type="text" class="form-control" name="txt_nit" id="txt_nit" required>
                                    </div>                                        
                                </div>    
                                <label for="lbl_nombres"><b>Nombres</b></label>                                        
                                <input type="text" class="form-control" name="txt_nombres" id="txt_nombres" required>
                                <label for="lbl_apellidos"><b>Apellidos</b></label>                                        
                                <input type="text" class="form-control" name="txt_apellidos" id="txt_apellidos" required>
                                <label for="lbl_direccion"><b>Dirección</b></label>
                                <input type="text" class="form-control" name="txt_direccion" id="txt_direccion" required>                                                                                                
                                <label for="lbl_telefono"><b>Teléfono</b></label>
                                <input type="text" class="form-control" name="txt_telefono" id="txt_telefono" required>
                                <label for="lbl_correo"><b>Correo</b></label>
                                <input type="email" class="form-control" name="txt_correo" id="txt_correo" placeholder="ejemplo@dominio.com" required>
                                <br>                                    
                                <button value="agregar" id="btn_agregar" name="btn_agregar" class="btn btn-success"><i class="bi bi-plus"></i>Agregar</button>                               
                                <button value="modificar" id="btn_modificar" name="btn_modificar" class="btn btn-warning" style="display:none"><i class="bi bi-pencil"></i>Modificar</button>                               
                                <button value="eliminar" id="btn_eliminar" name="btn_eliminar" class="btn btn-danger" style="display:none; margin-left: 10px" onclick="javascript:if (!confirm('Desea eliminar este registro?'))
                                            return false"><i class="bi bi-trash"></i>Eliminar</button>                                                           
                            </form> 
                        </div>
                    </div>
                </div>
            </div>           

            <!--barra de busqueda-->
            <nav class="navbar navbar-light my-0" style="background-color: #e3f2fd;">  
                <div class="container">
                    <h3 style="color: #000000;">Clientes</h3>
                    <div class="input-group w-50">
                        <span class="input-group-text">
                            <i class="bi bi-search"></i>
                        </span>
                        <input type="text" placeholder="Buscar" id="txt_buscarCliente" name="txt_buscarCliente" onkeyup="buscar()" class="form-control">        
                    </div>
                    <button type="button" data-toggle="modal" data-target="#ModalCliente" onclick="limpiar()" id="btn_nuevo" name="btn_nuevo" class="btn btn-primary"><i class="bi bi-person-plus"></i>Nuevo</button>               
                </div>
            </nav>

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

            <!--tabla clientes-->
            <div class="table-responsive px-3 pt-3" id="div_tbl_clientes">
                <table class="table table-hover" id="tbl_clientes">                    
                    <thead align="center">
                        <tr>
                            <th>Id</th>
                            <th>Nit</th>
                            <th>Nombres</th>
                            <th>Apellidos</th>
                            <th>Dirección</th>
                            <th>Teléfono</th>
                            <th>Correo</th>
                        </tr>
                    </thead>
                    <tbody align="center" class="align-middle">
                        <%
                            cliente datoscliente = new cliente();
                            DefaultTableModel tabla = new DefaultTableModel();
                            tabla = datoscliente.listar();
                            for (int t = 0; t < tabla.getRowCount(); t++) {
                                out.println("<tr>");
                                out.println("<td>" + tabla.getValueAt(t, 0) + "</td>");
                                out.println("<td>" + tabla.getValueAt(t, 1) + "</td>");
                                out.println("<td>" + tabla.getValueAt(t, 2) + "</td>");
                                out.println("<td>" + tabla.getValueAt(t, 3) + "</td>");
                                out.println("<td>" + tabla.getValueAt(t, 4) + "</td>");
                                out.println("<td>" + tabla.getValueAt(t, 5) + "</td>");
                                out.println("<td>" + tabla.getValueAt(t, 6) + "</td>");
                                out.println("</tr>");
                            }
                        %>                      
                    </tbody>
                </table>
            </div>                
        </div>

        <script type="text/javascript">
            function limpiar() {
                $("#txt_nit").val('');
                $("#txt_nombres").val('');
                $("#txt_apellidos").val('');
                $("#txt_direccion").val('');
                $("#txt_telefono").val('');
                $("#txt_correo").val('');

                $("#div_id").hide(1);
                $("#btn_modificar").hide(1);
                $("#btn_eliminar").hide(1);
                $("#btn_agregar").show(1);
            }

            $('#tbl_clientes').on('click', 'tr td', function (evt) {
                var target, Id, Nit, Nombres, Apellidos, Direccion, Telefono, Correo;
                target = $(event.target);
                Id = target.parent("tr").find("td").eq(0).html();
                Nit = target.parent("tr").find("td").eq(1).html();
                Nombres = target.parent("tr").find("td").eq(2).html();
                Apellidos = target.parent("tr").find("td").eq(3).html();
                Direccion = target.parent("tr").find("td").eq(4).html();
                Telefono = target.parent("tr").find("td").eq(5).html();
                Correo = target.parent("tr").find("td").eq(6).html();

                $("#txt_id").val(Id);
                $("#txt_nit").val(Nit);
                $("#txt_nombres").val(Nombres);
                $("#txt_apellidos").val(Apellidos);
                $("#txt_direccion").val(Direccion);
                $("#txt_telefono").val(Telefono);
                $("#txt_correo").val(Correo);

                $("#ModalCliente").modal('show');
                $("#div_id").show(1);
                $("#btn_modificar").show(1);
                $("#btn_eliminar").show(1);
                $("#btn_agregar").hide(1);
            });

            function buscar() {
                var tableReg = document.getElementById('tbl_clientes');
                var searchText = document.getElementById('txt_buscarCliente').value.toLowerCase();
                var cellsOfRow = "";
                var found = false;
                var compareWith = "";

                // Recorremos todas las filas con contenido de la tabla
                for (var i = 1; i < tableReg.rows.length; i++)
                {
                    cellsOfRow = tableReg.rows[i].getElementsByTagName('td');
                    found = false;
                    // Recorremos todas las celdas
                    for (var j = 0; j < cellsOfRow.length && !found; j++)
                    {
                        compareWith = cellsOfRow[j].innerHTML.toLowerCase();
                        // Buscamos el texto en el contenido de la celda
                        if (searchText.length === 0 || (compareWith.indexOf(searchText) > -1))
                        {
                            found = true;
                        }
                    }
                    if (found)
                    {
                        tableReg.rows[i].style.display = '';
                    } else {
                        // si no ha encontrado ninguna coincidencia, esconde la
                        // fila de la tabla
                        tableReg.rows[i].style.display = 'none';
                    }
                }
            }
        </script>
    </body>
</html>
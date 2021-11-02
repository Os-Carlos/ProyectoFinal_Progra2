<%@page import="javax.swing.table.DefaultTableModel"%>
<%@page import="modelo.usuario"%>
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
        <title>INICIO</title>
    </head>

    <body id="body_menu">
        <div class="d-flex">
            <div id="sidebar-container" class="bg-primary">
                <div class="logo"><h4 class="text-light">Proyecto</h4></div>
                <div class="menu">
                    <a href="bienvenida.jsp" class="d-block text-light" target="fr_contenido" style="padding-top: 30px; padding-bottom: 30px"><i class="bi bi-house"></i>Inicio</a>
                    <%
                        String id = session.getAttribute("id").toString();
                        String nombres = session.getAttribute("nombres").toString();
                        String apellidos = session.getAttribute("apellidos").toString();
                        String usuario = session.getAttribute("usuario").toString();
                        int grupo = Integer.valueOf(session.getAttribute("grupo").toString());

                        usuario permiso = new usuario();
                        permiso.setIdGrupo(grupo);

                        HashMap<String, String> dropPermiso = permiso.obtenerPermiso(permiso);
                        for (String i : dropPermiso.keySet()) {
                            switch (dropPermiso.get(i)) {
                                case "frm_ventas":
                                    out.println("<a href='frm_ventas.jsp' class='d-block text-light' target='fr_contenido'><i class='bi bi-shop-window'></i>Ventas</a>");
                                    break;
                                case "frm_inventario":
                                    out.println("<a href='frm_inventario.jsp' class='d-block text-light' target='fr_contenido'><i class='bi bi-clipboard-check'></i>Inventario</a>");
                                    break;
                                case "frm_clientes":
                                    out.println("<a href='frm_clientes.jsp' class='d-block text-light' target='fr_contenido'><i class='bi bi-person-check'></i>Clientes</a>");
                                    break;
                                case "frm_proveedores":
                                    out.println("<a href='frm_proveedores.jsp' class='d-block text-light' target='fr_contenido'><i class='bi bi-truck'></i>Proveedores</a>");
                                    break;
                                case "frm_usuarios":
                                    out.println("<a href='frm_usuarios.jsp' class='d-block text-light' target='fr_contenido'><i class='bi bi-person'></i>Usuarios</a>");
                                    break;
                                case "frm_grupos":
                                    out.println("<a href='frm_grupos.jsp' class='d-block text-light' target='fr_contenido'><i class='bi bi-people'></i>Grupos</a>");
                                    break;
                                case "frm_grupoPermisos":
                                    out.println("<a href='frm_permisosGrupo.jsp' class='d-block text-light' target='fr_contenido'><i class='bi bi-funnel'></i>Permisos de Grupo</a>");
                                    break;
                                case "frm_permisos":
                                    out.println("<a href='frm_permisos.jsp' class='d-block text-light' target='fr_contenido'><i class='bi bi-toggles'></i>Permisos</a>");
                                    break;
                                case "frm_compras":
                                    out.println("<a href='frm_compras.jsp' class='d-block text-light' target='fr_contenido'><i class='bi bi-cart2'></i>Compras</a>");
                                    break;
                            }
                        }
                    %>

                    <div class="dropup">
                        <div class="dropdown-divider"></div>
                        <button type="button" data-toggle="dropdown" id="btn_perfil" style="width: 180px"><i class="bi bi-person-circle align-middle" style="font-size: 1.5rem"></i>${usuario}</button>
                        
                        <div class="dropdown-menu" text-align: center"> 
                            <div class="card" style="width:250px; align-items: center; border: none;">
                                <i class="bi bi-person-circle align-middle" style="font-size: 3rem"></i>
                                <div class="card-body" style="text-align: center">                                   
                                    <p class="card-text">${nombres} ${apellidos}</p>                                                                        
                                </div>
                            </div>
                                    <a class="dropdown-item" href="../index.jsp" ><i class="bi bi-box-arrow-left"></i>Cerrar Sesión</a>					      
                        </div>
                    </div>
                </div>        		
            </div>
            <div class="container-fluid" id="contenido">
                <iframe src="bienvenida.jsp" id="fr_contenido" name="fr_contenido"></iframe>
            </div>
        </div>       
    </body>
</html>

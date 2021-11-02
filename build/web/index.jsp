<!DOCTYPE html>
<html> 
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>LOGIN</title>        
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We" crossorigin="anonymous">
        <link href="recursos/estilos.css" rel="stylesheet" type="text/css"/>
    </head>

    <body id="body_login">
        <main class="form-signin">
            <form action="srv_login" method="post">			 
                <h1 class="h3 mb-3 fw-normal">Inicio de Sesión</h1>
                <div class="form-floating">
                    <input type="text" class="form-control mb-3" name="txt_usuario" id="txt_usuario" placeholder="Usuario" required>
                    <label for="txt_usuario">Usuario</label>
                </div>
                <div class="form-floating">
                    <input type="password" class="form-control mb-3" name="txt_clave" id="txt_clave" placeholder="Contraseña" required>
                    <label for="txt_clave">Contraseña</label>
                </div>                   
                <%  String msg = "";
                    if (request.getParameter("msgLogin") != null) {
                        if (request.getParameter("msgLogin").equals("error")) {
                            msg = "Usuario y/o Contraseña Incorrectos";
                        } else {
                            msg = "";
                        }
                    }
                %> 
                <h6 style="color:red"><%=msg%></h6>
                <br>
                <button value="ingresar" name="btn_login" id="btn_login">Iniciar Sesión</button>	                                                                         
            </form>                
        </main>            
    </body>
</html>

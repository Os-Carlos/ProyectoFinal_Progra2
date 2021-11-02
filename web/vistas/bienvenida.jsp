<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">        
        <link href="../recursos/estilos.css" rel="stylesheet" type="text/css"/>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We" crossorigin="anonymous">
    </head>

    <body id="body_bienvenida">
        <div class="container-fluid" style="text-align: center; padding-top: 100px">
            <%
                String usuario = session.getAttribute("usuario").toString();
            %>
            <h1>Bienvenido</h1>
            <br><h2>${usuario}</h2>
        </div>        

        <div class="container-fluid">
            <div class="row" style="align-items: center">
                <!--widget de clima obtenido de https://weatherwidget.io/-->
                <div class="col">
                    <div class="container" id="div_clima">
                        <a class="weatherwidget-io" href="https://forecast7.com/es/14d56n90d73/antigua-guatemala/" data-label_1="ANTIGUA GUATEMALA" data-label_2="CLIMA" >ANTIGUA GUATEMALA WEATHER</a>
                        <script>
                            !function (d, s, id) {
                                var js, fjs = d.getElementsByTagName(s)[0];
                                if (!d.getElementById(id)) {
                                    js = d.createElement(s);
                                    js.id = id;
                                    js.src = 'https://weatherwidget.io/js/widget.min.js';
                                    fjs.parentNode.insertBefore(js, fjs);
                                }
                            }(document, 'script', 'weatherwidget-io-js');
                        </script>                   
                    </div>
                </div>   
                <!--calendario-->
                <div class="col">
                    <iframe src="https://calendar.google.com/calendar/embed?height=250&wkst=1&bgcolor=%23ffffff&ctz=America%2FGuatemala&showTitle=0&showNav=1&showCalendars=0&showTabs=0&showPrint=0&showTz=0&showDate=1&src=Y182ODFkOWxzYXA2bzQ1aXBzNTdjMzNsbmxpOEBncm91cC5jYWxlbmRhci5nb29nbGUuY29t&color=%23009688" style="border-width:0; margin-top: 150px; border-radius: 10px; margin-left: 75px" width="420" height="250" frameborder="0" scrolling="no"></iframe>
                </div>
            </div>        
        </div>       
    </body>
</html>

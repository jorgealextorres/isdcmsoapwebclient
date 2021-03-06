<%-- 
    Document   : busquedaVideo
    Created on : 24/04/2018, 16:13:15
    Author     : jorgetorres
--%>



<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.time.Duration"%>
<%@page import="java.time.LocalTime"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="isdcm.video.soap.Video"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
        <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
        <style>
        #videos {
            font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
            border-collapse: collapse;
            width: 100%;
        }

        #videos td, #videos th {
            border: 1px solid #ddd;
            padding: 8px;
        }

        #videos tr:nth-child(even){background-color: #f2f2f2;}

        #videos tr:hover {background-color: #ddd;}

        #videos th {
            padding-top: 12px;
            padding-bottom: 12px;
            text-align: left;
            background-color: #4CAF50;
            color: white;
        }
        </style>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <div>
            <form role="form" action="busquedaVideoServlet/busqueda" method="get">
                <input name="searchText" type="text" >
                        
                <select name="tipoBusqueda">
                   <option value="title">Por titulo</option>
                   <option value="autor">Por autor</option>
                   <option value="year">Por año de creación</option>
                 </select> 
         
                <button type="submit">Buscar</button>
                            
            </form>
        </div>

        <%
            try{ 
                String parametrosBusquedaText = (String)request.getAttribute("parametrosBusqueda");
                if(parametrosBusquedaText != null && !parametrosBusquedaText.isEmpty()){
                %>
                <div>
                    <p>${parametrosBusqueda}</p>
                </div>           
                <%
                }
            } catch(Exception e){%>
                <tr><td>Error: <%=e.getMessage()%></td></tr>
                <%
            }
        %>

        <div class="content">
        <h1>Listado videos</h1>
        <table id="videos">
          <tr>
            <th>Título</th>
            <th>Autor</th>
            <th>Fecha Creacion</th>
            <th>Duración</th>
            <th>Reproducciones</th>
            <th>Formato</th>
          </tr>
          
        <%
            try{               
                List<Video> videos = (List)request.getAttribute("listaVideos");
                
                if(videos == null || videos.isEmpty()){%>
                    <tr><td>No hay registros</td></tr>
                    <%
                } else{
                    SimpleDateFormat creationFormat = new SimpleDateFormat("MM/dd/yyyy");
                    SimpleDateFormat durationFormat = new SimpleDateFormat("HH:mm:ss");
                    for(Video element:videos){
                    %>
                        <tr>
                        <td><%=element.getTitulo()%></td>
                        <td><%=element.getAutor()%></td>
                        <td><%=creationFormat.format((element.getFechaCreacion()).toGregorianCalendar().getTime())%></td>
                        <td><%=durationFormat.format(new Timestamp(element.getDuracion()))%></td>
                        <td><%=element.getReproducciones()%></td>
                        <td><%=element.getFormato()%></td>
                        </tr>
                        <%
                    }
                }
            } catch(Exception e){%>
                <tr><td>Error: <%=e.getMessage()%></td></tr>
                <%
            }
        %>
        </table>  
        
        <form action="servletRegistroVid/showForm" method="post">
            <!--<p><input type="submit" value="Registrar video" /></p>-->
            <button type="submit" class="btn btn-success">Registrar video</button>
        </form>
        </div>
    </body>
</html>


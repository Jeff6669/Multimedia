<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Lista de Contenidos Multimedia</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f2f5;
            margin: 0;
            padding: 20px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        h2 { color: #333; margin-bottom: 20px; }
        table {
            border-collapse: collapse;
            width: 90%;
            max-width: 1200px;
            background-color: #fff;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
            border-radius: 12px;
            overflow: hidden;
        }
        th, td { text-align: center; padding: 12px; border-bottom: 1px solid #ddd; }
        th { background-color: #4CAF50; color: white; }
        tr:nth-child(even) { background-color: #f9f9f9; }
        tr:hover { background-color: #f1f1f1; }
        img, video, audio, iframe {
            max-width: 100%;
            height: auto;
            border-radius: 8px;
        }
        .delete-btn {
            background-color: #e74c3c; color: white; padding: 8px 12px;
            border: none; border-radius: 6px; cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .delete-btn:hover { background-color: #c0392b; }
        .back-btn {
            margin-top: 20px; padding: 12px 20px; background-color: #3498db;
            color: white; border: none; border-radius: 8px; cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .back-btn:hover { background-color: #2980b9; }
        a { color: #3498db; text-decoration: none; }
        a:hover { text-decoration: underline; }
    </style>
    <script>
        function confirmDelete() {
            return confirm("¿Estás seguro de eliminar este contenido?");
        }
    </script>
</head>
<body>
    <h2>Lista de Contenidos Multimedia</h2>

<%
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;

    String dbURL = "jdbc:mysql://localhost:3306/media_db";
    String dbUser = "Admin";
    String dbPass = "Admin$1234";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

        String sql = "SELECT * FROM multimedia";
        stmt = conn.createStatement();
        rs = stmt.executeQuery(sql);
%>

    <table>
        <tr>
            <th>Título</th>
            <th>Descripción</th>
            <th>Tipo</th>
            <th>Contenido</th>
            <th>Acciones</th>
        </tr>

<%
        while (rs.next()) {
            int id = rs.getInt("id");
            String titulo = rs.getString("titulo");
            String descripcion = rs.getString("descripcion");
            String tipo = rs.getString("tipo");
            String url = rs.getString("url");
%>
        <tr>
            <td><%= titulo %></td>
            <td><%= (descripcion != null) ? descripcion : "" %></td>
            <td><%= tipo %></td>
            <td>
                <% 
                if (tipo.equalsIgnoreCase("Imagen")) { 
                %>
                    <img src="<%= url %>" alt="Imagen">
                <% 
                } else if (tipo.equalsIgnoreCase("Video")) { 
                    if (url.contains("youtube.com") || url.contains("youtu.be")) { 
                        String embedUrl = url;
                        if (url.contains("watch?v=")) {
                            embedUrl = url.replace("watch?v=", "embed/");
                        } else if (url.contains("youtu.be/")) {
                            String videoId = url.substring(url.lastIndexOf("/") + 1);
                            embedUrl = "https://www.youtube.com/embed/" + videoId;
                        }
                %>
                        <iframe width="320" height="240" src="<%= embedUrl %>" frameborder="0" allowfullscreen></iframe>
                <%  
                    } else { 
                %>
                        <video width="320" height="240" controls>
                            <source src="<%= url %>" type="video/mp4">
                            Navegador no soporta el tag de video.
                        </video>
                <% 
                    }
                } else if (tipo.equalsIgnoreCase("Audio")) { 
                %>
                    <audio controls>
                        <source src="<%= url %>" type="audio/mpeg">
                        Navegador no soporta el tag de audio.
                    </audio>
                <% 
                } else { 
                %>
                    <a href="<%= url %>" target="_blank">Abrir Contenido</a>
                <% 
                } 
                %>
            </td>
            <td>
                <form action="eliminarMultimedia.jsp" method="post" onsubmit="return confirmDelete();">
                    <input type="hidden" name="id" value="<%= id %>">
                    <input type="submit" value="Eliminar" class="delete-btn">
                </form>
            </td>
        </tr>

<%
        }
%>
    </table>

<%
    } catch (Exception e) {
        out.println("<h3>Error al conectar o consultar: " + e.getMessage() + "</h3>");
    } finally {
        if (rs != null) try { rs.close(); } catch (Exception e) {}
        if (stmt != null) try { stmt.close(); } catch (Exception e) {}
        if (conn != null) try { conn.close(); } catch (Exception e) {}
    }
%>

    <button class="back-btn" onclick="window.location.href='index.html'">Volver al Menú Principal</button>

</body>
</html>

<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Guardar Contenido Multimedia</title>
</head>
<body>

<%
    // Recibimos los parámetros del formulario
    String titulo = request.getParameter("titulo");
    String descripcion = request.getParameter("descripcion");
    String url = request.getParameter("url");
    String tipo = request.getParameter("tipo");

    // Declaramos variables de conexión
    Connection conn = null;
    PreparedStatement stmt = null;

    // Datos de conexión a la BD
    String dbURL = "jdbc:mysql://localhost:3306/media_db";
    String dbUser = "Admin";
    String dbPass = "Admin$1234";

    try {
        // Cargar el driver de MySQL
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

        // Consulta SQL para insertar los datos
        String sql = "INSERT INTO multimedia (titulo, descripcion, url, tipo) VALUES (?, ?, ?, ?)";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, titulo);
        stmt.setString(2, descripcion);
        stmt.setString(3, url);
        stmt.setString(4, tipo);

        int rows = stmt.executeUpdate();

        // Confirmación
        if (rows > 0) {
%>
            <h3>Contenido multimedia guardado exitosamente.</h3>
            <meta http-equiv="refresh" content="2; URL=listaMultimedia.jsp">
<%
        } else {
%>
            <h3>Error al guardar el contenido.</h3>
<%
        }

    } catch (Exception e) {
%>
        <h3>Error: <%= e.getMessage() %></h3>
<%
    } finally {
        if (stmt != null) try { stmt.close(); } catch (Exception e) {}
        if (conn != null) try { conn.close(); } catch (Exception e) {}
    }
%>

    <br>
    <button onclick="window.location.href='index.html'">Volver al Menú Principal</button>

</body>
</html>

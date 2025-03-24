<%@ page import="java.sql.*" %>
<%
    String id = request.getParameter("id");
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/media_db", "Admin", "Admin$1234");

        String sql = "DELETE FROM multimedia WHERE id = ?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, Integer.parseInt(id));
        int rows = pstmt.executeUpdate();

        pstmt.close();
        conn.close();

        // Redirige a la página de listado para mostrar la lista actualizada
        response.sendRedirect("verMultimedia.jsp");
    } catch(Exception e) {
        out.println("Error al eliminar: " + e.getMessage());
    }
%>

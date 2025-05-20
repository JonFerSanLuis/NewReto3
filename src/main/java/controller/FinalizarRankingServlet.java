package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Date;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import db.AccesoBD;

@WebServlet("/FinalizarRankingServlet")
public class FinalizarRankingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
        
        // Verificar si el usuario es administrador
        if (isAdmin == null || !isAdmin) {
            session.setAttribute("error", "No tienes permisos para acceder a esta función");
            response.sendRedirect("perfil.jsp");
            return;
        }
        
        // Mostrar la página de confirmación
        request.getRequestDispatcher("finalizar-ranking.jsp").forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
        
        // Verificar si el usuario es administrador
        if (isAdmin == null || !isAdmin) {
            session.setAttribute("error", "No tienes permisos para acceder a esta función");
            response.sendRedirect("perfil.jsp");
            return;
        }
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        Statement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = AccesoBD.getConnection();
            conn.setAutoCommit(false); // Iniciar transacción
            
            // 1. Guardar el ranking actual en una tabla histórica (si existe)
            // Primero verificamos si existe una tabla de históricos, si no, la creamos
            stmt = conn.createStatement();
            stmt.execute("CREATE TABLE IF NOT EXISTS ranking_historico (" +
                         "id INT AUTO_INCREMENT PRIMARY KEY, " +
                         "id_escape_room INT, " +
                         "id_partida INT, " +
                         "id_suscriptor INT, " +
                         "tiempo_seg INT, " +
                         "pistas_usadas INT, " +
                         "puntos_totales INT, " +
                         "tipo_suscriptor VARCHAR(50), " +
                         "fecha_finalizacion DATE)");
            
            // Obtener la fecha actual para el registro histórico
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            String fechaActual = sdf.format(new Date());
            
            // Insertar los datos actuales en la tabla histórica
            pstmt = conn.prepareStatement(
                "INSERT INTO ranking_historico (id_escape_room, id_partida, id_suscriptor, tiempo_seg, pistas_usadas, puntos_totales, tipo_suscriptor, fecha_finalizacion) " +
                "SELECT id, id_partida, id_suscriptor, tiempo_seg, pistas_usadas, puntos_totales, tipo_suscriptor, ? FROM escape_room");
            pstmt.setString(1, fechaActual);
            pstmt.executeUpdate();
            
            // 2. Limpiar la tabla de escape_room (reiniciar el ranking)
            stmt.execute("TRUNCATE TABLE escape_room");
            
            // Confirmar la transacción
            conn.commit();
            
            session.setAttribute("mensaje", "El ranking ha sido finalizado y archivado correctamente");
            response.sendRedirect("perfil.jsp");
            
        } catch (SQLException e) {
            // En caso de error, hacer rollback
            try {
                if (conn != null) {
                    conn.rollback();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            
            session.setAttribute("error", "Error al finalizar el ranking: " + e.getMessage());
            response.sendRedirect("perfil.jsp");
            e.printStackTrace();
        } finally {
            // Cerrar recursos
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) {
                    conn.setAutoCommit(true); // Restaurar autocommit
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
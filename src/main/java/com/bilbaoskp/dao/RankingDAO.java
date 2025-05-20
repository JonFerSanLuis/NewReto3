package com.bilbaoskp.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.bilbaoskp.model.RankingUsuario;

import db.AccesoBD;

/**
 * Clase para acceder a los datos del ranking
 */
public class RankingDAO {
    
    /**
     * Obtiene la lista de usuarios para el ranking ordenados por puntuación
     * @return Lista de usuarios con sus puntuaciones
     */
    public List<RankingUsuario> obtenerRanking() {
        List<RankingUsuario> listaRanking = new ArrayList<>();
        
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
        	
            con = AccesoBD.getConnection();
            
            String sql = "SELECT s.id_suscriptor, s.username,\r\n"
            		+ "COALESCE(MAX(e.puntos_totales), 0) as puntos,\r\n"
            		+ "COUNT(DISTINCT e.id) as partidas\r\n"
            		+ "FROM suscriptores s\r\n"
            		+ "LEFT JOIN escape_room e ON e.id_suscriptor = s.id_suscriptor\r\n"
            		+ "LEFT JOIN partida p ON p.id = e.id_partida\r\n"
            		+ "WHERE s.tipo = 'ordinario'\r\n"
            		+ "GROUP BY s.id_suscriptor, s.username\r\n"
            		+ "ORDER BY puntos DESC, partidas DESC;";
            
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            
            int posicion = 1;
            
            while (rs.next()) {
                RankingUsuario ranking = new RankingUsuario();
                ranking.setPosicion(posicion++);
                ranking.setId(rs.getInt("id_suscriptor"));
                ranking.setNombre(rs.getString("username"));
                ranking.setPuntuacion(rs.getInt("puntos"));
                ranking.setPartidas(rs.getInt("partidas"));
                
                
                ranking.setNivel((rs.getInt("puntos") / 1000) + 1);
                
                listaRanking.add(ranking);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Cerrar conexiones
            AccesoBD.closeConnection(rs, ps, con);
        }
        
        return listaRanking;
    }
    
    /**
     * Busca usuarios en el ranking por nombre
     * @param nombreBusqueda Nombre o parte del nombre a buscar
     * @return Lista de usuarios que coinciden con la búsqueda
     */
    public List<RankingUsuario> buscarUsuariosPorNombre(String nombreBusqueda) {
        List<RankingUsuario> listaRanking = new ArrayList<>();
        
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            con = AccesoBD.getConnection();
            
            String sql = "SELECT s.id_suscriptor, s.username, \r\n"
            		+ "       COALESCE(MAX(e.puntos_totales), 0) as puntos, \r\n"
            		+ "       COUNT(DISTINCT e.id) as partidas\r\n"
            		+ "FROM suscriptores s\r\n"
            		+ "LEFT JOIN escape_room e ON e.id_suscriptor = s.id_suscriptor\r\n"
            		+ "LEFT JOIN partida p ON p.id = e.id_partida\r\n"
            		+ "WHERE s.username LIKE ?\r\n"
            		+ "GROUP BY s.id_suscriptor, s.username\r\n"
            		+ "ORDER BY puntos DESC, partidas DESC;\r\n"
            		+ "";
            
            ps = con.prepareStatement(sql);
            ps.setString(1, "%" + nombreBusqueda + "%");
            rs = ps.executeQuery();
            
            int posicion = 1;
            
            while (rs.next()) {
                RankingUsuario usuario = new RankingUsuario();
                usuario.setPosicion(posicion++);
                usuario.setId(rs.getInt("id_suscriptor"));
                usuario.setNombre(rs.getString("username"));
                usuario.setPuntuacion(rs.getInt("puntos"));
                usuario.setPartidas(rs.getInt("partidas"));
                
                int nivel = (rs.getInt("puntos") / 1000) + 1;
                usuario.setNivel(nivel);
                
                listaRanking.add(usuario);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            AccesoBD.closeConnection(rs, ps, con);
        }
        
        return listaRanking;
    }
}
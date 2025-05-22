package com.bilbaoskp.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.bilbaoskp.model.Cupon;
import com.bilbaoskp.model.Suscriptor;

import db.AccesoBD;

public class CuponDAO {
	
	public boolean asignarCupon(Cupon cupon) {
		Connection con = AccesoBD.getConnection();
		PreparedStatement ps = null;

		String sql = "INSERT INTO cupones (id_cupon, id_suscriptor, tipo, fecha_caducidad, estado) VALUES (?, ?, ?, ?, ?);";

		try {
			ps = con.prepareStatement(sql);
			ps.setInt(1, cupon.getIdCupon());
			ps.setInt(2, cupon.getIdSuscriptor());
			ps.setString(3, cupon.getTipo());
			ps.setDate(4, cupon.getFechaCaducidad());
			ps.setString(5, cupon.getEstado());			

			if (ps.executeUpdate() > 0) {
				return true;
			} else {
				return false;
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			AccesoBD.closeConnection(null, ps, con);
		}

		return false;
	}
	
	private Cupon mapResultSetToCupon(ResultSet rs) throws SQLException {
        Cupon cupon = new Cupon();
        cupon.setIdCupon(rs.getInt("id_cupon"));
        cupon.setIdSuscriptor(rs.getInt("id_suscriptor"));
        cupon.setFechaCaducidad(rs.getDate("fecha_caducidad"));
        cupon.setTipo(rs.getString("tipo"));
        cupon.setEstado(rs.getString("estado"));
        
        return cupon;
    }
	
	public boolean updateCuponEstado(int id, String estado) {
	    Connection con = null;
	    PreparedStatement ps = null;
	    boolean result = false;
	    
	    try {
	        con = AccesoBD.getConnection();
	        String sql = "UPDATE cupones SET tipo = ? WHERE id_cupon = ?";
	        
	        ps = con.prepareStatement(sql);

	        ps.setString(1, estado);

	        ps.setInt(2, id);

	        result = ps.executeUpdate() > 0;
	        
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        AccesoBD.closeConnection(null, ps, con);
	    }
	    
	    return result;
	}
	
	public Cupon getCuponBySuscriptorId(int id) {
        Cupon cupon = null;
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            con = AccesoBD.getConnection();
            String sql = "SELECT * FROM cupones WHERE id_suscriptor = (SELECT id_suscriptor FROM suscriptores WHERE id_suscriptor = ?);";
            ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            
            if (rs.next()) {
            	cupon = mapResultSetToCupon(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            AccesoBD.closeConnection(rs, ps, con);
        }
        
        return cupon;
    }
	
	public List<Cupon> getCuponesByIdSus(int id) {
        List<Cupon> cupones = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            con = AccesoBD.getConnection();
            String sql = "SELECT * FROM cupones WHERE id_suscriptor = (SELECT id_suscriptor FROM suscriptores WHERE id_suscriptor = ?)";
            ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            
            while (rs.next()) {
                Cupon cupon = mapResultSetToCupon(rs);
                cupones.add(cupon);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            AccesoBD.closeConnection(rs, ps, con);
        }
        
        return cupones;
    }

	public List<Cupon> obtenerCuponesPorSuscriptor(String username) {
	    List<Cupon> cupones = new ArrayList<>();
	    Connection con = null;
	    PreparedStatement ps = null;
	    ResultSet rs = null;
	    
	    try {
	        con = AccesoBD.getConnection(); // Obtiene la conexión usando AccesoBD
	        String sql = "SELECT * FROM cupones WHERE id_suscriptor = (SELECT id_suscriptor FROM suscriptores WHERE username = ?)";
	        ps = con.prepareStatement(sql);
	        ps.setString(1, username); // Establece el valor del parámetro
	        rs = ps.executeQuery();
	        
	        while (rs.next()) {
	            Cupon cupon = mapResultSetToCupon(rs); // Mapea el ResultSet a un objeto Cupon
	            cupones.add(cupon); // Agrega el cupon a la lista
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        AccesoBD.closeConnection(rs, ps, con); // Cierra la conexión utilizando AccesoBD
	    }
	    
	    return cupones;
	}

	public boolean eliminarCupon(int idCupon) {
        Connection con = null;
        PreparedStatement ps = null;
        boolean result = false;
        
        String sql = "DELETE FROM cupones WHERE id_cupon = ?";
        
        try {
            con = AccesoBD.getConnection();  // Obtener la conexión
            ps = con.prepareStatement(sql);  // Preparar la consulta
            ps.setInt(1, idCupon);  // Establecer el parámetro para el ID del cupón

            int rowsAffected = ps.executeUpdate();  // Ejecutar la consulta y obtener el número de filas afectadas

            // Si se eliminó al menos un registro, la eliminación fue exitosa
            if (rowsAffected > 0) {
                result = true;
            }

        } catch (SQLException e) {
            e.printStackTrace();  // En caso de error, imprimir la traza de la excepción
        } finally {
            // Cerrar la conexión y los recursos
            AccesoBD.closeConnection(null, ps, con);
        }

        return result;  // Devolver el resultado de la operación
    }
	
	public int contarCuponesTotales() {
	    Connection con = null;
	    PreparedStatement ps = null;
	    ResultSet rs = null;
	    int count = 0;
	    
	    try {
	        con = AccesoBD.getConnection();
	        String sql = "SELECT COUNT(*) FROM cupones";
	        ps = con.prepareStatement(sql);
	        rs = ps.executeQuery();
	        
	        if (rs.next()) {
	            count = rs.getInt(1);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        AccesoBD.closeConnection(rs, ps, con);
	    }
	    
	    return count;
	}

	
}

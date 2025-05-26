package com.bilbaoskp.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.bilbaoskp.model.Suscriptor;

import db.AccesoBD;

public class SuscriptorDAO {

	public boolean addSuscriptor(Suscriptor suscriptor) {
		Connection con = AccesoBD.getConnection();
		PreparedStatement ps = null;

		String sql = "INSERT INTO suscriptores (username, estado, fecha_alta, tipo, password, correo, edad) VALUES (?, ?, ?, ?, ?, ?, ?);";

		try {
			ps = con.prepareStatement(sql);

			ps.setString(1, suscriptor.getUsername());
			ps.setString(2, suscriptor.getEstado());
			ps.setDate(3, new java.sql.Date(suscriptor.getFechaAlta().getTime()));
			ps.setString(4, suscriptor.getTipo());
			ps.setString(5, suscriptor.getPassword());
			ps.setString(6, suscriptor.getCorreo());
			ps.setInt(7, suscriptor.getEdad());

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

	public List<Suscriptor> getAllSuscriptores() {
        List<Suscriptor> suscriptores = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            con = AccesoBD.getConnection();
            String sql = "SELECT * FROM suscriptores ORDER BY id_suscriptor";
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            
            while (rs.next()) {
                Suscriptor suscriptor = mapResultSetToSuscriptor(rs);
                suscriptores.add(suscriptor);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            AccesoBD.closeConnection(rs, ps, con);
        }
        
        return suscriptores;
    }
    
    public Suscriptor getSuscriptorById(int id) {
        Suscriptor suscriptor = null;
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            con = AccesoBD.getConnection();
            String sql = "SELECT * FROM suscriptores WHERE id_suscriptor = ?";
            ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            
            if (rs.next()) {
                suscriptor = mapResultSetToSuscriptor(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            AccesoBD.closeConnection(rs, ps, con);
        }
        
        return suscriptor;
    }
    
    public static Suscriptor getSuscriptorByNombre(String nombre) {
        Suscriptor suscriptor = null;
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            con = AccesoBD.getConnection();
            String sql = "SELECT * FROM suscriptores WHERE username = ?";
            ps = con.prepareStatement(sql);
            ps.setString(1, nombre);
            rs = ps.executeQuery();
            
            if (rs.next()) {
                suscriptor = mapResultSetToSuscriptor(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            AccesoBD.closeConnection(rs, ps, con);
        }
        
        return suscriptor;
    }
    
    public List<Suscriptor> getSuscriptoresByNombre(String nombre) {
        List<Suscriptor> suscriptores = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            con = AccesoBD.getConnection();
            String sql = "SELECT * FROM suscriptores WHERE username LIKE ? ORDER BY id_suscriptor";
            ps = con.prepareStatement(sql);
            ps.setString(1, "%" + nombre + "%");
            rs = ps.executeQuery();
            
            while (rs.next()) {
                Suscriptor suscriptor = mapResultSetToSuscriptor(rs);
                suscriptores.add(suscriptor);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            AccesoBD.closeConnection(rs, ps, con);
        }
        
        return suscriptores;
    }
    
    public boolean updateSuscriptor(Suscriptor suscriptor) {
        Connection con = null;
        PreparedStatement ps = null;
        boolean result = false;
        
        try {
            con = AccesoBD.getConnection();
            StringBuilder sql = new StringBuilder("UPDATE suscriptores SET username = ?, estado = ?, tipo = ?, correo = ?, edad = ?");
            

            if (suscriptor.getPassword() != null && !suscriptor.getPassword().isEmpty()) {
                sql.append(", password = ?");
            }
            
            sql.append(" WHERE id_suscriptor = ?");
            
            ps = con.prepareStatement(sql.toString());
            
            ps.setString(1, suscriptor.getUsername());
            ps.setString(2, suscriptor.getEstado());
            ps.setString(3, suscriptor.getTipo());
            ps.setString(4, suscriptor.getCorreo());
            ps.setInt(5, suscriptor.getEdad());
            
            int paramIndex = 6;
            
            if (suscriptor.getPassword() != null && !suscriptor.getPassword().isEmpty()) {
                ps.setString(paramIndex++, suscriptor.getPassword());
            }
            
            ps.setInt(paramIndex, suscriptor.getIdSuscriptor());
            
            result = ps.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            AccesoBD.closeConnection(null, ps, con);
        }
        
        return result;
    }
    
    public boolean deleteSuscriptor(int id) {
        Connection con = null;
        PreparedStatement ps = null;
        boolean result = false;
        
        try {
            con = AccesoBD.getConnection();
            con.setAutoCommit(false);
            
            // Primero verificamos si es un centro para eliminar registros relacionados
            String checkSql = "SELECT tipo FROM suscriptores WHERE id_suscriptor = ?";
            PreparedStatement checkPs = con.prepareStatement(checkSql);
            checkPs.setInt(1, id);
            ResultSet rs = checkPs.executeQuery();
            
            if (rs.next() && "centro".equals(rs.getString("tipo"))) {
                // Si es un centro, primero eliminamos de la tabla centros
                // No es necesario eliminar explícitamente debido a la restricción ON DELETE CASCADE
                // pero lo hacemos por claridad
                String deleteCentroSql = "DELETE FROM centros WHERE id_suscriptor = ?";
                PreparedStatement deleteCentroPs = con.prepareStatement(deleteCentroSql);
                deleteCentroPs.setInt(1, id);
                deleteCentroPs.executeUpdate();
                deleteCentroPs.close();
            }
            
            rs.close();
            checkPs.close();
            
            // Ahora eliminamos el suscriptor
            String sql = "DELETE FROM suscriptores WHERE id_suscriptor = ?";
            ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            
            result = ps.executeUpdate() > 0;
            
            con.commit();
        } catch (SQLException e) {
            try {
                if (con != null) con.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
        } finally {
            try {
                if (con != null) con.setAutoCommit(true);
            } catch (SQLException e) {
                e.printStackTrace();
            }
            AccesoBD.closeConnection(null, ps, con);
        }
        
        return result;
    }
    
    private static Suscriptor mapResultSetToSuscriptor(ResultSet rs) throws SQLException {
        Suscriptor suscriptor = new Suscriptor();
        suscriptor.setIdSuscriptor(rs.getInt("id_suscriptor"));
        suscriptor.setUsername(rs.getString("username"));
        suscriptor.setEstado(rs.getString("estado"));
        suscriptor.setFechaAlta(rs.getDate("fecha_alta"));
        suscriptor.setTipo(rs.getString("tipo"));
        suscriptor.setPassword(rs.getString("password"));
        suscriptor.setCorreo(rs.getString("correo"));
        suscriptor.setEdad(rs.getInt("edad"));
        return suscriptor;
    }
    
    public boolean login(String usuario, String password) {
    	Connection con = AccesoBD.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		String sql = "SELECT username, password FROM suscriptores WHERE username = ? AND password = ?;";
		
		try {
			ps = con.prepareStatement(sql);
			ps.setString(1, usuario);
			ps.setString(2, password);
			
			rs = ps.executeQuery();
			if (rs.next()) { 
	            return true;
	        } else {
	            return false;
	        }
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			AccesoBD.closeConnection(rs, ps, con);
		}
		return false;
	}
    
    public boolean deleteSuscriptor(String username) {
		Connection con = AccesoBD.getConnection();
		PreparedStatement ps = null;

		String sql = "DELETE FROM suscriptores WHERE username = ?;";

		try {
			ps = con.prepareStatement(sql);

			ps.setString(1, username);

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
    
    public int contarUsuariosActivos() {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        int count = 0;
        
        try {
            con = AccesoBD.getConnection();
            String sql = "SELECT COUNT(*) FROM suscriptores WHERE estado = 'activo'";
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

    public int contarUsuariosInactivos() {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        int count = 0;
        
        try {
            con = AccesoBD.getConnection();
            String sql = "SELECT COUNT(*) FROM suscriptores WHERE estado = 'inactivo'";
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

    public int contarCentros() {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        int count = 0;
        
        try {
            con = AccesoBD.getConnection();
            String sql = "SELECT COUNT(*) FROM suscriptores WHERE tipo = 'centro'";
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

    public List<Suscriptor> getSuscriptoresByTipoAndEstado(String tipo, String estado) {
        List<Suscriptor> suscriptores = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            con = AccesoBD.getConnection();
            String sql = "SELECT * FROM suscriptores WHERE tipo = ? AND estado = ? ORDER BY id_suscriptor";
            ps = con.prepareStatement(sql);
            ps.setString(1, tipo);
            ps.setString(2, estado);
            rs = ps.executeQuery();
            
            while (rs.next()) {
                Suscriptor suscriptor = mapResultSetToSuscriptor(rs);
                suscriptores.add(suscriptor);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            AccesoBD.closeConnection(rs, ps, con);
        }
        
        return suscriptores;
    }
}
package com.bilbaoskp.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.bilbaoskp.model.Centro;
import com.bilbaoskp.model.Suscriptor;

import db.AccesoBD;

public class CentroDAO {
    
	public boolean addCentro(Centro centro) throws SQLException {
        String sqlSuscriptor = """
            INSERT INTO suscriptores
              (username, estado, fecha_alta, tipo, password, correo, edad)
            VALUES (?, ?, ?, ?, ?, ?, ?)
            """;
        String sqlCentro = """
            INSERT INTO centros
              (id_suscriptor, cod_centro, nombre, responsable, tipo_suscriptor,
               num_alumnos, email, telefono)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?)
            """;

        try (Connection con = AccesoBD.getConnection()) {
            con.setAutoCommit(false);
            try (
                PreparedStatement psSus = con.prepareStatement(sqlSuscriptor, PreparedStatement.RETURN_GENERATED_KEYS);
            ) {
                // 1) Insert suscriptor
                Suscriptor suscriptor = new Suscriptor();
                suscriptor.setUsername(centro.getResponsable());
                suscriptor.setEstado("activo");
                suscriptor.setFechaAlta(new java.util.Date());
                suscriptor.setTipo("centro");
                suscriptor.setPassword("temporal");
                suscriptor.setCorreo(centro.getEmail());
                suscriptor.setEdad(0);

                psSus.setString(1, suscriptor.getUsername());
                psSus.setString(2, suscriptor.getEstado());
                psSus.setDate(3, new Date(suscriptor.getFechaAlta().getTime()));
                psSus.setString(4, suscriptor.getTipo());
                psSus.setString(5, suscriptor.getPassword());
                psSus.setString(6, suscriptor.getCorreo());
                psSus.setInt(7, suscriptor.getEdad());

                if (psSus.executeUpdate() != 1) {
                    throw new SQLException("No se pudo insertar en suscriptores");
                }

                // Obtener id_suscriptor
                try (ResultSet rs = psSus.getGeneratedKeys()) {
                    if (!rs.next()) {
                        throw new SQLException("No se generó id_suscriptor");
                    }
                    centro.setIdSuscriptor(rs.getInt(1));
                }
            }

            // 2) Insert centro
            try (PreparedStatement psCen = con.prepareStatement(sqlCentro)) {
                psCen.setInt(1, centro.getIdSuscriptor());
                psCen.setInt(2, centro.getCodCentro());
                psCen.setString(3, centro.getNombre());
                psCen.setString(4, centro.getResponsable());
                psCen.setString(5, centro.getTipoCentro());
                psCen.setInt(6, centro.getNumAlumnos());
                psCen.setString(7, centro.getEmail());
                psCen.setString(8, centro.getTelefono());

                if (psCen.executeUpdate() != 1) {
                    throw new SQLException("No se pudo insertar en centros");
                }
            }

            con.commit();
            return true;
        } catch (SQLException e) {
            // En caso de error, la conexión se cierra y hace rollback automático si no está commit
            throw e;
        }
	}
            //Este metodo es para ayudar a verificar que el centro está en la base de datos
            public Centro obtenerCentroPorCodigo(int codCentro) throws SQLException {
                String sql = "SELECT * FROM centros WHERE cod_centro = ?";
                Centro centro = null;

                try (Connection con = AccesoBD.getConnection();
                     PreparedStatement ps = con.prepareStatement(sql)) {
                    ps.setInt(1, codCentro);  // Establece el valor del parámetro codCentro
                    try (ResultSet rs = ps.executeQuery()) {
                        if (rs.next()) {
                            centro = new Centro();
                            centro.setCodCentro(rs.getInt("cod_centro"));
                            centro.setNombre(rs.getString("nombre"));
                            centro.setResponsable(rs.getString("responsable"));
                            centro.setTipoCentro(rs.getString("tipo_suscriptor"));
                            centro.setNumAlumnos(rs.getInt("num_alumnos"));
                            centro.setEmail(rs.getString("email"));
                            centro.setTelefono(rs.getString("telefono"));
                            centro.setIdSuscriptor(rs.getInt("id_suscriptor"));
                        }
                    }
                }

                return centro;
            }
        }
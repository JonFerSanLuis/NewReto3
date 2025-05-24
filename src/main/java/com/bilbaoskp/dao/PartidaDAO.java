package com.bilbaoskp.dao;

import java.sql.Connection;
import java.util.Date;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.bilbaoskp.model.Partida;

import db.AccesoBD;

public class PartidaDAO {
	 public boolean guardarPartida(Partida partida, int codCentro) throws SQLException {
	        String sql = """
	            INSERT INTO partidas (nombre, tipo_partida, fecha, cod_centro, idioma)
	            VALUES (?, ?, ?, ?, ?)
	        			""";

	        try (Connection con = AccesoBD.getConnection();
	                PreparedStatement ps = con.prepareStatement(sql)) {
	               ps.setString(1, partida.getNombre());
	               ps.setString(2, partida.getTipoPartida());
	               ps.setDate(3, (java.sql.Date) new Date(partida.getFecha().getTime()));
	               ps.setInt(4, codCentro);
	               ps.setString(5, partida.getIdioma());

	               return ps.executeUpdate() == 1;
	           }
	       }
}

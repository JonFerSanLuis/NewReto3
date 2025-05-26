package service;

import java.sql.SQLException;
import com.bilbaoskp.dao.CentroDAO;
import com.bilbaoskp.model.Centro;

public class CentroService {
    CentroDAO centroDao;

    public CentroService() {
        centroDao = new CentroDAO();
    }

    public boolean addCentro(Centro centro) {
        try {
			return centroDao.addCentro(centro);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
    }

    public Centro getCentroByName(String name) throws SQLException {
    	return centroDao.obtenerCentroPorNombre(name);
    }
}

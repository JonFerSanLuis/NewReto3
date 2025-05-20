package service;

import com.bilbaoskp.dao.SuscriptorDAO;
import com.bilbaoskp.model.Suscriptor;

public class SuscriptorService {
	SuscriptorDAO suscriptorDao;
	
	public SuscriptorService() {
		suscriptorDao = new SuscriptorDAO();
	}
	
	public boolean addSuscriptor(Suscriptor suscriptor) {
		return suscriptorDao.addSuscriptor(suscriptor);
	}
	
	public boolean login(String usuario, String password) {
		return suscriptorDao.login(usuario, password);
	}
	
	public Suscriptor getSuscriptorByNombreService(String nombre) {
		return SuscriptorDAO.getSuscriptorByNombre(nombre);
	}
	
	// Método para verificar si un usuario es administrador
	public boolean isAdmin(String username) {
		Suscriptor suscriptor = SuscriptorDAO.getSuscriptorByNombre(username);
		return suscriptor != null && "admin".equals(suscriptor.getTipo());
	}
	
	public boolean deleteSuscriptor(String username) {
		return suscriptorDao.deleteSuscriptor(username);
	}
}

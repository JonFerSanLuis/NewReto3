// Modifica tu PerfilServlet para incluir los datos del dashboard

package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bilbaoskp.model.Cupon;
import com.bilbaoskp.dao.SuscriptorDAO;
import com.bilbaoskp.dao.CuponDAO;

import service.CuponService;
import service.SuscriptorService;

/**
 * Servlet implementation class PerfilServlet
 */
@WebServlet("/PerfilServlet")
public class PerfilServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    CuponService cuponService;
    SuscriptorService suscriptorService;
    SuscriptorDAO suscriptorDAO;
    CuponDAO cuponDAO;

    public void init() {
        cuponService = new CuponService();
        suscriptorService = new SuscriptorService();
        suscriptorDAO = new SuscriptorDAO();
        cuponDAO = new CuponDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtener el nombre de usuario desde la sesión
       // String username = (String) request.getSession().getAttribute("username");
        
        Cookie[] cookies = request.getCookies();
        String username = null;

        if (cookies != null) {
        	for (Cookie cookie : cookies) {
        		if ("usuario".equals(cookie.getName())) {
        			username = java.net.URLDecoder.decode(cookie.getValue(), "UTF-8");
        			break;
        		}
        	}
        }
        
        if (username != null) {
            // Obtener los cupones del suscriptor
            java.util.List<Cupon> cupones = cuponService.getCuponesPorSuscriptor(username);
            request.setAttribute("listaCupones", cupones);
            
            // Obtener datos para el dashboard de administrador
            Boolean isAdmin = (Boolean) request.getSession().getAttribute("isAdmin");
            if (isAdmin != null && isAdmin) {
                // Contar usuarios activos, inactivos, centros y cupones
                int usuariosActivos = suscriptorDAO.contarUsuariosActivos();
                int usuariosInactivos = suscriptorDAO.contarUsuariosInactivos();
                int centrosRegistrados = suscriptorDAO.getSuscriptoresByTipoAndEstado("centro", "activo").size(); // Counting active centers
                int totalCupones = cuponDAO.contarCuponesTotales();
                int centrosPendientes = suscriptorDAO.getSuscriptoresByTipoAndEstado("centro", "pendiente").size();
                
                // Establecer atributos para el JSP
                request.setAttribute("usuariosActivos", usuariosActivos);
                request.setAttribute("usuariosInactivos", usuariosInactivos);
                request.setAttribute("centrosRegistrados", centrosRegistrados); // This now represents active centers
                request.setAttribute("totalCupones", totalCupones);
                request.setAttribute("centrosPendientes", centrosPendientes); // New attribute for pending centers
            }

            // Redirigir a la JSP del perfil
            request.getRequestDispatcher("perfil.jsp").forward(request, response);
        } else {
            // Si el usuario no está en la sesión, redirigir al login
            response.sendRedirect("login.jsp");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}

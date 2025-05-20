package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bilbaoskp.model.Cupon;

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

    public void init() {
        cuponService = new CuponService();
        suscriptorService = new SuscriptorService();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtener el nombre de usuario desde la sesión
        String username = (String) request.getSession().getAttribute("username");
        
        if (username != null) {
            // Obtener los cupones del suscriptor
            java.util.List<Cupon> cupones = cuponService.getCuponesPorSuscriptor(username);
            request.setAttribute("listaCupones", cupones);

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

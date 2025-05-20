package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.SuscriptorService;

@WebServlet("/EliminarSuscripcionServlet")
public class EliminarSuscripcionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	SuscriptorService suscriptorService;
       
    public EliminarSuscripcionServlet() {
        super();
        suscriptorService = new SuscriptorService();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Obtener username de las cookies
        String username = null;
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("usuario".equals(cookie.getName())) {
                    username = java.net.URLDecoder.decode(cookie.getValue(), "UTF-8");
                    break;
                }
            }
        }
        // Eliminar el suscriptor y la cookie
            if (suscriptorService.deleteSuscriptor(username)) {
                if (cookies != null) {
                    for (Cookie cookie : cookies) {
                        if ("usuario".equals(cookie.getName())) {
                            cookie.setMaxAge(0);
                            cookie.setPath("/");
                            response.addCookie(cookie);
                        }
                    }
                }
                response.sendRedirect("login.jsp");
			}
	}
}

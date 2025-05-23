package controller;

import java.io.IOException;
import java.sql.Date;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bilbaoskp.model.Cupon;
import com.bilbaoskp.model.Suscriptor;
import service.CuponService;
import service.SuscriptorService;

/**
 * Servlet implementation class getCupon
 */
@WebServlet("/getCupon")
public class getCupon extends HttpServlet {
	
	Cookie[] cookies;
	String nombre;
	private static final long serialVersionUID = 1L;
	CuponService cuponService = new CuponService();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public getCupon() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
        cookies = request.getCookies();
        boolean loggedIn = false;
        
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("usuario".equals(cookie.getName())) {
                    loggedIn = true;
                    break;
                }
            }
        }

		if (!loggedIn) {
			System.out.println("Usuario no logueado. Redirigiendo a login.jsp.");
			response.sendRedirect("login.jsp");
			return;
		} else {

			if (cookies != null) {
				for (Cookie cookie : cookies) {
					if ("usuario".equals(cookie.getName())) {
						nombre = cookie.getValue();
						break;
					}
				}
			}

			String email = request.getParameter("email");
			String cupon = request.getParameter("cupon");
			System.out.println(cupon);
			String tarjeta = request.getParameter("tarjeta");
			String caducidad = request.getParameter("caducidad");
			String cvv = request.getParameter("cvv");

			System.out.println("Procesando compra para el usuario: " + nombre);

			SuscriptorService suscriptorService = new SuscriptorService();
			Suscriptor s = suscriptorService.getSuscriptorByNombreService(nombre);

			if (s == null) {
				System.out.println("Suscriptor no encontrado.");
				response.sendRedirect("error.jsp");
				return;
			}

			CuponService cupService = new CuponService();
			Cupon c = new Cupon();
			c.setIdSuscriptor(s.getIdSuscriptor());
			c.setEstado("disponible");
			Date fechaActual = new Date(System.currentTimeMillis());
			Calendar calendar = Calendar.getInstance();
			calendar.setTime(fechaActual);
			calendar.add(Calendar.YEAR, 1);
			Date fechaCaducidad = new Date(calendar.getTimeInMillis());
			c.setFechaCaducidad(fechaCaducidad);

			switch (cupon) {
			case "SOLEDAD":
				c.setTipo("Bullying");
				cupService.asignarCuponService(c);
				break;

			case "MIL Y UNA PREGUNTAS":
				System.out.println("Tipo de cupon no válido.");
				doGet(request, response);
				return;

			case "LA ULTIMA SANGRE":
				System.out.println("Tipo de cupon no válido.");
				doGet(request, response);
				return;

			default:
				System.out.println("Tipo de cupon no válido.");
				doGet(request, response);
				return;
			}

			System.out.println("Compra procesada correctamente. Redirigiendo a perfil.jsp.");
			response.sendRedirect("PerfilServlet");
			doGet(request, response);
		}

	}

}

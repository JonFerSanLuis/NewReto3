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
		 // Verificar si el usuario está logueado antes de procesar la solicitud
        Cookie[] cookies = request.getCookies();
        boolean loggedIn = false;
        
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("usuario".equals(cookie.getName())) {
                    loggedIn = true;
                    break;
                }
            }
        }

        // Si no está logueado, redirigir al login
        if (!loggedIn) {
            System.out.println("Usuario no logueado. Redirigiendo a login.jsp.");
            response.sendRedirect("login.jsp");
            return;  // Terminar la ejecución del servlet
        }else {
        // Si está logueado, continuar con la lógica de compra
        String nombre = request.getParameter("nombre");
        String email = request.getParameter("email");
        String cupon = request.getParameter("cupon");
        System.out.println(cupon);
        int cantidad = Integer.parseInt(request.getParameter("cantidad"));
        String tarjeta = request.getParameter("tarjeta");
        String caducidad = request.getParameter("caducidad");
        String cvv = request.getParameter("cvv");

        System.out.println("Procesando compra para el usuario: " + nombre);

        SuscriptorService suscriptorService = new SuscriptorService();
        Suscriptor s = suscriptorService.getSuscriptorByNombreService(nombre);
        
        if (s == null) {
            System.out.println("Suscriptor no encontrado.");
            response.sendRedirect("error.jsp"); // Redirigir a una página de error
            return;
        }

        CuponService cupService = new CuponService();
        Cupon c = new Cupon();
        c.setIdSuscriptor(s.getIdSuscriptor());
        c.setEstado("disponible");
        Date fechaActual = new Date(System.currentTimeMillis());
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(fechaActual);
        calendar.add(Calendar.YEAR, 1); // Caducidad de 1 año
        Date fechaCaducidad = new Date(calendar.getTimeInMillis());
        c.setFechaCaducidad(fechaCaducidad);

        switch (cupon) {
            case "CupÃ³n Basico":
                for (int a = 0; a < cantidad; a++) {
                    c.setTipo("Básico");
                    try {
                        cupService.asignarCuponService(c);
                    } catch (Exception e) {
                        System.out.println("Error al asignar cupon Basico: " + e.getMessage());
                        return;
                    }
                }
                break;

            case "Pack EstÃ¡ndar":
                for (int a = 0; a < cantidad * 5; a++) {
                    c.setTipo("Estándar");
                    try {
                        cupService.asignarCuponService(c);
                    } catch (Exception e) {
                        System.out.println("Error al asignar cupon Estándar: " + e.getMessage());
                        return;
                    }
                }
                break;

            case "Pack Premium":
                for (int a = 0; a < cantidad * 12; a++) {
                    c.setTipo("Premium");
                    try {
                        cupService.asignarCuponService(c);
                    } catch (Exception e) {
                        System.out.println("Error al asignar cupon Premium: " + e.getMessage());
                        return;
                    }
                }
                break;

            default:
                System.out.println("Tipo de cupon no válido.");
                doGet(request, response);
                return;
        }

        // Redirigir al perfil del usuario
        System.out.println("Compra procesada correctamente. Redirigiendo a perfil.jsp.");
        response.sendRedirect("PerfilServlet");
		doGet(request, response);
        }

	}

}

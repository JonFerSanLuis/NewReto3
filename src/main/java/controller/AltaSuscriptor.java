package controller;

import java.io.IOException;

import java.sql.Date;
import java.util.Calendar;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bilbaoskp.model.Centro;
import com.bilbaoskp.model.Cupon;
import com.bilbaoskp.model.Suscriptor;

import service.CentroService;
import service.CuponService;
import service.SuscriptorService;


@WebServlet("/AltaSuscriptor")
public class AltaSuscriptor extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	SuscriptorService suscriptorService;
	CentroService centroService;
	
	public void init(ServletConfig config) throws ServletException {
    	super.init(config);
    	suscriptorService = new SuscriptorService();
    	centroService = new CentroService();
    }
       
    
    public AltaSuscriptor() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String tipoRegistro = request.getParameter("tipo");
	
	if ("ordinario".equals(tipoRegistro)) {
		String username = request.getParameter("username");
		String estado = "estado";
		Date fecha_alta = new Date(System.currentTimeMillis()); // No existe este campo en el formulario, con este codigo se insertará en el objeto la fecha actual al darle al boton de registrar
		String tipo = request.getParameter("tipo");
		String password = request.getParameter("password");
		String correo = request.getParameter("correo");
		int edad = Integer.valueOf(request.getParameter("edad"));
		
		Suscriptor suscriptor = new Suscriptor(0, username, estado, fecha_alta, tipo, password, correo, edad);
		
		if(suscriptorService.addSuscriptor(suscriptor)) {
			Cookie[] cookies = request.getCookies();

			if (cookies != null) {
				for (Cookie cookie : cookies) {
					if ("usuario".equals(cookie.getName())) {
						cookie.setMaxAge(0);
                        cookie.setPath(request.getContextPath() + "/PerfilServlet");
                        response.addCookie(cookie);
					}
				}
			}
			Cupon c = new Cupon(); 
			
			Suscriptor s = new Suscriptor();
			SuscriptorService ser = new SuscriptorService();
			s = ser.getSuscriptorByNombreService(username);				
			c.setIdSuscriptor(s.getIdSuscriptor());
			c.setTipo("Bullying");
				
			Date fechaActual = new Date(System.currentTimeMillis());
			Calendar calendar = Calendar.getInstance();
			calendar.setTime(fechaActual);
			calendar.add(Calendar.YEAR, 1);
			Date fechaCaducidad = new Date(calendar.getTimeInMillis());;
			
			c.setEstado("disponible");
			c.setFechaCaducidad(fechaCaducidad);
			CuponService cup = new CuponService();
			cup.asignarCuponService(c);
			
			Cookie cookie = new Cookie("usuario", username);
	        cookie.setPath("/");
	        response.addCookie(cookie);
	        
	        response.sendRedirect("PerfilServlet");
			
    	} else {
    		request.setAttribute("errorMensaje", "Error al registrar suscriptor. Inténtalo de nuevo.");
            request.getRequestDispatcher("suscribirse.jsp").forward(request, response);
    	}
	}
	else if ("centro".equals(tipoRegistro)) {  
	    String nombre = request.getParameter("nombre");
	    int codigo_centro = Integer.valueOf(request.getParameter("codigo"));
	    String responsable = request.getParameter("responsable");
	    String email = request.getParameter("email");
	    String tipoCentro = request.getParameter("tipo");
	    int numAlumnos = Integer.valueOf(request.getParameter("alumnos"));
	    String numTelefono = request.getParameter("telefono");
	    String password = request.getParameter("password");

	    // Crear al responsable como suscriptor
	    Suscriptor s = new Suscriptor();
	    s.setUsername(responsable);
	    s.setEstado("pendiente");
	    s.setFechaAlta(new Date(System.currentTimeMillis()));
	    s.setTipo("centro");
	    s.setPassword(password);
	    s.setCorreo(email);
	    s.setEdad(0);

	    suscriptorService.addSuscriptor(s);

	    // Obtener el ID del responsable
	    s = suscriptorService.getSuscriptorByNombreService(responsable);
	    int idResponsable = s.getIdSuscriptor();

	    // Crear el centro
	    Centro centro = new Centro(codigo_centro, nombre, responsable, tipoCentro, numAlumnos, email, numTelefono, password);
	    centro.setIdSuscriptor(idResponsable);

	    if (centroService.addCentro(centro)) {
	        // Asignar cupón al responsable
	        Cupon c = new Cupon();
	        c.setIdSuscriptor(idResponsable);
	        c.setTipo("Bullying");

	        Calendar calendar = Calendar.getInstance();
	        calendar.setTime(new Date(System.currentTimeMillis()));
	        calendar.add(Calendar.YEAR, 1);
	        Date fechaCaducidad = new Date(calendar.getTimeInMillis());

	        c.setFechaCaducidad(fechaCaducidad);
	        c.setEstado("pendiente");

	        CuponService cup = new CuponService();
	        cup.asignarCuponService(c);

	        response.sendRedirect("index.jsp");
	    } else {
	        request.setAttribute("errorMensaje", "Error al registrar centro. Inténtalo de nuevo.");
	        request.getRequestDispatcher("suscribirse.jsp").forward(request, response);
	    }
	}
	else {
		
		response.sendRedirect("error.jsp");
	}
}
}

	

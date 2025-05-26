package controller;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.bilbaoskp.model.Centro;

import service.CentroService;
import service.SuscriptorService;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	SuscriptorService suscriptorService;
	CentroService centroService;
	
	public void init(ServletConfig config) throws ServletException {
    	super.init(config);
    	suscriptorService = new SuscriptorService();
    	centroService = new CentroService();
    }
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		Cookie cookie = new Cookie("usuario", null);  // Establece la cookie "usuario" con valor null
	    cookie.setMaxAge(0);  // Expira la cookie
	    cookie.setPath("/");
	    response.addCookie(cookie);  // Elimina la cookie
	    response.sendRedirect("login.jsp");  // Redirige al login
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    String username = request.getParameter("usuario");
	    String password = request.getParameter("password");
	    String tipoUser = suscriptorService.getSuscriptorByNombreService(username).getTipo();
	    
	    if (suscriptorService.login(username, password)) {
	        // Verificar si el usuario es administrador
	        boolean isAdmin = suscriptorService.isAdmin(username);
	        
	        // Crear una cookie con el nombre de usuario
	        String usernameEncoded = URLEncoder.encode(username, "UTF-8");
	        Cookie cookie = new Cookie("usuario", usernameEncoded);

	        cookie.setPath("/");  // La cookie estará disponible para todo el dominio
	        
	        // Agregar la cookie a la respuesta
	        response.addCookie(cookie);

	        Cookie cookieType = new Cookie("tipo", tipoUser);

	        cookieType.setPath("/");
	        cookie.setPath("/");
	        
	        // Agregar la cookie a la respuesta
	        response.addCookie(cookie);
	        response.addCookie(cookieType);
	        
	        HttpSession session = request.getSession(true); // Crea una nueva sesión
	        session.setAttribute("username", username);
	        session.setAttribute("isAdmin", isAdmin); // Guardar si es admin en la sesión
	        
	        
	        
	        // Redirigir al perfil
	        response.sendRedirect("PerfilServlet");
	    } else {
	        request.setAttribute("errorMensaje", "Error al iniciar sesión. Inténtalo de nuevo.");
	        request.getRequestDispatcher("login.jsp").forward(request, response);
	    }
	}
}
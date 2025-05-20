package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/CambiarIdioma")
public class CambiarIdiomaServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
       
    public CambiarIdiomaServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idioma = request.getParameter("idioma");
        String referer = request.getHeader("Referer");
        
        if (idioma != null) {
            HttpSession session = request.getSession();
            session.setAttribute("idioma", idioma);
        }
        
        // Redirigir a la página desde la que se hizo la solicitud
        if (referer != null) {
            response.sendRedirect(referer);
        } else {
            response.sendRedirect("index.jsp");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
package service;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebFilter("/private/*")  // Aplica solo a páginas dentro de la carpeta "private"
public class LoginFilter implements Filter {
    
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        Cookie[] cookies = httpRequest.getCookies();
        boolean loggedIn = false;

        // Verificar si la cookie "usuario" está presente
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("usuario".equals(cookie.getName())) {
                    loggedIn = true;
                    break;
                }
            }
        }

        // Si el usuario no está logueado (cookie no encontrada), redirigir a login.jsp
        if (!loggedIn) {
            ((HttpServletResponse) response).sendRedirect("../login.jsp");
        } else {
            // Si está logueado, continuar con la solicitud
            chain.doFilter(request, response);
        }
    }

    public void init(FilterConfig fConfig) throws ServletException {}
    public void destroy() {}
}

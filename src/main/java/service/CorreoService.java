package service;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.SendMesagge;

@WebServlet("/enviarEmail")
public class CorreoService extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Recoger datos del formulario
        String email = request.getParameter("email");
        String asunto = request.getParameter("asunto");
        String mensaje = request.getParameter("mensaje");

        // Llamar a la clase que envía el correo
        boolean enviado = SendMesagge.enviarEmail(email, asunto, mensaje);

        // Redireccionar dependiendo si se envió o falló
        if (enviado) {
            response.sendRedirect("contacto-exito.jsp");
        } else {
            response.sendRedirect("contacto-error.jsp");
        }
    }
}


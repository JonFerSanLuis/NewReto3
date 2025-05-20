package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.CuponService;

@WebServlet("/BorrarCuponServlet")
public class BorrarCuponServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    CuponService cuponService;

    public void init() {
        cuponService = new CuponService();  // Inicializa el servicio de cupones
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtener el ID del cupón desde el formulario
        String idCupon = request.getParameter("idCupon");

        if (idCupon != null) {
            // Eliminar el cupón usando el servicio
            boolean eliminado = cuponService.eliminarCupon(Integer.parseInt(idCupon));

            if (eliminado) {
                // Redirigir al perfil con un mensaje de éxito
                request.getSession().setAttribute("mensaje", "Cupón eliminado correctamente.");
            } else {
                // Redirigir al perfil con un mensaje de error
                request.getSession().setAttribute("error", "Error al eliminar el cupón.");
            }
        } else {
            request.getSession().setAttribute("error", "ID de cupón no proporcionado.");
        }

        // Redirigir al perfil
        response.sendRedirect("PerfilServlet");
    }
}

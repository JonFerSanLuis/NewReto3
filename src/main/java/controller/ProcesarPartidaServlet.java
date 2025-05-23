package controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.bilbaoskp.dao.PartidaDAO;
import com.bilbaoskp.model.Centro;
import com.bilbaoskp.model.Partida;

@WebServlet("/ProcesarPartidaServlet")
public class ProcesarPartidaServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession sesion = request.getSession();
        Centro centro = (Centro) sesion.getAttribute("centro");

        if (centro == null || centro.getIdSuscriptor() <= 0) {
            response.sendRedirect("organizarPartida.jsp");
            return;
        }

        try {
            // 1. Recoger parámetros del formulario
            String nombreClase = request.getParameter("nombreClase");
            String escenario = request.getParameter("escenario");
            String idioma = request.getParameter("idioma");
            String fechaStr = request.getParameter("fechaActivacion");

            Date fecha = new SimpleDateFormat("yyyy-MM-dd").parse(fechaStr);

            // 2. Crear la partida
            Partida partida = new Partida();
            partida.setNombre(nombreClase);
            partida.setTipoPartida(escenario);
            partida.setIdioma(idioma);
            partida.setFecha(fecha);

            // 3. Guardar la partida
            PartidaDAO partidaDAO = new PartidaDAO();
            boolean guardado = partidaDAO.guardarPartida(partida, centro.getCodCentro());

            // 4. Generar código de acceso
            String codigoAcceso = generarCodigo();

            if (guardado) {
                // 5. Enviar correo
                String asunto = "Código de acceso - Escape Room contra el Ciberbullying";
                String mensaje = "Hola " + centro.getResponsable() + ",\n\n"
                        + "La partida ha sido registrada exitosamente.\n"
                        + "Código de acceso: " + codigoAcceso + "\n\n"
                        + "Nombre de la clase: " + nombreClase + "\n"
                        + "Escenario: " + escenario + "\n"
                        + "Idioma: " + idioma + "\n"
                        + "Fecha de activación: " + fechaStr + "\n\n"
                        + "Gracias por participar.";

                SendMesagge.enviarEmail(centro.getEmail(), asunto, mensaje);

                // 6. Redirigir al JSP de confirmación
                response.sendRedirect("confirmacionPartida.jsp?codigo=" + codigoAcceso);
            } else {
                response.sendRedirect("organizarPartida.jsp?error=guardar");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("organizarPartida.jsp?error=exception");
        }
    }

    // Método para generar código aleatorio
    private String generarCodigo() {
        String letras = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        String numeros = "0123456789";
        Random random = new Random();
        StringBuilder codigo = new StringBuilder();

        for (int i = 0; i < 3; i++) {
            codigo.append(letras.charAt(random.nextInt(letras.length())));
        }
        for (int i = 0; i < 3; i++) {
            codigo.append(numeros.charAt(random.nextInt(numeros.length())));
        }

        return codigo.toString();
    }
}

package controller;

import java.io.IOException;
import java.text.ParseException;
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

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession sesion = request.getSession();
        Centro centro = (Centro) sesion.getAttribute("centro");

        if (centro == null || centro.getIdSuscriptor() <= 0) {
            response.sendRedirect("organizarPartida.jsp");
            return;
        }

        try {
            String nombreClase = request.getParameter("nombreClase");
            String escenario = request.getParameter("escenario");
            String idioma = request.getParameter("idioma");
            String fechaStr = request.getParameter("fechaActivacion");
            
            if (nombreClase == null || escenario == null || idioma == null || fechaStr == null) {
                response.sendRedirect("organizarPartida.jsp?error=faltanParametros");
                return;
            }

            Date fecha = new SimpleDateFormat("yyyy-MM-dd").parse(fechaStr);

            Partida partida = new Partida();
            partida.setNombre(nombreClase);
            partida.setTipoPartida(escenario);
            partida.setIdioma(idioma);
            partida.setFecha(fecha);
            
            PartidaDAO partidaDAO = new PartidaDAO();
            boolean guardado = partidaDAO.guardarPartida(partida, centro.getCodCentro());

            if (!guardado) {
                response.sendRedirect("organizarPartida.jsp?error=guardar");
                return;
            }
            
            // código de acceso
            String codigoAcceso = generarCodigo();

                // envair correo
            String asunto = "Código de acceso - Escape Room contra el Ciberbullying";
            String mensaje = String.format(
                "Hola %s,\n\nLa partida ha sido registrada exitosamente.\n\nCódigo de acceso: %s\nClase: %s\nEscenario: %s\nIdioma: %s\nFecha: %s\n\nGracias por participar.",
                centro.getResponsable(), codigoAcceso, nombreClase, escenario, idioma, fechaStr
            );

            SendMesagge.enviarEmail(centro.getEmail(), asunto, mensaje);
            
            response.sendRedirect("confirmacionPartida.jsp?codigo=" + codigoAcceso);

        } catch (ParseException e) {
            e.printStackTrace();
            response.sendRedirect("organizarPartida.jsp?error=formatoFecha");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("organizarPartida.jsp?error=general");
        }
    }

    private String generarCodigo() {
        String letras = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        String numeros = "0123456789";
        Random r = new Random();
        return "" + letras.charAt(r.nextInt(26)) + letras.charAt(r.nextInt(26)) + letras.charAt(r.nextInt(26))
                   + numeros.charAt(r.nextInt(10)) + numeros.charAt(r.nextInt(10)) + numeros.charAt(r.nextInt(10));
    }
}

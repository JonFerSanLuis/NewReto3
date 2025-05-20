package controller;

import java.io.IOException;
import java.util.Properties;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class SendMesagge{

	// Tu correo real (el que usas para enviar)
	private static final String REMITENTE = "silverdayron20@gmail.com";
	private static final String CONTRASENA = "hgtqffihhsvdyhxl";

	// El correo que recibirá los mensajes
	private static final String DESTINATARIO = "aldo.dayron81@gmail.com";

	public static boolean enviarEmail(String emailUsuario, String asunto, String mensajeContenido) {
		// Configurar las propiedades SMTP
		Properties props = new Properties();
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.port", "587");

		// Crear la sesión
		Session session = Session.getInstance(props, new jakarta.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(REMITENTE, CONTRASENA);
			}
		});

		try {
			// Crear el mensaje
			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress(REMITENTE)); // Tu correo como remitente SMTP
			message.setReplyTo(InternetAddress.parse(emailUsuario)); // El correo del usuario como respuesta
			message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(DESTINATARIO)); // El destinatario
			message.setSubject(asunto); // Asunto escrito por el usuario
			message.setText(mensajeContenido); // Contenido del mensaje

			// Enviar el mensaje
			Transport.send(message);
			return true; // Si todo sale bien
		} catch (MessagingException e) {
			e.printStackTrace();
			return false; // Si algo falla
		}
	}
}
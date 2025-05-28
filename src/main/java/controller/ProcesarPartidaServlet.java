package controller;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Properties;
import java.util.Random;
import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.io.IOException;
import java.util.Properties;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.bilbaoskp.dao.PartidaDAO;
import com.bilbaoskp.model.Centro;
import com.bilbaoskp.model.Partida;

import service.CentroService;

@WebServlet("/ProcesarPartidaServlet")
public class ProcesarPartidaServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	
    	Cookie[] cookies = request.getCookies();
    	String username = null;
    	String cookieType = null;
    	if (cookies != null) {
    	    for (Cookie cookie : cookies) {
    	        if ("usuario".equals(cookie.getName())) {
    	            username = cookie.getValue();
    	        }else if ("tipo".equals(cookie.getName())) {
    	        	cookieType = cookie.getValue();
    	        }
    	    }
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


<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
    Cookie[] cookies = request.getCookies();
    String username = null;

    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if ("usuario".equals(cookie.getName())) {
                username = java.net.URLDecoder.decode(cookie.getValue(), "UTF-8");
                break;
            }
        }
    }
%>
<c:set var="idioma" value="${not empty sessionScope.idioma ? sessionScope.idioma : 'es'}" scope="session" />
<fmt:setLocale value="${idioma}" />
<fmt:setBundle basename="resources.messages" />

<!DOCTYPE html>
<html lang="${idioma}">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><fmt:message key="info.titulo" /></title>
    <!-- Google Fonts -->
    <link
        href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&family=Poppins:wght@300;400;500;600;700&display=swap"
        rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <!-- CSS -->
    <link rel="stylesheet" href="css/global.css">
    <link rel="stylesheet" href="css/pages/informacion.css">
    <!-- Asegurarse de que se incluya Font Awesome para los iconos -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
    <header class="header">
        <div class="logo">
            <a href="index.jsp"><img src="img/logo.png" alt="Logo"></a>
        </div>

        <nav class="nav-container">
            <ul class="nav-links">
                <li><a href="informacion.jsp"><fmt:message key="menu.informacion" /></a></li>
                <li><a href="Ranking"><fmt:message key="menu.ranking" /></a></li>
                <li><a href="comprarCupon.jsp"><fmt:message key="menu.comprarCupon" /></a></li>
            </ul>
        </nav>

        <div class="right-section">
            <div class="idiomas">
                <img src="img/idiomas.png" alt="Idiomas">
                <ul class="idioma-menu">
                    <li><a href="CambiarIdioma?idioma=es"><fmt:message key="idioma.espanol" /></a></li>
                    <li><a href="CambiarIdioma?idioma=en"><fmt:message key="idioma.ingles" /></a></li>
                    <li><a href="CambiarIdioma?idioma=eu"><fmt:message key="idioma.euskera" /></a></li>
                </ul>
            </div>
            <%   if (username != null) { 
			%>
			        <a href="PerfilServlet" class="btn">Perfil</a>
			<% 
			    } else { 
			%>
			        <a href="login.jsp" class="btn">Iniciar sesión</a>
			<% 
			    } 
			%>
			<%   if (username != null) { 
			%>
			        <!-- No se muestra el botón descargar si no hay cookie -->
			<% 
			    } else { 
			%>
			        <a href="suscribirse.jsp" class="btn"><fmt:message key="menu.suscribirse" /></a>
			<% 
			    } 
			%>
            <%   if (username != null) { 
			%>
			        <a href="private/descargarJuego.jsp" class="btn"><fmt:message key="menu.descargar" /></a>
			<% 
			    } else { 
			%>
			        <!-- No se muestra el botón descargar si no hay cookie -->
			<% 
			    } 
			%>
        </div>
    </header>

    <div class="main-content">
        <h1 class="page-title"><fmt:message key="info.titulo" /></h1>

        <div class="info-container">
            <section class="about-section">
                <div class="about-image">
                    <img src="img/Portada.png" alt="Sobre nosotros">
                </div>
                <div class="about-content">
                    <h2 class="section-title"><fmt:message key="info.sobreNosotros" /></h2>
                    <p><fmt:message key="info.sobreNosotrosTexto1" /></p>
                    <p><fmt:message key="info.sobreNosotrosTexto2" /></p>
                    <p><fmt:message key="info.sobreNosotrosTexto3" /></p>
                </div>
            </section>

            <section class="features-section">
                <h2 class="section-title"><fmt:message key="info.caracteristicas" /></h2>
                <div class="features-grid">
                    <div class="feature-card">
                        <h3 class="feature-title"><fmt:message key="info.mapaInteractivo" /></h3>
                        <p class="feature-description"><fmt:message key="info.mapaInteractivoDesc" /></p>
                    </div>
                    <div class="feature-card">
                        <h3 class="feature-title"><fmt:message key="info.sistemaRanking" /></h3>
                        <p class="feature-description"><fmt:message key="info.sistemaRankingDesc" /></p>
                    </div>
                    <div class="feature-card">
                        <h3 class="feature-title"><fmt:message key="info.cupones" /></h3>
                        <p class="feature-description"><fmt:message key="info.cuponesDesc" /></p>
                    </div>
                    <div class="feature-card">
                        <h3 class="feature-title"><fmt:message key="info.multijugador" /></h3>
                        <p class="feature-description"><fmt:message key="info.multijugadorDesc" /></p>
                    </div>
                    <div class="feature-card">
                        <h3 class="feature-title"><fmt:message key="info.contenidoEducativo" /></h3>
                        <p class="feature-description"><fmt:message key="info.contenidoEducativoDesc" /></p>
                    </div>
                    <div class="feature-card">
                        <h3 class="feature-title"><fmt:message key="info.actualizaciones" /></h3>
                        <p class="feature-description"><fmt:message key="info.actualizacionesDesc" /></p>
                    </div>
                </div>
            </section>

            <section class="contact-section">
                <h2 class="section-title"><fmt:message key="info.contacto" /></h2>
                <form class="contact-form" action="SendMesagge" method="post"> <%-- Added action and method --%>
                    <div class="form-group">
                        <label for="nombre"><fmt:message key="info.nombre" /></label>
                        <input type="text" id="nombre" name="nombre" placeholder="Tu nombre" required>
                    </div>
                    <div class="form-group">
                        <label for="email"><fmt:message key="info.email" /></label>
                        <input type="email" id="email" name="email" placeholder="ejemplo@correo.com" required>
                    </div>
                    <div class="form-group">
                        <label for="asunto"><fmt:message key="info.asunto" /></label>
                        <input type="text" id="asunto" name="asunto" placeholder="Asunto del mensaje" required>
                    </div>
                    <div class="form-group">
                        <label for="mensaje"><fmt:message key="info.mensaje" /></label>
                        <textarea id="mensaje" name="mensaje" placeholder="Escribe tu mensaje aquí..." required></textarea>
                    </div>
                    <div class="form-submit">
                        <button type="submit"><fmt:message key="info.enviar" /></button>
                    </div>
                </form>
            </section>
        </div>
    </div>

    <!-- Reemplazar el footer actual por el nuevo diseño -->
    <footer class="footer">
        <div class="footer-container">
            <div class="footer-section">
                <div class="footer-logo">
                    <img src="img/logo.png" alt="Logo Educación Divertida">
                </div>
                <p class="footer-description"><fmt:message key="footer.descripcion" /></p>
                <div class="social-links">
                    <a href="#"><i class="fab fa-facebook-f"></i></a>
                    <a href="#"><i class="fab fa-twitter"></i></a>
                    <a href="#"><i class="fab fa-instagram"></i></a>
                    <a href="#"><i class="fab fa-youtube"></i></a>
                </div>
            </div>

            <div class="footer-section">
                <h3 class="footer-title"><fmt:message key="footer.enlacesRapidos" /></h3>
                <ul class="footer-links">
                    <li><a href="#"><fmt:message key="footer.sobreNosotros" /></a></li>
                    <li><a href="#"><fmt:message key="footer.nuestrosCursos" /></a></li>
                    <li><a href="#"><fmt:message key="footer.testimonios" /></a></li>
                    <li><a href="#"><fmt:message key="footer.blogEducativo" /></a></li>
                    <li><a href="#"><fmt:message key="footer.preguntasFrecuentes" /></a></li>
                </ul>
            </div>

            <div class="footer-section">
                <h3 class="footer-title"><fmt:message key="footer.contacto" /></h3>
                <div class="footer-contact">
                    <p><i class="fas fa-map-marker-alt"></i> <fmt:message key="footer.direccion" /></p>
                    <p><i class="fas fa-phone"></i> <fmt:message key="footer.telefono" /></p>
                    <p><i class="fas fa-envelope"></i> <fmt:message key="footer.email" /></p>
                    <p><i class="fas fa-clock"></i> <fmt:message key="footer.horario" /></p>
                </div>
            </div>
        </div>

        <div class="footer-container">
            <div class="copyright">
                <fmt:message key="footer.copyright" />
            </div>
        </div>
    </footer>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const idiomas = document.querySelector('.idiomas');
            document.addEventListener('click', function(e) {
                if (idiomas.contains(e.target)) {
                    idiomas.classList.toggle('activo');
                } else {
                    idiomas.classList.remove('activo');
                }
            });
        });
    </script>
</body>
</html>
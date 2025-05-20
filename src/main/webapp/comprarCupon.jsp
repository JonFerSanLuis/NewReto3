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
    <title><fmt:message key="cupon.titulo" /></title>
    <!-- Google Fonts -->
    <link
        href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&family=Poppins:wght@300;400;500;600;700&display=swap"
        rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <!-- CSS -->
    <link rel="stylesheet" href="css/global.css">
    <link rel="stylesheet" href="css/pages/comprar-cupon.css">
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
        <h1 class="page-title"><fmt:message key="cupon.titulo" /></h1>

        <div class="cupon-container">
            <div class="cupon-options">
                <div class="cupon-card">
                    <div class="cupon-header">
                        <h3 class="cupon-title"><fmt:message key="cupon.basico" /></h3>
                        <div class="cupon-price">1.50€ <span>/unidad</span></div>
                    </div>
                    <div class="cupon-body">
                        <ul class="cupon-features">
                            <li>1 intento en el juego</li>
                            <li>Participación en el ranking</li>
                            <li>Acceso a contenido básico</li>
                        </ul>
                        <a href="#payment-form" class="cupon-button"><fmt:message key="cupon.seleccionar" /></a>
                    </div>
                </div>

                <div class="cupon-card">
                    <div class="cupon-header">
                        <h3 class="cupon-title"><fmt:message key="cupon.estandar" /></h3>
                        <div class="cupon-price">5€ <span>/unidad</span></div>
                    </div>
                    <div class="cupon-body">
                        <ul class="cupon-features">
                            <li>5 intentos en el juego</li>
                            <li>Participación en el ranking</li>
                            <li>Acceso a contenido premium</li>
                            <li>Soporte prioritario</li>
                        </ul>
                        <a href="#payment-form" class="cupon-button"><fmt:message key="cupon.seleccionar" /></a>
                    </div>
                </div>

                <div class="cupon-card">
                    <div class="cupon-header">
                        <h3 class="cupon-title"><fmt:message key="cupon.premium" /></h3>
                        <div class="cupon-price">12.50€ <span>/unidad</span></div>
                    </div>
                    <div class="cupon-body">
                        <ul class="cupon-features">
                            <li>12 intentos en el juego</li>
                            <li>Participación en el ranking</li>
                            <li>Acceso a todo el contenido</li>
                            <li>Soporte prioritario 24/7</li>
                            <li>Recompensas exclusivas</li>
                        </ul>
                        <a href="#payment-form" class="cupon-button"><fmt:message key="cupon.seleccionar" /></a>
                    </div>
                </div>
            </div>
			  <div id="payment-form" class="payment-form">
			    <h2 class="form-title"><fmt:message key="cupon.infoPago" /></h2>
			    <form action="getCupon" method="POST">
			        <div class="form-group">
			            <label for="nombre"><fmt:message key="cupon.nombreCompleto" /></label>
			            <input type="text" id="nombre" name="nombre" placeholder="Nombre de usuario" required>
			        </div>
			        <div class="form-group">
			            <label for="email"><fmt:message key="cupon.email" /></label>
			            <input type="email" id="email" name="email" placeholder="ejemplo@correo.com" required>
			        </div>
			        <div class="form-group">
			            <label for="cupon"><fmt:message key="cupon.tipoCupon" /></label>
			            <select id="cupon" name="cupon" required>
			                <option value=""><fmt:message key="cupon.seleccioneCupon" /></option>
			                <option value="Cupón Basico"><fmt:message key="cupon.basico" /> - 1.50€</option>
			                <option value="Pack Estándar"><fmt:message key="cupon.estandar" /> - 5€</option>
			                <option value="Pack Premium"><fmt:message key="cupon.premium" /> - 12.50€</option>
			            </select>
			        </div>
			        <div class="form-group">
			            <label for="cantidad"><fmt:message key="cupon.cantidad" /></label>
			            <input type="number" id="cantidad" name="cantidad" min="1" value="1" required>
			        </div>
			        <div class="form-group">
			            <label for="tarjeta"><fmt:message key="cupon.numeroTarjeta" /></label>
			            <input type="text" id="tarjeta" name="tarjeta" placeholder="1234 5678 9012 3456" required>
			        </div>
			        <div class="form-row">
			            <div class="form-group">
			                <label for="caducidad"><fmt:message key="cupon.fechaCaducidad" /></label>
			                <input type="text" id="caducidad" name="caducidad" placeholder="MM/AA" required>
			            </div>
			            <div class="form-group">
			                <label for="cvv"><fmt:message key="cupon.cvv" /></label>
			                <input type="text" id="cvv" name="cvv" placeholder="123" required>
			            </div>
			        </div>
			        <div class="form-submit">
			            <button type="submit"><fmt:message key="cupon.completarCompra" /></button>
			        </div>
			    </form>
			</div>
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
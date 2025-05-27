<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

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

<c:set var="idioma"
	value="${not empty sessionScope.idioma ? sessionScope.idioma : 'es'}"
	scope="session" />
<fmt:setLocale value="${idioma}" />
<fmt:setBundle basename="resources.messages" />

<!DOCTYPE html>
<html lang="${idioma}">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Gestionar Centros Pendientes</title>
<!-- Google Fonts -->
<link
	href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&family=Poppins:wght@300;400;500;600;700&display=swap"
	rel="stylesheet">
<!-- Font Awesome -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<!-- CSS -->
<link rel="stylesheet" href="css/global.css">
<link rel="stylesheet" href="css/pages/admin-usuarios.css">
<link rel="stylesheet" href="css/pages/admin-pending-centers.css">
</head>
<body>
	<header class="header">
		<div class="logo">
			<a href="index.jsp"><img src="img/logo.png" alt="Logo"></a>
		</div>
		<nav class="nav-container">
			<ul class="nav-links">
				<li><a href="PerfilServlet">Volver al Panel</a></li>
				<li><a href="AdminUsuarios?action=listar">Gestionar
						Usuarios</a></li>
				<li><a href="AdminUsuarios?action=listarPendientes"
					class="active">Gestionar Centros Pendientes</a></li>
			</ul>
		</nav>

		<div class="right-section">
			<div class="idiomas">
				<img src="img/idiomas.png" alt="Idiomas">
				<ul class="idioma-menu">
					<li><a
						href="CambiarIdioma?idioma=es&redirect=AdminUsuarios?action=listarPendientes">Español</a></li>
					<li><a
						href="CambiarIdioma?idioma=en&redirect=AdminUsuarios?action=listarPendientes">English</a></li>
					<li><a
						href="CambiarIdioma?idioma=eu&redirect=AdminUsuarios?action=listarPendientes">Euskera</a></li>
				</ul>
			</div>
			<%
			if (username != null) {
			%>
			<a href="PerfilServlet" class="btn">Perfil</a> <a
				href="private/descargarJuego.jsp" class="btn">Descargar</a>
			<div class="action-buttons">
				<form action="CerrarSesionServlet" method="post">
					<button type="submit" class="btn btn-logout">Cerrar Sesión</button>
					<%-- Reverted --%>
				</form>
				<%
				} else {
				%>
				<a href="login.jsp" class="btn">Iniciar Sesión</a>
				<%
				}
				%>
			</div>
	</header>

	<div class="main-content">
		<h1 class="page-title">Gestionar Centros Pendientes</h1>

		<!-- Mensajes de éxito o error -->
		<c:if test="${not empty sessionScope.mensaje}">
			<div class="alert alert-success">
				${sessionScope.mensaje}
				<c:remove var="mensaje" scope="session" />
			</div>
		</c:if>
		<c:if test="${not empty sessionScope.error}">
			<div class="alert alert-danger">
				${sessionScope.error}
				<c:remove var="error" scope="session" />
			</div>
		</c:if>

		<div class="admin-container">
			<section class="pending-centers-section">
				<div class="section-header">
					<h2 class="section-title">
						<i class="fas fa-school"></i> Centros Pendientes de Aprobación
					</h2>
					<p class="section-description">Revisa y gestiona las
						solicitudes de registro de centros educativos</p>
				</div>

				<c:choose>
					<c:when test="${empty listaCentrosPendientes}">
						<div class="empty-state">
							<div class="empty-state-icon">
								<i class="fas fa-inbox"></i>
							</div>
							<h3>No hay centros pendientes</h3>
							<p>Actualmente no hay solicitudes de centros pendientes de
								aprobación.</p>
						</div>
					</c:when>
					<c:otherwise>
						<div class="table-container">
							<table class="users-table">
								<thead>
									<tr>
										<th><i class="fas fa-hashtag"></i> ID</th>
										<th><i class="fas fa-user"></i> Responsable</th>
										<th><i class="fas fa-envelope"></i> Correo Electrónico</th>
										<th><i class="fas fa-tag"></i> Tipo</th>
										<th><i class="fas fa-circle"></i> Estado</th>
										<th><i class="fas fa-calendar"></i> Fecha Solicitud</th>
										<th><i class="fas fa-cogs"></i> Acciones</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="centro" items="${listaCentrosPendientes}">
										<tr>
											<td><span class="id-badge">${centro.idSuscriptor}</span>
											</td>
											<td>
												<div class="user-info">
													<div class="user-avatar">
														<i class="fas fa-user-tie"></i>
													</div>
													<span class="user-name">${centro.username}</span>
												</div>
											</td>
											<td><span class="email">${centro.correo}</span></td>
											<td><span class="type-badge type-centro">${centro.tipo}</span>
											</td>
											<td><span class="status-badge status-pending"> <i
													class="fas fa-clock"></i> ${centro.estado}
											</span></td>
											<td><span class="date"> <fmt:formatDate
														value="${centro.fechaAlta}" pattern="dd/MM/yyyy" />
											</span></td>
											<td class="actions">
												<form action="AdminUsuarios" method="post"
													style="display: inline;">
													<input type="hidden" name="action" value="aceptarCentro">
													<input type="hidden" name="id"
														value="${centro.idSuscriptor}">
													<button type="submit" class="action-btn accept-btn"
														title="Aceptar Centro">
														<i class="fas fa-check"></i>
													</button>
												</form>
												<button
													onclick="confirmarRechazarCentro(${centro.idSuscriptor}, '${centro.username}')"
													class="action-btn reject-btn" title="Rechazar Centro">
													<i class="fas fa-times"></i>
												</button> <a
												href="AdminUsuarios?action=detalles&id=${centro.idSuscriptor}"
												class="action-btn details-btn" title="Ver Detalles"> <i
													class="fas fa-info-circle"></i>
											</a>
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</c:otherwise>
				</c:choose>
			</section>
		</div>
	</div>

	<!-- Modal de confirmación para rechazar centro -->
	<div id="modal-rechazar-centro" class="modal">
		<div class="modal-content">
			<div class="modal-header">
				<h2>
					<i class="fas fa-exclamation-triangle"></i> Confirmar Rechazo
				</h2>
				<span class="close-modal-rechazar-centro">&times;</span>
			</div>
			<div class="modal-body">
				<p id="mensaje-confirmacion-rechazo"></p>
				<div class="warning-note">
					<i class="fas fa-info-circle"></i> Esta acción no se puede
					deshacer. El centro será eliminado permanentemente.
				</div>
			</div>
			<div class="modal-footer">
				<button id="btn-cancelar-rechazar-centro" class="btn-secondary">
					<i class="fas fa-times"></i> Cancelar
				</button>
				<form id="form-rechazar-centro" action="AdminUsuarios" method="post"
					style="display: inline;">
					<input type="hidden" name="action" value="rechazarCentro">
					<input type="hidden" id="id-rechazar-centro" name="id" value="">
					<button type="submit" class="btn-danger">
						<i class="fas fa-trash"></i> Rechazar
					</button>
				</form>
			</div>
		</div>
	</div>

	<!-- Footer -->
	<footer class="footer">
		<div class="footer-container">
			<div class="footer-section">
				<div class="footer-logo">
					<img src="img/logo.png" alt="Logo Educación Divertida">
				</div>
				<p class="footer-description">Transformamos la educación en una
					experiencia divertida y memorable. Nuestro método innovador
					garantiza el aprendizaje efectivo.</p>
				<div class="social-links">
					<a href="#"><i class="fab fa-facebook-f"></i></a> <a href="#"><i
						class="fab fa-twitter"></i></a> <a href="#"><i
						class="fab fa-instagram"></i></a> <a href="#"><i
						class="fab fa-youtube"></i></a>
				</div>
			</div>

			<div class="footer-section">
				<h3 class="footer-title">Enlaces rápidos</h3>
				<ul class="footer-links">
					<li><a href="index.jsp">Inicio</a></li>
					<li><a href="informacion.jsp">Sobre nosotros</a></li>
					<li><a href="contacto-exito.jsp">Contacto</a></li>
				</ul>
			</div>

			<div class="footer-section">
				<h3 class="footer-title">Contacto</h3>
				<div class="footer-contact">
					<p>
						<i class="fas fa-map-marker-alt"></i> Calle Educación 123, Madrid,
						España
					</p>
					<p>
						<i class="fas fa-phone"></i> +34 912 345 678
					</p>
					<p>
						<i class="fas fa-envelope"></i> info@educaciondivertida.com
					</p>
					<p>
						<i class="fas fa-clock"></i> Lunes-Viernes: 9:00 - 18:00
					</p>
				</div>
			</div>
		</div>

		<div class="footer-container">
			<div class="copyright">© 2025 Educación Divertida. Todos los
				derechos reservados.</div>
		</div>
	</footer>

	<script>
        // Script para el menú de idiomas
        document.addEventListener('DOMContentLoaded', function() {
            const idiomas = document.querySelector('.idiomas');
            if (idiomas) {
                document.addEventListener('click', function(e) {
                    if (idiomas.contains(e.target)) {
                        idiomas.classList.toggle('activo');
                    } else {
                        idiomas.classList.remove('activo');
                    }
                });
            }
        });

        // Script para el modal de confirmación de rechazo de centro
        const modalRechazar = document.getElementById('modal-rechazar-centro');
        const mensajeConfirmacionRechazo = document.getElementById('mensaje-confirmacion-rechazo');
        
        function confirmarRechazarCentro(id, nombre) {
            if (modalRechazar) {
                document.getElementById('id-rechazar-centro').value = id;
                mensajeConfirmacionRechazo.innerHTML = `¿Está seguro de que desea rechazar la solicitud del centro <strong>${nombre}</strong>?`;
                modalRechazar.style.display = 'flex';
            }
        }

        const closeModalRechazarBtn = document.querySelector('.close-modal-rechazar-centro');
        if(closeModalRechazarBtn) {
            closeModalRechazarBtn.addEventListener('click', function() {
                if (modalRechazar) modalRechazar.style.display = 'none';
            });
        }

        const btnCancelarRechazarCentro = document.getElementById('btn-cancelar-rechazar-centro');
        if (btnCancelarRechazarCentro) {
            btnCancelarRechazarCentro.addEventListener('click', function() {
                if (modalRechazar) modalRechazar.style.display = 'none';
            });
        }

        window.addEventListener('click', function(event) {
            if (event.target == modalRechazar) {
                if (modalRechazar) modalRechazar.style.display = 'none';
            }
        });
    </script>
</body>
</html>
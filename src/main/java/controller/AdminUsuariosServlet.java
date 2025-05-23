package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bilbaoskp.dao.SuscriptorDAO;
import com.bilbaoskp.model.Suscriptor;

@WebServlet("/AdminUsuarios")
public class AdminUsuariosServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private SuscriptorDAO suscriptorDAO;
    
    public void init() {
        suscriptorDAO = new SuscriptorDAO();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if (action == null) {
            action = "listar";
        }
        
        switch (action) {
            case "editar":
                mostrarFormularioEdicion(request, response);
                break;
            case "detalles":
                mostrarDetallesUsuario(request, response);
                break;
            default:
                listarUsuarios(request, response);
                break;
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if (action == null) {
            action = "listar";
        }
        
        switch (action) {
            case "actualizar":
                actualizarUsuario(request, response);
                break;
            case "eliminar":
                eliminarUsuario(request, response);
                break;
            default:
                listarUsuarios(request, response);
                break;
        }
    }
    
    private void listarUsuarios(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idBusqueda = request.getParameter("id");
        String nombreBusqueda = request.getParameter("nombre");
        
        List<Suscriptor> usuarios;
        
        if (idBusqueda != null && !idBusqueda.isEmpty()) {
            try {
                int id = Integer.parseInt(idBusqueda);
                Suscriptor usuario = suscriptorDAO.getSuscriptorById(id);
                usuarios = usuario != null ? List.of(usuario) : List.of();
            } catch (NumberFormatException e) {
                usuarios = List.of();
            }
        } else if (nombreBusqueda != null && !nombreBusqueda.isEmpty()) {
            usuarios = suscriptorDAO.getSuscriptoresByNombre(nombreBusqueda);
        } else {
            usuarios = suscriptorDAO.getAllSuscriptores();
        }
        
        request.setAttribute("listaUsuarios", usuarios);
        request.getRequestDispatcher("private/admin-usuarios.jsp").forward(request, response);
    }
    
    private void mostrarFormularioEdicion(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Suscriptor usuario = suscriptorDAO.getSuscriptorById(id);
            
            if (usuario != null) {
                request.setAttribute("usuario", usuario);
                request.getRequestDispatcher("private/admin-editar-usuario.jsp").forward(request, response);
            } else {
                response.sendRedirect("AdminUsuarios");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("AdminUsuarios");
        }
    }
    
    private void mostrarDetallesUsuario(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Suscriptor usuario = suscriptorDAO.getSuscriptorById(id);
            
            if (usuario != null) {
                request.setAttribute("usuario", usuario);
                // Por ahora redirigimos a la p�gina de edici�n ya que no tenemos una p�gina de detalles
                request.getRequestDispatcher("private/admin-editar-usuario.jsp").forward(request, response);
            } else {
                response.sendRedirect("AdminUsuarios");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("AdminUsuarios");
        }
    }
    
    private void actualizarUsuario(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Suscriptor usuario = suscriptorDAO.getSuscriptorById(id);
            
            if (usuario != null) {
                usuario.setUsername(request.getParameter("username"));
                usuario.setCorreo(request.getParameter("correo"));
                usuario.setTipo(request.getParameter("tipo"));
                usuario.setEstado(request.getParameter("estado"));
                
                String edadStr = request.getParameter("edad");
                if (edadStr != null && !edadStr.isEmpty()) {
                    try {
                        usuario.setEdad(Integer.parseInt(edadStr));
                    } catch (NumberFormatException e) {
                        // Si hay error en la conversi�n, se deja el valor actual
                    }
                }
                
                String nuevaPassword = request.getParameter("nuevaPassword");
                if (nuevaPassword != null && !nuevaPassword.isEmpty()) {
                    usuario.setPassword(nuevaPassword);
                }
                
                boolean actualizado = suscriptorDAO.updateSuscriptor(usuario);
                
                if (actualizado) {
                    request.getSession().setAttribute("mensaje", "Usuario actualizado correctamente");
                } else {
                    request.getSession().setAttribute("error", "Error al actualizar el usuario");
                }
            }
            
            response.sendRedirect("AdminUsuarios");
        } catch (NumberFormatException e) {
            response.sendRedirect("AdminUsuarios");
        }
    }
    
    private void eliminarUsuario(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            
            boolean eliminado = suscriptorDAO.deleteSuscriptor(id);
            
            if (eliminado) {
                request.getSession().setAttribute("mensaje", "Usuario eliminado correctamente");
            } else {
                request.getSession().setAttribute("error", "Error al eliminar el usuario");
            }
            
            response.sendRedirect("AdminUsuarios");
        } catch (NumberFormatException e) {
            response.sendRedirect("AdminUsuarios");
        }
    }
}
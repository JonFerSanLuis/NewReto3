package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bilbaoskp.model.RankingUsuario;

import service.RankingService;

/**
 * Servlet para manejar las peticiones relacionadas con el ranking
 */
@WebServlet("/Ranking")
public class RankingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private RankingService rankingService;
    
    public void init() {
        rankingService = new RankingService();
    }
       
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtener parámetro de búsqueda si existe
        String busqueda = request.getParameter("busqueda");
        List<RankingUsuario> listaRanking;
        
        // Si hay término de búsqueda, filtrar resultados
        if (busqueda != null && !busqueda.trim().isEmpty()) {
            listaRanking = rankingService.buscarUsuariosPorNombre(busqueda);
        } else {
            // Si no hay búsqueda, mostrar ranking completo
            listaRanking = rankingService.obtenerRanking();
        }
        
        // Guardar la lista en el request para usarla en el JSP
        request.setAttribute("listaRanking", listaRanking);
        
        // Redirigir al JSP de ranking
        request.getRequestDispatcher("ranking.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
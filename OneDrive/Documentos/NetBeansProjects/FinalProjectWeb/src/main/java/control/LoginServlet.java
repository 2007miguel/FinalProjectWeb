package control;

import entities.Users;
import jpa.UsersJpaController;
import java.io.IOException;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

    private UsersJpaController usersJPA;

    @Override
    public void init() throws ServletException {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("com.mycompany_FinalProjectWeb_war_1.0-SNAPSHOTPU");
        usersJPA = new UsersJpaController(emf);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Busca el usuario en la base de datos
        Users user = usersJPA.findUsers(username);

        if (user != null && user.getPassword().equals(password)) {
            // Usuario autenticado, crea la sesión
            HttpSession session = request.getSession();
            session.setAttribute("user", user); 
            session.setAttribute("canViewConsultations", user.isAdmin());
            response.sendRedirect("DashboardServlet");
            //response.sendRedirect("dashboard.jsp"); // Redirige al panel de control
        } else {
            // Usuario o contraseña incorrectos
            request.setAttribute("errorMessage", "Usuario o contraseña incorrectos.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}


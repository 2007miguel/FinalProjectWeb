package control;

import entities.Books;
import jpa.BooksJpaController;
import java.io.IOException;
import java.util.List;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "DashboardServlet", urlPatterns = {"/DashboardServlet"})
public class DashboardServlet extends HttpServlet {

    private BooksJpaController booksController;

    @Override
    public void init() {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("com.mycompany_FinalProjectWeb_war_1.0-SNAPSHOTPU");
        booksController = new BooksJpaController(emf);
        System.out.println("----------------------------");
        System.out.println("----------------------------");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Recuperar el atributo de la sesión
        Boolean canViewConsultations = (Boolean) request.getSession().getAttribute("canViewConsultations");
        if (canViewConsultations == null) {
            canViewConsultations = false; // Por defecto, no es administrador
        }

        // Recupera los libros desde la base de datos
        List<Books> books = booksController.findBooksEntities();
        // Pasa los libros al JSP
        request.setAttribute("books", books);
        request.setAttribute("canViewConsultations", canViewConsultations);
        for (Books book : books) {
            System.out.println("Libro: "+book.getTitle());
        }

        // Redirige al dashboard.jsp
        request.getRequestDispatcher("dashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            String title = request.getParameter("title");
            Integer yearPublished = Integer.parseInt(request.getParameter("year_published"));
            Books book = new Books();
            book.setTitle(title);
            book.setYearPublished(yearPublished);
            booksController.create(book);
        } else if ("delete".equals(action)) {
            Integer bookId = Integer.parseInt(request.getParameter("book_id"));
            booksController.delete(bookId);
        }

        response.sendRedirect("DashboardServlet");
    }
}


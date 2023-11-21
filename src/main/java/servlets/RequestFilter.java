package servlets;
import javax.servlet.*;
import java.io.IOException;

public class RequestFilter implements Filter{


    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        String contentType = servletResponse.getContentType();

        if (contentType != null && contentType.contains("text/html")) {
            RequestDispatcher dispatcher = servletRequest.getRequestDispatcher("/controllerServlet");
            dispatcher.forward(servletRequest, servletResponse);
        } else {
            filterChain.doFilter(servletRequest, servletResponse);
        }
    }

    @Override
    public void destroy() {

    }
}

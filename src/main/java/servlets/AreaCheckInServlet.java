package servlets;



import com.google.gson.Gson;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;


public class AreaCheckInServlet extends HttpServlet {
    private final List<Integer> xValues = Arrays.asList(-4, -3, -2, -1, 0, 1, 2, 3, 4);
    private final List<Integer> rValues = Arrays.asList(1, 2, 3, 4, 5);

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        long time = System.currentTimeMillis();
        ServletContext servletContext = getServletContext();
        Gson gson = new Gson();
        PrintWriter writer = resp.getWriter();
        try {
            int x = Integer.parseInt(req.getParameter("x"));
            double y = Double.parseDouble(req.getParameter("y"));
            int r = Integer.parseInt(req.getParameter("r"));
            if (!checkParams(x, y, r)) throw new NumberFormatException();
            Point point = new Point(x, y, r, checkInArea(x, y, r), System.currentTimeMillis() - time);
            savePoint(point, servletContext);
            resp.setContentType("application/json");
            writer.print(gson.toJson(point));
            writer.flush();
        } catch (NullPointerException | NumberFormatException exception) {
            writer.print(exception);
        }
    }


    private boolean checkParams(int x, double y, int r) {
        return xValues.contains(x) && y >= -5.0 && y <= 5.0 && rValues.contains(r);
    }

    private boolean checkInArea(Integer x, Double y, Integer r) {
        double newR = Double.parseDouble(r.toString());
        return (x <= 0 && y >= 0 && (x * x + y * y <= (newR / 2) * (newR / 2))) || (x >= 0 && y >= 0 && (x + y <= newR / 2)) || (x >= 0 && y <= 0 && x <= r && Math.abs(y) <= r);
    }

    private void savePoint(Point p, ServletContext servletContext) {
        if (servletContext.getAttribute("history") == null) {
            servletContext.setAttribute("history", new ArrayList<Point>());
        }

        ArrayList<Point> history = (ArrayList<Point>) servletContext.getAttribute("history");
        history.add(p);
        servletContext.setAttribute("history", history);
    }
}

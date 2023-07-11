package userlogin;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import userlogin.databaseconnection;

@WebServlet("/passwordupdate")
public class passwordupdate extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");

        try {
            Connection con = databaseconnection.getConnection();
            String question = getSecurityQuestion(con, username);

            if (question != null) {
                HttpSession session = request.getSession();
                session.setAttribute("username", username);
                session.setAttribute("question", question);
                response.sendRedirect("passwordUpdate.jsp");
            } else {
                request.setAttribute("error", "Invalid username");
                request.getRequestDispatcher("passwordUpdate.jsp").forward(request, response);
            }

            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private String getSecurityQuestion(Connection con, String username) throws SQLException {
        String question = null;
        String sql = "SELECT question_text FROM security_question WHERE security_id = (Select security_id from user WHERE username = ?)";
        PreparedStatement statement = con.prepareStatement(sql);
        statement.setString(1, username);
        ResultSet resultSet = statement.executeQuery();

        if (resultSet.next()) {
            question = resultSet.getString("security_question");
        }

        resultSet.close();
        statement.close();

        return question;
    }
}

<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cancel Booking</title>
    <style>
        form {
            text-align: center;
            margin-top: 20px;
        }
        input {
            padding: 10px;
            font-size: 16px;
            margin-bottom: 10px;
            width: 200px;
        }
        button {
            padding: 10px 20px;
            background-color: #ff4d4d;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        button:hover {
            background-color: #cc0000;
        }
    </style>
</head>
<body>
    <h2>Cancel Your Booking</h2>

    <form method="POST" action="cancelBooking.jsp">
        <label for="bookingId">Booking ID:</label>
        <input type="text" id="bookingId" name="bookingId" placeholder="Enter Booking ID to Cancel" required><br>
        
        <button type="submit">Cancel Booking</button>
    </form>

    <%
        String dbURL = "jdbc:mysql://localhost:3306/movie";
        String dbUser = "root";
        String dbPassword = "password";

        String bookingId = request.getParameter("bookingId");

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            // Load JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

            if (bookingId != null && !bookingId.isEmpty()) {
                // Delete the booking record based on bookingId
                String sql = "DELETE FROM ticket_booking WHERE id=?";
                stmt = conn.prepareStatement(sql);
                stmt.setInt(1, Integer.parseInt(bookingId));

                int rowsDeleted = stmt.executeUpdate();

                if (rowsDeleted > 0) {
                    out.println("<h3>Booking Cancelled Successfully!</h3>");
                } else {
                    out.println("<h3>No booking found with the provided Booking ID.</h3>");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<h3>Error: " + e.getMessage() + "</h3>");
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    %>
</body>
</html>
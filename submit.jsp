<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Movie Ticket Booking - Confirmation</title>
</head>
<body>

<%
    // Retrieve phone number from session
    String phoneNumber = (String) session.getAttribute("phone_number");

    if (phoneNumber == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Retrieve form data
    String language = request.getParameter("language");
    String showDate = request.getParameter("show_date");
    String city = request.getParameter("city");
    String movie = request.getParameter("movie");
    String theater = request.getParameter("theater");
    String seats = request.getParameter("seats");  // Expecting a comma-separated list
    double totalAmount = Double.parseDouble(request.getParameter("total_amount"));
    double discount = Double.parseDouble(request.getParameter("discount"));
    double finalPrice = Double.parseDouble(request.getParameter("final_price"));

    // Database connection parameters
    String dbURL = "jdbc:mysql://localhost:3306/movie"; // Update with your database URL
    String dbUser = "root";  // Replace with your database username
    String dbPassword = "password";  // Replace with your database password

    Connection conn = null;
    PreparedStatement ps = null;

    try {
        // Load and register the JDBC driver (if needed)
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Establish the connection
        conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

        // Insert data into the bookings table
        String sql = "INSERT INTO bookings (phone_number, language, show_date, city, movie, theater, seats, total_amount, discount, final_price) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        ps = conn.prepareStatement(sql);
        ps.setString(1, phoneNumber);  // Phone number from session
        ps.setString(2, language);
        ps.setString(3, showDate);
        ps.setString(4, city);
        ps.setString(5, movie);
        ps.setString(6, theater);
        ps.setString(7, seats);
        ps.setDouble(8, totalAmount);
        ps.setDouble(9, discount);
        ps.setDouble(10, finalPrice);

        // Execute the insert operation
        int rowsInserted = ps.executeUpdate();

        if (rowsInserted > 0) {
            out.println("<h2>Your booking has been confirmed!</h2>");
            out.println("<p>Thank you for booking your movie ticket.</p>");
        } else {
            out.println("<h2>There was an error with your booking. Please try again later.</h2>");
        }

    } catch (Exception e) {
        e.printStackTrace();
        out.println("<h2>Error: " + e.getMessage() + "</h2>");
    } finally {
        try {
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
</body>
</html>
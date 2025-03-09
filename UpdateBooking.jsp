%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Booking</title>
    <style>
        form {
            text-align: center;
            margin-top: 20px;
        }
        input, select {
            padding: 10px;
            font-size: 16px;
            margin-bottom: 10px;
            width: 200px;
        }
        button {
            padding: 10px 20px;
            background-color: #28a745;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        button:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>
    <h2>Update Booking Details</h2>

    <form method="POST" action="updateBooking.jsp">
        <label for="bookingId">Booking ID:</label>
        <input type="text" id="bookingId" name="bookingId" placeholder="Enter Booking ID" required><br>
        
        <label for="phoneNumber">Phone Number:</label>
        <input type="text" id="phoneNumber" name="phoneNumber" placeholder="Enter New Phone Number" required><br>
        
        <label for="language">Language:</label>
        <select id="language" name="language">
            <option value="Telugu">Telugu</option>
            <option value="English">English</option>
            <option value="Hindi">Hindi</option>
        </select><br>
        
        <label for="movie">Movie:</label>
        <input type="text" id="movie" name="movie" placeholder="Enter Movie Name" required><br>
        
        <label for="seats">Seats:</label>
        <input type="text" id="seats" name="seats" placeholder="Enter Seats" required><br>
        
        <button type="submit">Update Booking</button>
    </form>

    <%
        String dbURL = "jdbc:mysql://localhost:3306/movie";
        String dbUser = "root";
        String dbPassword = "password";
        
        String bookingId = request.getParameter("bookingId");
        String phoneNumber = request.getParameter("phoneNumber");
        String language = request.getParameter("language");
        String movie = request.getParameter("movie");
        String seats = request.getParameter("seats");

        Connection conn = null;
        PreparedStatement stmt = null;
        
        try {
            // Load JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);
            
            if (bookingId != null && !bookingId.isEmpty()) {
                // Update the booking record based on bookingId
                String sql = "UPDATE ticket_booking SET phone_number=?, language=?, movie=?, seats=? WHERE id=?";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, phoneNumber);
                stmt.setString(2, language);
                stmt.setString(3, movie);
                stmt.setString(4, seats);
                stmt.setInt(5, Integer.parseInt(bookingId));
                
                int rowsUpdated = stmt.executeUpdate();
                
                if (rowsUpdated > 0) {
                    out.println("<h3>Booking Updated Successfully!</h3>");
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
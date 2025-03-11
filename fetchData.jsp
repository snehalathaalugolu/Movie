<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Fetch Data</title>
</head>
<body>
    <h2>Users Table Data</h2>
    <table border="1">
        <tr>
            <th>Phone Number</th>
            <th>Password</th>
        </tr>
        <%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/movie", "root", "password");
                Statement stmt = con.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT * FROM users");
                while (rs.next()) {
                    out.println("<tr><td>" + rs.getString("phone_number") + "</td><td>" + rs.getString("password") + "</td></tr>");
                }
                con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
    </table>

    <h2>Bookings Table Data</h2>
    <table border="1">
        <tr>
            <th>Booking ID</th>
            <th>Phone Number</th>
            <th>Language</th>
            <th>Show Date</th>
            <th>City</th>
            <th>Movie</th>
            <th>Theater</th>
            <th>Seats</th>
            <th>Total Amount</th>
            <th>Discount</th>
            <th>Final Price</th>
            <th>Booking Time</th>
        </tr>
        <%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/movie", "root", "password");
                Statement stmt = con.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT * FROM bookings");
                while (rs.next()) {
                    out.println("<tr><td>" + rs.getInt("booking_id") + "</td><td>" + rs.getString("phone_number") + "</td><td>" + rs.getString("language") + "</td><td>" + rs.getDate("show_date") + "</td><td>" + rs.getString("city") + "</td><td>" + rs.getString("movie") + "</td><td>" + rs.getString("theater") + "</td><td>" + rs.getString("seats") + "</td><td>" + rs.getBigDecimal("total_amount") + "</td><td>" + rs.getBigDecimal("discount") + "</td><td>" + rs.getBigDecimal("final_price") + "</td><td>" + rs.getTimestamp("booking_time") + "</td></tr>");
                }
                con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
    </table>
</body>
</html>
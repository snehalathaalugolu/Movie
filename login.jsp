<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login</title>
    <script>
        function validateLogin() {
            let phone = document.getElementById("phone_number").value;
            let password = document.getElementById("password").value;

            if (!/^\d{10}$/.test(phone)) {
                alert("Enter a valid 10-digit phone number.");
                return false;
            }
            if (password.length < 6) {
                alert("Password must be at least 6 characters.");
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
    <form method="post" action="login.jsp" onsubmit="return validateLogin()">
        <h2>Login</h2>
        Phone Number: <input type="text" name="phone_number" id="phone_number" required><br>
        Password: <input type="password" name="password" id="password" required><br>
        <input type="submit" value="Login">
    </form>

<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String phone = request.getParameter("phone_number");
    String pass = request.getParameter("password");

    if (phone != null && pass != null) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost/movie_booking", "root", "password");

            PreparedStatement ps = con.prepareStatement("SELECT * FROM users WHERE phone_number=? AND password=?");
            ps.setString(1, phone);
            ps.setString(2, pass);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // Start session and store phone number
                session.setAttribute("phone_number", phone);
                
                // Redirect to index.html
                response.sendRedirect("index.html");
            } else {
                response.sendRedirect("register.jsp?phone=" + phone);
            }
            con.close();
        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
        }
    }
%>
       
</body>
</html>
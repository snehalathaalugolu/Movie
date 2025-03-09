<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Register</title>
    <script>
        function validateRegister() {
            let phone = document.getElementById("phone_number").value;
            let password = document.getElementById("password").value;
            let confirmPassword = document.getElementById("confirm_password").value;

            if (!/^\d{10}$/.test(phone)) {
                alert("Enter a valid 10-digit phone number.");
                return false;
            }
            if (password.length < 6) {
                alert("Password must be at least 6 characters.");
                return false;
            }
            if (password !== confirmPassword) {
                alert("Passwords do not match.");
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
    <form method="post" action="register.jsp" onsubmit="return validateRegister()">
        <h2>Register</h2>
        Phone Number: <input type="text" name="phone_number" id="phone_number" required><br>
        Password: <input type="password" name="password" id="password" required><br>
        Confirm Password: <input type="password" id="confirm_password" required><br>
        <input type="submit" value="Register">
    </form>

    <% 
        String phone = request.getParameter("phone_number");
        String pass = request.getParameter("password");

        if (phone != null && pass != null) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost/movie_booking", "root", "password");

                PreparedStatement checkUser = con.prepareStatement("SELECT * FROM users WHERE phone_number=?");
                checkUser.setString(1, phone);
                ResultSet rs = checkUser.executeQuery();

                if (rs.next()) {
                    out.println("User already exists! <a href='login.jsp'>Login here</a>");
                } else {
                    PreparedStatement ps = con.prepareStatement("INSERT INTO users (phone_number, password) VALUES (?, ?)");
                    ps.setString(1, phone);
                    ps.setString(2, pass);
                    ps.executeUpdate();
                    out.println("Registration successful! <a href='login.jsp'>Login here</a>");
                }
                con.close();
            } catch (Exception e) {
                out.println("Error: " + e.getMessage());
            }
        }
    %>
</body>
</html>
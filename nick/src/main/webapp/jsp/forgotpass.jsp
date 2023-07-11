<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Update Password</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }

        h1 {
            color: #333;
        }

        form {
            margin-top: 20px;
        }

        label {
            font-weight: bold;
        }

        input[type="text"],
        input[type="password"] {
            width: 200px;
            padding: 5px;
            margin-bottom: 10px;
        }

        button[type="submit"] {
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
        }

        p.error {
            color: #FF0000;
        }
    </style>
</head>
<body>
    <h1>Update Password</h1>
    <form action="passwordupdate" method="post">
        <label for="username">User name:</label>
        <input type="text" name="username" id="username" required><br><br>
        <button type="submit">Sign Up</button>
    </form>
    
    <hr>
    
    <%-- Check if security question and answer should be displayed --%>
    <c:if test="${not empty question}">
        <form action="updatePassword" method="post">
            <input type="hidden" name="username" value="${username}">
            <input type="hidden" name="securityQuestion" value="${question}">
            
            <label for="answer">Answer the security question:</label>
            <input type="text" name="answer" id="answer" required><br><br>
            
            <label for="newPassword">Enter new password:</label>
            <input type="password" name="newPassword" id="newPassword" required><br><br>
            
            <input type="submit" value="Update Password">
        </form>
    </c:if>
    
    <%-- Display error message if provided username is not valid --%>
    <c:if test="${not empty error}">
        <p class="error">${error}</p>
    </c:if>
</body>
</html>

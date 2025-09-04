<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Welcome | Simple App by Yunus</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #000; /* Black background */
            margin: 0;
            padding: 0;
            color: #fff; /* White text */
            text-align: center;
        }
        header {
            padding: 40px;
            background: #111; /* Dark gray header */
            border-bottom: 3px solid #fff;
        }
        h1 {
            font-size: 3em;
            margin: 0;
            color: #fff;
        }
        p {
            font-size: 1.2em;
            color: #ddd;
        }
        .container {
            margin-top: 60px;
        }
        footer {
            margin-top: 100px;
            padding: 20px;
            background: #111;
            font-size: 0.9em;
            color: #aaa;
        }
    </style>
</head>
<body>
    <header>
        <h1>🚀 Welcome to Shaik Yunus </h1>
        <p>Your CI/CD Pipeline Deployment is Successful ✅</p>
    </header>

    <div class="container">
        <p>This application is deployed on <strong>Apache Tomcat</strong> via <strong>Jenkins Pipeline</strong>.</p>
    </div>

    <footer>
        &copy; <%= new java.util.Date().getYear() + 1900 %> Sunil App. All Rights Reserved.
    </footer>
</body>
</html>

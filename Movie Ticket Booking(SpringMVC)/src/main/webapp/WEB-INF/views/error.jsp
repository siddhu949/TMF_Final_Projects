<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error - MovieBox</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f7fafc;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .error-container {
            max-width: 600px;
            background: white;
            padding: 3rem;
            border-radius: 20px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.1);
            text-align: center;
        }
        .error-icon {
            font-size: 5rem;
            margin-bottom: 1rem;
        }
        .error-title {
            font-size: 2rem;
            color: #c53030;
            margin-bottom: 1rem;
        }
        .error-message {
            color: #718096;
            margin-bottom: 2rem;
            line-height: 1.6;
        }
        .error-details {
            background: #fff5f5;
            padding: 1.5rem;
            border-radius: 8px;
            border-left: 4px solid #fc8181;
            text-align: left;
            margin-bottom: 2rem;
        }
        .error-details h4 {
            color: #c53030;
            margin-bottom: 0.5rem;
        }
        .error-details p {
            color: #744210;
            font-family: monospace;
            font-size: 0.875rem;
        }
        .action-buttons {
            display: flex;
            gap: 1rem;
            justify-content: center;
        }
        .btn {
            padding: 0.875rem 2rem;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s;
        }
        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }
        .btn-secondary {
            background: #e2e8f0;
            color: #2d3748;
        }
        .btn-secondary:hover {
            background: #cbd5e0;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <div class="error-icon">⚠️</div>
        <h1 class="error-title">Oops! Something went wrong</h1>
        <p class="error-message">
            We're sorry, but we encountered an error while processing your request.
        </p>
        
        <c:if test="${not empty error}">
            <div class="error-details">
                <h4>Error Details:</h4>
                <p>${error}</p>
            </div>
        </c:if>
        
        <div class="action-buttons">
            <a href="${pageContext.request.contextPath}/" class="btn btn-primary">
                🏠 Go to Home
            </a>
            <a href="javascript:history.back()" class="btn btn-secondary">
                ← Go Back
            </a>
        </div>
    </div>
</body>
</html>
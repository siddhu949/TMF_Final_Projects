<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - MovieBox</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            padding: 2rem 0;
        }
        .register-container {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem;
        }
        .register-box {
            background: white;
            padding: 3rem;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            width: 100%;
            max-width: 500px;
        }
        .register-header {
            text-align: center;
            margin-bottom: 2rem;
        }
        .register-header h2 {
            font-size: 2rem;
            color: #2d3748;
            margin-bottom: 0.5rem;
        }
        .register-header p {
            color: #718096;
        }
        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1rem;
            margin-bottom: 1.5rem;
        }
        .form-group {
            margin-bottom: 1.5rem;
        }
        .form-group.full-width {
            grid-column: 1 / -1;
        }
        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            color: #4a5568;
            font-weight: 600;
        }
        .form-group label .required {
            color: #e53e3e;
        }
        .form-group input {
            width: 100%;
            padding: 0.875rem 1rem;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            font-size: 1rem;
            transition: all 0.3s;
        }
        .form-group input:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }
        .form-group input::placeholder {
            color: #a0aec0;
        }
        .password-strength {
            margin-top: 0.5rem;
            font-size: 0.875rem;
        }
        .strength-bar {
            height: 4px;
            background: #e2e8f0;
            border-radius: 2px;
            margin-top: 0.25rem;
            overflow: hidden;
        }
        .strength-bar-fill {
            height: 100%;
            transition: all 0.3s;
            width: 0%;
        }
        .strength-weak { background: #fc8181; width: 33%; }
        .strength-medium { background: #f6ad55; width: 66%; }
        .strength-strong { background: #48bb78; width: 100%; }
        .error-message {
            background: #fff5f5;
            color: #c53030;
            padding: 0.875rem;
            border-radius: 8px;
            margin-bottom: 1.5rem;
            border-left: 4px solid #fc8181;
        }
        .success-message {
            background: #f0fff4;
            color: #2f855a;
            padding: 0.875rem;
            border-radius: 8px;
            margin-bottom: 1.5rem;
            border-left: 4px solid #48bb78;
        }
        .register-btn {
            width: 100%;
            padding: 1rem;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            font-size: 1.1rem;
            cursor: pointer;
            transition: all 0.3s;
        }
        .register-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }
        .register-btn:disabled {
            opacity: 0.6;
            cursor: not-allowed;
            transform: none;
        }
        .divider {
            display: flex;
            align-items: center;
            text-align: center;
            margin: 1.5rem 0;
            color: #a0aec0;
        }
        .divider::before,
        .divider::after {
            content: '';
            flex: 1;
            border-bottom: 1px solid #e2e8f0;
        }
        .divider span {
            padding: 0 1rem;
        }
        .login-link {
            text-align: center;
            margin-top: 1.5rem;
        }
        .login-link p {
            color: #718096;
            margin-bottom: 0.5rem;
        }
        .login-link a {
            color: #667eea;
            text-decoration: none;
            font-weight: 600;
            transition: color 0.3s;
        }
        .login-link a:hover {
            color: #5568d3;
        }
        .back-home {
            text-align: center;
            margin-top: 1.5rem;
        }
        .back-home a {
            color: white;
            text-decoration: none;
            font-weight: 500;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            background: rgba(255,255,255,0.2);
            padding: 0.75rem 1.5rem;
            border-radius: 25px;
            transition: all 0.3s;
        }
        .back-home a:hover {
            background: rgba(255,255,255,0.3);
        }
        .terms {
            font-size: 0.875rem;
            color: #718096;
            text-align: center;
            margin-top: 1rem;
        }
        .terms a {
            color: #667eea;
            text-decoration: none;
        }
        .input-icon {
            position: relative;
        }
        .input-icon i {
            position: absolute;
            left: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: #a0aec0;
        }
        .input-icon input {
            padding-left: 2.5rem;
        }
    </style>
</head>
<body>
    <div class="register-container">
        <div class="register-box">
            <div class="register-header">
                <h2>🎬 Create Account</h2>
                <p>Join MovieBox to book your tickets</p>
            </div>
            
            <c:if test="${not empty error}">
                <div class="error-message">
                    ⚠️ ${error}
                </div>
            </c:if>
            
            <c:if test="${not empty success}">
                <div class="success-message">
                    ✓ ${success}
                </div>
            </c:if>
            
            <form action="${pageContext.request.contextPath}/register" method="post" id="registerForm" onsubmit="return validateForm()">
                <div class="form-row">
                    <div class="form-group">
                        <label for="fullName">
                            Full Name <span class="required">*</span>
                        </label>
                        <input type="text" id="fullName" name="fullName" placeholder="John Doe" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="username">
                            Username <span class="required">*</span>
                        </label>
                        <input type="text" id="username" name="username" placeholder="johndoe" required minlength="4">
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="email">
                        Email Address <span class="required">*</span>
                    </label>
                    <input type="email" id="email" name="email" placeholder="john@example.com" required>
                </div>
                
                <div class="form-group">
                    <label for="phoneNumber">
                        Phone Number <span class="required">*</span>
                    </label>
                    <input type="tel" id="phoneNumber" name="phoneNumber" placeholder="+91 98765 43210" required pattern="[0-9+\s\-()]{10,15}">
                </div>
                
                <div class="form-group">
                    <label for="password">
                        Password <span class="required">*</span>
                    </label>
                    <input type="password" id="password" name="password" placeholder="Enter password" required minlength="6" onkeyup="checkPasswordStrength()">
                    <div class="password-strength">
                        <div class="strength-bar">
                            <div class="strength-bar-fill" id="strengthBar"></div>
                        </div>
                        <small id="strengthText" style="color: #718096;"></small>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="confirmPassword">
                        Confirm Password <span class="required">*</span>
                    </label>
                    <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Re-enter password" required minlength="6">
                </div>
                
                <button type="submit" class="register-btn" id="submitBtn">
                    Create Account
                </button>
            </form>
            
            <p class="terms">
                By registering, you agree to our 
                <a href="#">Terms of Service</a> and 
                <a href="#">Privacy Policy</a>
            </p>
            
            <div class="divider">
                <span>Already have an account?</span>
            </div>
            
            <div class="login-link">
                <a href="${pageContext.request.contextPath}/login">Sign In Instead</a>
            </div>
        </div>
    </div>
    
    <div class="back-home">
        <a href="${pageContext.request.contextPath}/">← Back to Home</a>
    </div>
    
    <script>
        function checkPasswordStrength() {
            const password = document.getElementById('password').value;
            const strengthBar = document.getElementById('strengthBar');
            const strengthText = document.getElementById('strengthText');
            
            let strength = 0;
            
            if (password.length >= 6) strength++;
            if (password.length >= 10) strength++;
            if (/[a-z]/.test(password) && /[A-Z]/.test(password)) strength++;
            if (/[0-9]/.test(password)) strength++;
            if (/[^a-zA-Z0-9]/.test(password)) strength++;
            
            strengthBar.className = 'strength-bar-fill';
            
            if (strength <= 2) {
                strengthBar.classList.add('strength-weak');
                strengthText.textContent = 'Weak password';
                strengthText.style.color = '#fc8181';
            } else if (strength <= 3) {
                strengthBar.classList.add('strength-medium');
                strengthText.textContent = 'Medium strength';
                strengthText.style.color = '#f6ad55';
            } else {
                strengthBar.classList.add('strength-strong');
                strengthText.textContent = 'Strong password';
                strengthText.style.color = '#48bb78';
            }
        }
        
        function validateForm() {
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            const username = document.getElementById('username').value;
            const email = document.getElementById('email').value;
            const phoneNumber = document.getElementById('phoneNumber').value;
            
            // Check if passwords match
            if (password !== confirmPassword) {
                alert('Passwords do not match!');
                return false;
            }
            
            // Check password length
            if (password.length < 6) {
                alert('Password must be at least 6 characters long!');
                return false;
            }
            
            // Check username length
            if (username.length < 4) {
                alert('Username must be at least 4 characters long!');
                return false;
            }
            
            // Validate email format
            const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailPattern.test(email)) {
                alert('Please enter a valid email address!');
                return false;
            }
            
            // Validate phone number
            const phonePattern = /^[0-9+\s\-()]{10,15}$/;
            if (!phonePattern.test(phoneNumber)) {
                alert('Please enter a valid phone number!');
                return false;
            }
            
            // Disable submit button to prevent double submission
            document.getElementById('submitBtn').disabled = true;
            document.getElementById('submitBtn').textContent = 'Creating Account...';
            
            return true;
        }
        
        // Enable submit button when form is reset
        document.getElementById('registerForm').addEventListener('reset', function() {
            document.getElementById('submitBtn').disabled = false;
            document.getElementById('submitBtn').textContent = 'Create Account';
        });
    </script>
</body>
</html>
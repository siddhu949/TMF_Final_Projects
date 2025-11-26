<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us - MovieBox</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f7fafc;
        }
        .hero-section {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 5rem 2rem;
            text-align: center;
        }
        .hero-section h1 {
            font-size: 3rem;
            margin-bottom: 1rem;
        }
        .hero-section p {
            font-size: 1.3rem;
            max-width: 800px;
            margin: 0 auto;
            line-height: 1.6;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 4rem 2rem;
        }
        .section {
            margin-bottom: 4rem;
        }
        .section-title {
            font-size: 2.5rem;
            color: #2d3748;
            margin-bottom: 2rem;
            text-align: center;
        }
        .content-box {
            background: white;
            padding: 3rem;
            border-radius: 20px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
            margin-bottom: 2rem;
        }
        .content-box h3 {
            font-size: 1.8rem;
            color: #667eea;
            margin-bottom: 1rem;
        }
        .content-box p {
            color: #718096;
            line-height: 1.8;
            font-size: 1.1rem;
        }
        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
            margin-top: 2rem;
        }
        .feature-card {
            background: white;
            padding: 2rem;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            text-align: center;
            transition: transform 0.3s;
        }
        .feature-card:hover {
            transform: translateY(-10px);
        }
        .feature-icon {
            font-size: 3rem;
            margin-bottom: 1rem;
        }
        .feature-card h4 {
            font-size: 1.5rem;
            color: #2d3748;
            margin-bottom: 1rem;
        }
        .feature-card p {
            color: #718096;
            line-height: 1.6;
        }
        .stats-section {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 4rem 2rem;
            border-radius: 20px;
            margin: 4rem 0;
        }
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 2rem;
            text-align: center;
        }
        .stat-item {
            color: white;
        }
        .stat-number {
            font-size: 3rem;
            font-weight: bold;
            margin-bottom: 0.5rem;
        }
        .stat-label {
            font-size: 1.2rem;
            opacity: 0.9;
        }
        .team-section {
            margin-top: 4rem;
        }
        .team-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 2rem;
            margin-top: 2rem;
        }
        .team-card {
            background: white;
            padding: 2rem;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            text-align: center;
        }
        .team-avatar {
            width: 120px;
            height: 120px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 50%;
            margin: 0 auto 1rem;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 3rem;
        }
        .team-name {
            font-size: 1.3rem;
            color: #2d3748;
            margin-bottom: 0.5rem;
        }
        .team-role {
            color: #667eea;
            font-weight: 600;
            margin-bottom: 1rem;
        }
        .team-description {
            color: #718096;
            font-size: 0.95rem;
            line-height: 1.6;
        }
        .cta-section {
            background: linear-gradient(135deg, #48bb78 0%, #38a169 100%);
            color: white;
            padding: 3rem;
            border-radius: 20px;
            text-align: center;
            margin-top: 4rem;
        }
        .cta-section h2 {
            font-size: 2.5rem;
            margin-bottom: 1rem;
        }
        .cta-section p {
            font-size: 1.2rem;
            margin-bottom: 2rem;
        }
        .cta-btn {
            display: inline-block;
            padding: 1rem 3rem;
            background: white;
            color: #38a169;
            text-decoration: none;
            border-radius: 50px;
            font-weight: 600;
            font-size: 1.1rem;
            transition: all 0.3s;
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }
        .cta-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.3);
        }
    </style>
</head>
<body>
    <!-- Include Header -->
    <jsp:include page="header.jsp" />
    
    <!-- Hero Section -->
    <div class="hero-section">
        <h1>🎬 About MovieBox</h1>
        <p>Your trusted partner for seamless movie ticket booking experience. We bring the magic of cinema to your fingertips.</p>
    </div>
    
    <div class="container">
        <!-- About Us Section -->
        <div class="section">
            <div class="content-box">
                <h3>Who We Are</h3>
                <p>
                    MovieBox is a leading online movie ticket booking platform that connects movie enthusiasts with their favorite cinemas. 
                    Founded in 2024, we've been revolutionizing the way people book movie tickets, making it easier, faster, and more convenient than ever before.
                </p>
                <p style="margin-top: 1rem;">
                    Our mission is to provide a seamless booking experience while offering the best deals and widest selection of movies and theaters. 
                    With partnerships across major cinema chains, we ensure you never miss out on the latest blockbusters.
                </p>
            </div>
        </div>
        
        <!-- Features Section -->
        <div class="section">
            <h2 class="section-title">Why Choose MovieBox?</h2>
            <div class="features-grid">
                <div class="feature-card">
                    <div class="feature-icon">🎟️</div>
                    <h4>Easy Booking</h4>
                    <p>Book your tickets in just a few clicks with our user-friendly interface and instant confirmation.</p>
                </div>
                
                <div class="feature-card">
                    <div class="feature-icon">💺</div>
                    <h4>Seat Selection</h4>
                    <p>Choose your preferred seats with our interactive seat map and real-time availability.</p>
                </div>
                
                <div class="feature-card">
                    <div class="feature-icon">🎬</div>
                    <h4>Wide Selection</h4>
                    <p>Access to thousands of movies across multiple theaters and screens nationwide.</p>
                </div>
                
                <div class="feature-card">
                    <div class="feature-icon">💳</div>
                    <h4>Secure Payment</h4>
                    <p>Safe and secure payment options with encrypted transactions for your peace of mind.</p>
                </div>
                
                <div class="feature-card">
                    <div class="feature-icon">📱</div>
                    <h4>Mobile Friendly</h4>
                    <p>Book on the go with our responsive design that works seamlessly on all devices.</p>
                </div>
                
                <div class="feature-card">
                    <div class="feature-icon">🎁</div>
                    <h4>Great Offers</h4>
                    <p>Exclusive deals, discounts, and loyalty rewards for our valued customers.</p>
                </div>
            </div>
        </div>
        
        <!-- Stats Section -->
        <div class="stats-section">
            <div class="stats-grid">
                <div class="stat-item">
                    <div class="stat-number">500K+</div>
                    <div class="stat-label">Happy Customers</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number">1000+</div>
                    <div class="stat-label">Partner Theaters</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number">5000+</div>
                    <div class="stat-label">Movies Available</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number">50+</div>
                    <div class="stat-label">Cities Covered</div>
                </div>
            </div>
        </div>
        
        <!-- Our Values Section -->
        <div class="section">
            <h2 class="section-title">Our Core Values</h2>
            <div class="content-box">
                <h3>🎯 Customer First</h3>
                <p>
                    We prioritize our customers' needs and continuously improve our services based on their feedback. 
                    Your satisfaction is our success.
                </p>
            </div>
            
            <div class="content-box">
                <h3>🚀 Innovation</h3>
                <p>
                    We embrace technology and innovation to provide cutting-edge solutions that enhance your movie-going experience.
                </p>
            </div>
            
            <div class="content-box">
                <h3>🤝 Integrity</h3>
                <p>
                    We operate with transparency and honesty in all our dealings, building trust with our customers and partners.
                </p>
            </div>
        </div>
        
        <!-- Team Section -->
        <div class="team-section">
            <h2 class="section-title">Meet Our Team</h2>
            <div class="team-grid">
                <div class="team-card">
                    <div class="team-avatar">👨‍💼</div>
                    <h4 class="team-name">John Anderson</h4>
                    <p class="team-role">Chief Executive Officer</p>
                    <p class="team-description">Visionary leader with 15+ years of experience in the entertainment industry.</p>
                </div>
                
                <div class="team-card">
                    <div class="team-avatar">👩‍💻</div>
                    <h4 class="team-name">Sarah Mitchell</h4>
                    <p class="team-role">Chief Technology Officer</p>
                    <p class="team-description">Tech innovator driving our platform's seamless user experience.</p>
                </div>
                
                <div class="team-card">
                    <div class="team-avatar">👨‍🎨</div>
                    <h4 class="team-name">Michael Chen</h4>
                    <p class="team-role">Head of Design</p>
                    <p class="team-description">Creative genius behind our beautiful and intuitive interface.</p>
                </div>
                
                <div class="team-card">
                    <div class="team-avatar">👩‍💼</div>
                    <h4 class="team-name">Emily Rodriguez</h4>
                    <p class="team-role">Customer Success Manager</p>
                    <p class="team-description">Dedicated to ensuring every customer has an amazing experience.</p>
                </div>
            </div>
        </div>
        
        <!-- CTA Section -->
        <div class="cta-section">
            <h2>Ready to Experience the Magic?</h2>
            <p>Join thousands of movie lovers who trust MovieBox for their ticket booking needs.</p>
            <a href="${pageContext.request.contextPath}/" class="cta-btn">Start Booking Now</a>
        </div>
    </div>
    
    <!-- Include Footer -->
    <jsp:include page="footer.jsp" />
</body>
</html>
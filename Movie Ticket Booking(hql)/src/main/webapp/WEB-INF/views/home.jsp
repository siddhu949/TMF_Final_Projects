<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MovieBox - Book Your Tickets</title>
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
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem;
        }
        .hero {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 3rem 2rem;
            border-radius: 15px;
            margin-bottom: 3rem;
            color: white;
            text-align: center;
        }
        .hero h2 {
            font-size: 2.5rem;
            margin-bottom: 1rem;
        }
        .search-box {
            max-width: 600px;
            margin: 2rem auto 0;
            display: flex;
            gap: 1rem;
            background: white;
            padding: 0.5rem;
            border-radius: 50px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
        }
        .search-box input, .search-box select {
            flex: 1;
            padding: 0.75rem 1.5rem;
            border: none;
            border-radius: 25px;
            font-size: 1rem;
        }
        .search-box button {
            padding: 0.75rem 2rem;
            background: #667eea;
            color: white;
            border: none;
            border-radius: 25px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
        }
        .search-box button:hover {
            background: #5568d3;
            transform: translateY(-2px);
        }
        .section-title {
            font-size: 2rem;
            margin-bottom: 2rem;
            color: #2d3748;
        }
        .movies-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 2rem;
        }
        .movie-card {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            transition: all 0.3s;
            cursor: pointer;
        }
        .movie-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
        }
        .movie-poster {
            width: 100%;
            height: 350px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 4rem;
        }
        .movie-details {
            padding: 1.5rem;
        }
        .movie-title {
            font-size: 1.5rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
            color: #2d3748;
        }
        .movie-info {
            color: #718096;
            margin-bottom: 0.5rem;
        }
        .movie-rating {
            color: #f6ad55;
            font-weight: 600;
            margin-bottom: 1rem;
        }
        .book-btn {
            width: 100%;
            padding: 0.75rem;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            font-size: 1rem;
            cursor: pointer;
            transition: all 0.3s;
        }
        .book-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }
    </style>
</head>
<body>
    <!-- Include Header -->
    <jsp:include page="header.jsp" />
    
    <div class="container">
        <!-- Hero Section with Search -->
        <div class="hero">
            <h2>🎬 Book Your Movie Tickets</h2>
            <p style="font-size: 1.2rem; margin-bottom: 0;">Experience the magic of cinema</p>
            
            <form action="${pageContext.request.contextPath}/search" method="get" class="search-box">
                <input type="text" name="movieName" placeholder="Search for movies...">
                <select name="theatre">
                    <option value="">All Theatres</option>
                    <option value="pvr">PVR Cinemas</option>
                    <option value="inox">INOX Theatre</option>
                    <option value="cinepolis">Cinepolis</option>
                </select>
                <button type="submit">Search</button>
            </form>
        </div>
        
        <!-- Movies Section -->
        <h2 class="section-title">Now Showing</h2>
        <div class="movies-grid">
            <c:forEach items="${movies}" var="movie">
                <div class="movie-card">
                    <div class="movie-poster">🎬</div>
                    <div class="movie-details">
                        <h3 class="movie-title">${movie.movieName}</h3>
                        <p class="movie-info">🎭 ${movie.genre} | ⏱️ ${movie.duration} min</p>
                        <p class="movie-rating">⭐ ${movie.rating}/10</p>
                        <form action="${pageContext.request.contextPath}/theatres" method="get">
                            <input type="hidden" name="movieId" value="${movie.movieId}">
                            <button type="submit" class="book-btn">Book Now</button>
                        </form>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
    
    <!-- Include Footer -->
    <jsp:include page="footer.jsp" />
</body>
</html>
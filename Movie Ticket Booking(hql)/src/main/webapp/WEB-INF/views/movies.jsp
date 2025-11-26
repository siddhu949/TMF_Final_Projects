<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All Movies - MovieBox</title>
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
        .page-header {
            margin-bottom: 3rem;
            text-align: center;
        }
        .page-header h1 {
            font-size: 3rem;
            color: #2d3748;
            margin-bottom: 0.5rem;
        }
        .page-header p {
            font-size: 1.2rem;
            color: #718096;
        }
        .filter-section {
            background: white;
            padding: 2rem;
            border-radius: 15px;
            margin-bottom: 2rem;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .filter-section h3 {
            margin-bottom: 1rem;
            color: #2d3748;
        }
        .filter-options {
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
        }
        .filter-btn {
            padding: 0.75rem 1.5rem;
            background: #f7fafc;
            border: 2px solid #e2e8f0;
            border-radius: 25px;
            cursor: pointer;
            transition: all 0.3s;
            font-weight: 500;
        }
        .filter-btn:hover, .filter-btn.active {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-color: #667eea;
        }
        .search-bar {
            margin-bottom: 2rem;
        }
        .search-input {
            width: 100%;
            padding: 1rem 1.5rem;
            border: 2px solid #e2e8f0;
            border-radius: 50px;
            font-size: 1rem;
            transition: all 0.3s;
        }
        .search-input:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
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
            margin-bottom: 0.5rem;
        }
        .movie-language {
            display: inline-block;
            padding: 0.25rem 0.75rem;
            background: #ebf8ff;
            color: #2c5282;
            border-radius: 12px;
            font-size: 0.875rem;
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
        <div class="page-header">
            <h1>🎬 All Movies</h1>
            <p>Browse and book your favorite movies</p>
        </div>
        
        <!-- Search Bar -->
        <div class="search-bar">
            <input type="text" class="search-input" id="movieSearch" placeholder="🔍 Search for movies..." onkeyup="searchMovies()">
        </div>
        
        <!-- Filter Section -->
        <div class="filter-section">
            <h3>Filter by Genre</h3>
            <div class="filter-options">
                <button class="filter-btn active" onclick="filterMovies('all')">All Movies</button>
                <button class="filter-btn" onclick="filterMovies('Action')">Action</button>
                <button class="filter-btn" onclick="filterMovies('Sci-Fi')">Sci-Fi</button>
                <button class="filter-btn" onclick="filterMovies('Thriller')">Thriller</button>
                <button class="filter-btn" onclick="filterMovies('Drama')">Drama</button>
                <button class="filter-btn" onclick="filterMovies('Comedy')">Comedy</button>
            </div>
        </div>
        
        <!-- Error Message -->
        <c:if test="${not empty error}">
            <div style="background: #fff5f5; color: #c53030; padding: 1rem; border-radius: 8px; margin-bottom: 2rem; border-left: 4px solid #fc8181;">
                <strong>⚠️ Error:</strong> ${error}
            </div>
        </c:if>
        
        <!-- Movies Grid -->
        <div class="movies-grid" id="moviesGrid">
            <c:choose>
                <c:when test="${empty movies}">
                    <div style="grid-column: 1/-1; text-align: center; padding: 3rem; color: #718096;">
                        <h3 style="font-size: 1.5rem; margin-bottom: 1rem;">No movies available</h3>
                        <p>Please check back later or try searching for a different movie.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach items="${movies}" var="movie">
                        <div class="movie-card" data-genre="${movie.genre}">
                            <div class="movie-poster">🎬</div>
                            <div class="movie-details">
                                <h3 class="movie-title">${movie.movieName}</h3>
                                <span class="movie-language">${movie.language}</span>
                                <p class="movie-info">🎭 ${movie.genre} | ⏱️ ${movie.duration} min</p>
                                <p class="movie-rating">⭐ ${movie.rating}/10</p>
                                <form action="${pageContext.request.contextPath}/theatres" method="get">
                                    <input type="hidden" name="movieId" value="${movie.movieId}">
                                    <button type="submit" class="book-btn">Book Now</button>
                                </form>
                            </div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
    
    <!-- Include Footer -->
    <jsp:include page="footer.jsp" />
    
    <script>
        // Search functionality
        function searchMovies() {
            const searchInput = document.getElementById('movieSearch').value.toLowerCase();
            const movieCards = document.querySelectorAll('.movie-card');
            
            movieCards.forEach(card => {
                const movieTitle = card.querySelector('.movie-title').textContent.toLowerCase();
                const movieGenre = card.querySelector('.movie-info').textContent.toLowerCase();
                
                if (movieTitle.includes(searchInput) || movieGenre.includes(searchInput)) {
                    card.style.display = 'block';
                } else {
                    card.style.display = 'none';
                }
            });
        }
        
        // Filter by genre
        function filterMovies(genre) {
            const movieCards = document.querySelectorAll('.movie-card');
            const filterButtons = document.querySelectorAll('.filter-btn');
            
            // Update active button
            filterButtons.forEach(btn => btn.classList.remove('active'));
            event.target.classList.add('active');
            
            movieCards.forEach(card => {
                const cardGenre = card.getAttribute('data-genre');
                
                if (genre === 'all' || cardGenre === genre) {
                    card.style.display = 'block';
                } else {
                    card.style.display = 'none';
                }
            });
        }
    </script>
</body>
</html>
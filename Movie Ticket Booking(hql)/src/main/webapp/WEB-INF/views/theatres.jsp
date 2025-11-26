<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Select Theatre - ${movieName}</title>
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
            background: white;
            padding: 2rem;
            border-radius: 15px;
            margin-bottom: 2rem;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .page-header h2 {
            color: #2d3748;
            margin-bottom: 1rem;
        }
        .movie-info-bar {
            display: flex;
            align-items: center;
            gap: 2rem;
            flex-wrap: wrap;
        }
        .date-selector {
            display: flex;
            gap: 1rem;
            align-items: center;
        }
        .date-selector input {
            padding: 0.75rem 1rem;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            font-size: 1rem;
        }
        .search-location {
            flex: 1;
            display: flex;
            gap: 1rem;
            max-width: 400px;
        }
        .search-location input {
            flex: 1;
            padding: 0.75rem 1rem;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            font-size: 1rem;
            transition: all 0.3s;
        }
        .search-location input:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }
        .search-btn {
            padding: 0.75rem 2rem;
            background: #667eea;
            color: white;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
        }
        .search-btn:hover {
            background: #5568d3;
            transform: translateY(-2px);
        }
        .theatres-list {
            display: flex;
            flex-direction: column;
            gap: 1.5rem;
        }
        .theatre-card {
            background: white;
            padding: 2rem;
            border-radius: 15px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .theatre-header {
            display: flex;
            justify-content: space-between;
            align-items: start;
            margin-bottom: 1.5rem;
        }
        .theatre-name {
            font-size: 1.5rem;
            font-weight: 600;
            color: #2d3748;
            margin-bottom: 0.5rem;
        }
        .theatre-location {
            color: #718096;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        .theatre-facilities {
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
        }
        .facility-badge {
            padding: 0.5rem 1rem;
            background: #f7fafc;
            border-radius: 20px;
            color: #4a5568;
            font-size: 0.875rem;
        }
        .shows-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
            gap: 1rem;
        }
        .show-time-btn {
            padding: 1rem;
            background: #f7fafc;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s;
            text-align: center;
            font-weight: 600;
            color: #2d3748;
        }
        .show-time-btn:hover {
            background: #667eea;
            color: white;
            border-color: #667eea;
            transform: translateY(-2px);
        }
        .show-time {
            font-size: 1.2rem;
            margin-bottom: 0.25rem;
        }
        .show-type {
            font-size: 0.875rem;
            color: #718096;
        }
        .back-btn {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.75rem 1.5rem;
            background: #e2e8f0;
            color: #2d3748;
            text-decoration: none;
            border-radius: 8px;
            font-weight: 600;
            margin-bottom: 2rem;
        }
        .back-btn:hover {
            background: #cbd5e0;
        }
    </style>
</head>
<body>
    <!-- Include Header -->
    <jsp:include page="header.jsp" />
    
    <div class="container">
        <a href="${pageContext.request.contextPath}/" class="back-btn">
            ← Back to Movies
        </a>
        
        <div class="page-header">
            <h2>🎬 ${movieName}</h2>
            <div class="movie-info-bar">
                <div class="date-selector">
                    <label style="font-weight: 600; color: #4a5568;">📅 Select Date:</label>
                    <input type="date" id="showDate" value="${selectedDate}" onchange="changeDate()">
                </div>
                
                <div class="search-location">
                    <input type="text" placeholder="Search by location or city..." id="locationSearch" onkeyup="searchLocation()">
                    <button class="search-btn" onclick="searchLocation()">🔍 Search</button>
                </div>
            </div>
        </div>
        
        <div class="theatres-list">
            <c:forEach items="${theatres}" var="theatre">
                <div class="theatre-card">
                    <div class="theatre-header">
                        <div>
                            <h3 class="theatre-name">🎭 ${theatre.theatreName}</h3>
                            <p class="theatre-location">📍 ${theatre.location}</p>
                        </div>
                        <div class="theatre-facilities">
                            <c:choose>
                                <c:when test="${not empty theatre.facilities}">
                                    <c:forEach items="${theatre.facilities.split(',')}" var="facility">
                                        <span class="facility-badge">${facility.trim()}</span>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <span class="facility-badge">Standard Facilities</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    
                    <div class="shows-grid">
                        <c:forEach items="${theatreShowsMap[theatre.theatreId]}" var="show">
                            <form action="${pageContext.request.contextPath}/seats" method="get" style="margin: 0;">
                                <input type="hidden" name="showId" value="${show.showId}">
                                <button type="submit" class="show-time-btn">
                                    <div class="show-time">${show.showTime}</div>
                                    <div class="show-type">${show.screenName}</div>
                                </button>
                            </form>
                        </c:forEach>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
    
    <!-- Include Footer -->
    <jsp:include page="footer.jsp" />
    
    <script>
        function changeDate() {
            const date = document.getElementById('showDate').value;
            window.location.href = '${pageContext.request.contextPath}/theatres?movieId=${movieId}&date=' + date;
        }
        
        function searchLocation() {
            const searchText = document.getElementById('locationSearch').value.toLowerCase();
            const theatreCards = document.querySelectorAll('.theatre-card');
            let visibleCount = 0;
            
            theatreCards.forEach(card => {
                const theatreName = card.querySelector('.theatre-name').textContent.toLowerCase();
                const theatreLocation = card.querySelector('.theatre-location').textContent.toLowerCase();
                
                if (theatreName.includes(searchText) || theatreLocation.includes(searchText)) {
                    card.style.display = 'block';
                    visibleCount++;
                } else {
                    card.style.display = 'none';
                }
            });
            
            // Show/hide no results message
            let noResultsMsg = document.getElementById('noResultsMessage');
            if (visibleCount === 0 && searchText !== '') {
                if (!noResultsMsg) {
                    noResultsMsg = document.createElement('div');
                    noResultsMsg.id = 'noResultsMessage';
                    noResultsMsg.style.cssText = 'background: #ebf8ff; color: #2c5282; padding: 2rem; border-radius: 12px; text-align: center; margin-top: 2rem;';
                    noResultsMsg.innerHTML = '<h3 style="margin-bottom: 0.5rem;">🔍 No theatres found</h3><p>Try searching with a different location or clear the search.</p>';
                    document.querySelector('.theatres-list').appendChild(noResultsMsg);
                }
            } else if (noResultsMsg) {
                noResultsMsg.remove();
            }
        }
        
        // Clear search when input is empty
        document.addEventListener('DOMContentLoaded', function() {
            const searchInput = document.getElementById('locationSearch');
            searchInput.addEventListener('input', function() {
                if (this.value === '') {
                    searchLocation();
                }
            });
        });
    </script>
</body>
</html>
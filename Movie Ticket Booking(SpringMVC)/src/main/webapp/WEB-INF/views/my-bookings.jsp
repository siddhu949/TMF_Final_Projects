<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Bookings - MovieBox</title>
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
        }
        .page-header h1 {
            font-size: 2.5rem;
            color: #2d3748;
            margin-bottom: 0.5rem;
        }
        .page-header p {
            color: #718096;
            font-size: 1.1rem;
        }
        .bookings-list {
            display: flex;
            flex-direction: column;
            gap: 1.5rem;
        }
        .booking-card {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            transition: transform 0.3s;
        }
        .booking-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        }
        .booking-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 1.5rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .booking-id {
            font-size: 0.875rem;
            opacity: 0.9;
        }
        .booking-status {
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.875rem;
            font-weight: 600;
        }
        .status-confirmed {
            background: rgba(72, 187, 120, 0.2);
            color: #22543d;
        }
        .status-cancelled {
            background: rgba(245, 101, 101, 0.2);
            color: #742a2a;
        }
        .booking-body {
            padding: 2rem;
        }
        .booking-details {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1.5rem;
            margin-bottom: 1.5rem;
        }
        .detail-item {
            display: flex;
            flex-direction: column;
        }
        .detail-label {
            color: #718096;
            font-size: 0.875rem;
            margin-bottom: 0.25rem;
        }
        .detail-value {
            color: #2d3748;
            font-weight: 600;
            font-size: 1.1rem;
        }
        .seats-section {
            background: #f7fafc;
            padding: 1.5rem;
            border-radius: 10px;
            margin-bottom: 1.5rem;
        }
        .seats-section h4 {
            color: #2d3748;
            margin-bottom: 1rem;
        }
        .seat-badges {
            display: flex;
            flex-wrap: wrap;
            gap: 0.75rem;
        }
        .seat-badge {
            padding: 0.5rem 1rem;
            background: white;
            border: 2px solid #667eea;
            color: #667eea;
            border-radius: 20px;
            font-weight: 600;
        }
        .booking-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-top: 1.5rem;
            border-top: 2px solid #e2e8f0;
        }
        .total-amount {
            font-size: 1.5rem;
            font-weight: bold;
            color: #667eea;
        }
        .booking-actions {
            display: flex;
            gap: 1rem;
        }
        .btn {
            padding: 0.75rem 1.5rem;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            text-decoration: none;
            display: inline-block;
        }
        .btn-view {
            background: #667eea;
            color: white;
        }
        .btn-view:hover {
            background: #5568d3;
            transform: translateY(-2px);
        }
        .btn-cancel {
            background: #e2e8f0;
            color: #2d3748;
        }
        .btn-cancel:hover {
            background: #cbd5e0;
        }
        .empty-state {
            text-align: center;
            padding: 4rem 2rem;
            background: white;
            border-radius: 15px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .empty-icon {
            font-size: 5rem;
            margin-bottom: 1rem;
        }
        .empty-state h3 {
            font-size: 1.8rem;
            color: #2d3748;
            margin-bottom: 1rem;
        }
        .empty-state p {
            color: #718096;
            margin-bottom: 2rem;
        }
        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 1rem 2rem;
        }
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }
        .filter-section {
            background: white;
            padding: 1.5rem 2rem;
            border-radius: 15px;
            margin-bottom: 2rem;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .filter-buttons {
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
        .filter-btn.active,
        .filter-btn:hover {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-color: #667eea;
        }
    </style>
</head>
<body>
    <!-- Include Header -->
    <jsp:include page="header.jsp" />
    
    <div class="container">
        <div class="page-header">
            <h1>🎫 My Bookings</h1>
            <p>View and manage your movie ticket bookings</p>
        </div>
        
        <!-- Filter Section -->
        <div class="filter-section">
            <div class="filter-buttons">
                <button class="filter-btn active" onclick="filterBookings('all')">All Bookings</button>
                <button class="filter-btn" onclick="filterBookings('CONFIRMED')">Confirmed</button>
                <button class="filter-btn" onclick="filterBookings('CANCELLED')">Cancelled</button>
            </div>
        </div>
        
        <!-- Bookings List -->
        <div class="bookings-list">
            <c:choose>
                <c:when test="${empty bookings}">
                    <div class="empty-state">
                        <div class="empty-icon">🎬</div>
                        <h3>No Bookings Yet</h3>
                        <p>You haven't made any bookings. Start exploring movies and book your first show!</p>
                        <a href="${pageContext.request.contextPath}/" class="btn btn-primary">Browse Movies</a>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach items="${bookings}" var="booking">
                        <div class="booking-card" data-status="${booking.bookingStatus}">
                            <div class="booking-header">
                                <div>
                                    <div class="booking-id">Booking ID: ${booking.ticketNumber}</div>
                                    <h3 style="margin: 0.5rem 0; font-size: 1.5rem;">${booking.movieName}</h3>
                                </div>
                                <span class="booking-status ${booking.bookingStatus == 'CONFIRMED' ? 'status-confirmed' : 'status-cancelled'}">
                                    ${booking.bookingStatus}
                                </span>
                            </div>
                            
                            <div class="booking-body">
                                <div class="booking-details">
                                    <div class="detail-item">
                                        <span class="detail-label">Theatre</span>
                                        <span class="detail-value">${booking.theatreName}</span>
                                    </div>
                                    
                                    <div class="detail-item">
                                        <span class="detail-label">Show Date</span>
                                        <span class="detail-value">${booking.showDate}</span>
                                    </div>
                                    
                                    <div class="detail-item">
                                        <span class="detail-label">Show Time</span>
                                        <span class="detail-value">${booking.showTime}</span>
                                    </div>
                                    
                                    <div class="detail-item">
                                        <span class="detail-label">Booking Date</span>
                                        <span class="detail-value">
                                            <fmt:formatDate value="${booking.bookingDate}" pattern="dd MMM yyyy" />
                                        </span>
                                    </div>
                                    
                                    <div class="detail-item">
                                        <span class="detail-label">Payment Status</span>
                                        <span class="detail-value">${booking.paymentStatus}</span>
                                    </div>
                                </div>
                                
                                <!-- Seats Section -->
                                <div class="seats-section">
                                    <h4>Booked Seats (${booking.totalSeats})</h4>
                                    <div class="seat-badges" id="seats-${booking.bookingId}">
                                        <!-- Seats will be loaded here -->
                                        <span class="seat-badge">Loading...</span>
                                    </div>
                                </div>
                                
                                <div class="booking-footer">
                                    <div>
                                        <div style="color: #718096; font-size: 0.875rem; margin-bottom: 0.25rem;">Total Amount</div>
                                        <div class="total-amount">₹${booking.totalAmount}</div>
                                    </div>
                                    
                                    <div class="booking-actions">
                                        <a href="${pageContext.request.contextPath}/view-ticket?bookingId=${booking.bookingId}" class="btn btn-view">
                                            View Ticket
                                        </a>
                                        <c:if test="${booking.bookingStatus == 'CONFIRMED'}">
                                            <button class="btn btn-cancel" onclick="cancelBooking(${booking.bookingId})">
                                                Cancel Booking
                                            </button>
                                        </c:if>
                                    </div>
                                </div>
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
        // Filter bookings by status
        function filterBookings(status) {
            const cards = document.querySelectorAll('.booking-card');
            const buttons = document.querySelectorAll('.filter-btn');
            
            // Update active button
            buttons.forEach(btn => btn.classList.remove('active'));
            event.target.classList.add('active');
            
            // Filter cards
            cards.forEach(card => {
                const cardStatus = card.getAttribute('data-status');
                if (status === 'all' || cardStatus === status) {
                    card.style.display = 'block';
                } else {
                    card.style.display = 'none';
                }
            });
        }
        
        // Cancel booking
        function cancelBooking(bookingId) {
            if (confirm('Are you sure you want to cancel this booking? This action cannot be undone.')) {
                // In a real application, this would make an AJAX call or form submission
                window.location.href = '${pageContext.request.contextPath}/cancel-booking?bookingId=' + bookingId;
            }
        }
        
        // Load seat numbers for each booking (via AJAX or from model)
        // This is a placeholder - in real app, you'd load this from server
        document.addEventListener('DOMContentLoaded', function() {
            console.log('Bookings page loaded');
            // You can make AJAX calls here to load seat details
        });
    </script>
</body>
</html>
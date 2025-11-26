<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Confirm Booking - MovieBox</title>
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
            max-width: 900px;
            margin: 0 auto;
            padding: 2rem;
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
        .page-header {
            text-align: center;
            margin-bottom: 3rem;
        }
        .page-header h2 {
            font-size: 2.5rem;
            color: #2d3748;
            margin-bottom: 0.5rem;
        }
        .page-header p {
            color: #718096;
            font-size: 1.1rem;
        }
        .booking-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
            overflow: hidden;
            margin-bottom: 2rem;
        }
        .card-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 2rem;
            text-align: center;
        }
        .card-header h3 {
            font-size: 1.8rem;
            margin-bottom: 0.5rem;
        }
        .card-body {
            padding: 2.5rem;
        }
        .booking-details {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 2rem;
            margin-bottom: 2rem;
        }
        .detail-item {
            padding: 1.5rem;
            background: #f7fafc;
            border-radius: 12px;
            border-left: 4px solid #667eea;
        }
        .detail-label {
            color: #718096;
            font-size: 0.875rem;
            margin-bottom: 0.5rem;
            font-weight: 500;
        }
        .detail-value {
            color: #2d3748;
            font-size: 1.25rem;
            font-weight: 600;
        }
        .seats-display {
            background: #f7fafc;
            padding: 1.5rem;
            border-radius: 12px;
            margin-bottom: 2rem;
        }
        .seats-display h4 {
            color: #2d3748;
            margin-bottom: 1rem;
            font-size: 1.2rem;
        }
        .seat-badges {
            display: flex;
            flex-wrap: wrap;
            gap: 0.75rem;
        }
        .seat-badge {
            background: white;
            color: #667eea;
            padding: 0.75rem 1.25rem;
            border-radius: 25px;
            font-weight: 600;
            border: 2px solid #667eea;
        }
        .price-summary {
            background: #ebf8ff;
            padding: 2rem;
            border-radius: 12px;
            margin-bottom: 2rem;
        }
        .price-row {
            display: flex;
            justify-content: space-between;
            padding: 0.75rem 0;
            border-bottom: 1px solid #bee3f8;
        }
        .price-row:last-child {
            border: none;
            margin-top: 1rem;
            padding-top: 1rem;
            border-top: 2px solid #667eea;
        }
        .price-label {
            color: #2c5282;
            font-weight: 500;
        }
        .price-value {
            color: #2d3748;
            font-weight: 600;
        }
        .total-row {
            font-size: 1.5rem;
        }
        .total-row .price-value {
            color: #667eea;
        }
        .action-buttons {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1rem;
        }
        .btn {
            padding: 1.25rem;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            font-size: 1.1rem;
            cursor: pointer;
            transition: all 0.3s;
            text-align: center;
            text-decoration: none;
            display: inline-block;
        }
        .btn-cancel {
            background: #e2e8f0;
            color: #2d3748;
        }
        .btn-cancel:hover {
            background: #cbd5e0;
        }
        .btn-confirm {
            background: linear-gradient(135deg, #48bb78 0%, #38a169 100%);
            color: white;
        }
        .btn-confirm:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(72, 187, 120, 0.4);
        }
        .important-note {
            background: #fffaf0;
            border-left: 4px solid #ed8936;
            padding: 1.5rem;
            border-radius: 8px;
            margin-top: 2rem;
        }
        .important-note h4 {
            color: #c05621;
            margin-bottom: 0.5rem;
        }
        .important-note ul {
            color: #744210;
            margin-left: 1.5rem;
            line-height: 1.8;
        }
        @media (max-width: 768px) {
            .action-buttons {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <!-- Include Header -->
    <jsp:include page="header.jsp" />
    
    <div class="container">
        <a href="javascript:history.back()" class="back-btn">
            ← Back
        </a>
        
        <div class="page-header">
            <h2>🎯 Confirm Your Booking</h2>
            <p>Please review your booking details before confirming</p>
        </div>
        
        <!-- Split selectedSeats and store count -->
        <c:set var="seatArray" value="${fn:split(selectedSeats, ',')}"/>
        <c:set var="seatCount" value="${fn:length(seatArray)}"/>
        
        <div class="booking-card">
            <div class="card-header">
                <h3>🎬 ${movieName}</h3>
                <p>${theatreName}</p>
            </div>
            
            <div class="card-body">
                <div class="booking-details">
                    <div class="detail-item">
                        <div class="detail-label">📅 Date</div>
                        <div class="detail-value">${date}</div>
                    </div>
                    
                    <div class="detail-item">
                        <div class="detail-label">⏰ Show Time</div>
                        <div class="detail-value">${showTime}</div>
                    </div>
                    
                    <div class="detail-item">
                        <div class="detail-label">🎫 Number of Seats</div>
                        <div class="detail-value">${seatCount} Seats</div>
                    </div>
                </div>
                
                <div class="seats-display">
                    <h4>Selected Seats</h4>
                    <div class="seat-badges">
                        <c:forEach items="${seatArray}" var="seat">
                            <span class="seat-badge">${fn:trim(seat)}</span>
                        </c:forEach>
                    </div>
                </div>
                
                <div class="price-summary">
                    <div class="price-row">
                        <span class="price-label">Ticket Price (${seatCount} seats)</span>
                        <span class="price-value">₹${ticketPrice}</span>
                    </div>
                    <div class="price-row">
                        <span class="price-label">Convenience Fee</span>
                        <span class="price-value">₹${convenienceFee}</span>
                    </div>
                    <div class="price-row">
                        <span class="price-label">GST (18%)</span>
                        <span class="price-value">₹${gst}</span>
                    </div>
                    <div class="price-row total-row">
                        <span class="price-label">Total Amount</span>
                        <span class="price-value">₹${totalPrice}</span>
                    </div>
                </div>
                
                <form action="${pageContext.request.contextPath}/confirm-booking" method="post">
                    <input type="hidden" name="showId" value="${showId}">
                    <input type="hidden" name="selectedSeatIds" value="${selectedSeatIds}">
                    <input type="hidden" name="movieName" value="${movieName}">
                    <input type="hidden" name="theatreName" value="${theatreName}">
                    <input type="hidden" name="showTime" value="${showTime}">
                    <input type="hidden" name="date" value="${date}">
                    <input type="hidden" name="selectedSeats" value="${selectedSeats}">
                    <input type="hidden" name="totalPrice" value="${totalPrice}">
                    
                    <div class="action-buttons">
                        <a href="javascript:history.back()" class="btn btn-cancel">
                            Cancel Booking
                        </a>
                        <button type="submit" class="btn btn-confirm">
                            Confirm & Pay
                        </button>
                    </div>
                </form>
                
                <div class="important-note">
                    <h4>⚠️ Important Information</h4>
                    <ul>
                        <li>Please arrive 15 minutes before the show time</li>
                        <li>Tickets once booked cannot be cancelled or refunded</li>
                        <li>Original ID proof required at the venue</li>
                        <li>Outside food and beverages are not allowed</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Include Footer -->
    <jsp:include page="footer.jsp" />
</body>
</html>
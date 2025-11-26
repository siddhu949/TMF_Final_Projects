<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Select Seats - ${movieName}</title>
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
            max-width: 1400px;
            margin: 0 auto;
            padding: 2rem;
        }
        .booking-info {
            background: white;
            padding: 1.5rem 2rem;
            border-radius: 15px;
            margin-bottom: 2rem;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 1rem;
        }
        .info-item {
            display: flex;
            flex-direction: column;
        }
        .info-label {
            color: #718096;
            font-size: 0.875rem;
            margin-bottom: 0.25rem;
        }
        .info-value {
            color: #2d3748;
            font-weight: 600;
            font-size: 1.1rem;
        }
        .screen-section {
            background: white;
            padding: 2rem;
            border-radius: 15px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-bottom: 2rem;
        }
        .screen {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            height: 10px;
            border-radius: 50% 50% 0 0;
            margin: 0 auto 3rem;
            max-width: 80%;
            position: relative;
        }
        .screen-label {
            text-align: center;
            color: #718096;
            margin-top: 1rem;
            font-weight: 600;
        }
        .legend {
            display: flex;
            justify-content: center;
            gap: 2rem;
            margin-bottom: 2rem;
            flex-wrap: wrap;
        }
        .legend-item {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        .legend-seat {
            width: 30px;
            height: 30px;
            border-radius: 8px;
        }
        .available {
            background: #f7fafc;
            border: 2px solid #e2e8f0;
        }
        .selected {
            background: #667eea;
            border: 2px solid #667eea;
        }
        .booked {
            background: #fc8181;
            border: 2px solid #fc8181;
        }
        .seats-container {
            display: flex;
            flex-direction: column;
            gap: 1rem;
            align-items: center;
        }
        .seat-row {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        .row-label {
            width: 40px;
            text-align: center;
            font-weight: 600;
            color: #4a5568;
        }
        .seat {
            width: 40px;
            height: 40px;
            border-radius: 8px;
            border: 2px solid #e2e8f0;
            background: #f7fafc;
            cursor: pointer;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.75rem;
            color: #718096;
        }
        .seat:hover:not(.booked) {
            transform: scale(1.1);
            border-color: #667eea;
        }
        .seat.selected {
            background: #667eea;
            border-color: #667eea;
            color: white;
        }
        .seat.booked {
            background: #fc8181;
            border-color: #fc8181;
            cursor: not-allowed;
            color: white;
            opacity: 0.6;
        }
        .seat.booked:hover {
            transform: none;
            cursor: not-allowed;
        }
        .aisle {
            width: 40px;
        }
        .booking-summary {
            background: white;
            padding: 2rem;
            border-radius: 15px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            position: sticky;
            top: 2rem;
        }
        .summary-title {
            font-size: 1.5rem;
            font-weight: 600;
            color: #2d3748;
            margin-bottom: 1.5rem;
        }
        .summary-item {
            display: flex;
            justify-content: space-between;
            padding: 0.75rem 0;
            border-bottom: 1px solid #e2e8f0;
        }
        .summary-label {
            color: #718096;
        }
        .summary-value {
            font-weight: 600;
            color: #2d3748;
        }
        .total {
            font-size: 1.5rem;
            color: #667eea;
        }
        .proceed-btn {
            width: 100%;
            padding: 1rem;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            font-size: 1.1rem;
            cursor: pointer;
            margin-top: 1.5rem;
            transition: all 0.3s;
        }
        .proceed-btn:hover:not(:disabled) {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }
        .proceed-btn:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }
        .main-content {
            display: grid;
            grid-template-columns: 1fr 350px;
            gap: 2rem;
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
        @media (max-width: 1024px) {
            .main-content {
                grid-template-columns: 1fr;
            }
            .booking-summary {
                position: static;
            }
        }
    </style>
</head>
<body>
    <!-- Include Header -->
    <jsp:include page="header.jsp" />
    
    <div class="container">
        <a href="${pageContext.request.contextPath}/theatres?movieId=${movieId}" class="back-btn">
            ← Back to Theatres
        </a>
        
        <div class="booking-info">
            <div class="info-item">
                <span class="info-label">Movie</span>
                <span class="info-value">🎬 ${movieName}</span>
            </div>
            <div class="info-item">
                <span class="info-label">Theatre</span>
                <span class="info-value">🎭 ${theatreName}</span>
            </div>
            <div class="info-item">
                <span class="info-label">Show Time</span>
                <span class="info-value">⏰ ${showTime}</span>
            </div>
            <div class="info-item">
                <span class="info-label">Date</span>
                <span class="info-value">📅 ${date}</span>
            </div>
        </div>
        
        <div class="main-content">
            <div class="screen-section">
                <div class="screen"></div>
                <p class="screen-label">🎬 SCREEN THIS WAY</p>
                
                <div class="legend">
                    <div class="legend-item">
                        <div class="legend-seat available"></div>
                        <span>Available</span>
                    </div>
                    <div class="legend-item">
                        <div class="legend-seat selected"></div>
                        <span>Selected</span>
                    </div>
                    <div class="legend-item">
                        <div class="legend-seat booked"></div>
                        <span>Booked</span>
                    </div>
                </div>
                
                <div class="seats-container">
                    <c:forEach items="${seats}" var="row">
                        <div class="seat-row">
                            <span class="row-label">${row.key}</span>
                            <c:forEach items="${row.value}" var="seat" varStatus="status">
                                <c:if test="${status.index == 3 || status.index == 9}">
                                    <div class="aisle"></div>
                                </c:if>
                                <c:set var="isBooked" value="false"/>
                                <c:forEach items="${bookedSeatIds}" var="bookedId">
                                    <c:if test="${bookedId == seat.seatId}">
                                        <c:set var="isBooked" value="true"/>
                                    </c:if>
                                </c:forEach>
                                <div class="seat ${isBooked ? 'booked' : ''}" 
                                     data-seat-id="${seat.seatId}"
                                     data-seat-label="${seat.seatLabel}" 
                                     data-price="${seat.price}"
                                     onclick="toggleSeat(this)">
                                </div>
                            </c:forEach>
                            <span class="row-label">${row.key}</span>
                        </div>
                    </c:forEach>
                </div>
            </div>
            
            <div class="booking-summary">
                <h3 class="summary-title">Booking Summary</h3>
                
                <div class="summary-item">
                    <span class="summary-label">Selected Seats</span>
                    <span class="summary-value" id="seatCount">0</span>
                </div>
                
                <div class="summary-item">
                    <span class="summary-label">Seats</span>
                    <span class="summary-value" id="seatNumbers">-</span>
                </div>
                
                <div class="summary-item">
                    <span class="summary-label">Price per Seat</span>
                    <span class="summary-value">₹200</span>
                </div>
                
                <div class="summary-item" style="border: none; margin-top: 1rem;">
                    <span class="summary-label">Total Amount</span>
                    <span class="summary-value total">₹<span id="totalAmount">0</span></span>
                </div>
                
                <form action="${pageContext.request.contextPath}/booking-summary" method="post" id="bookingForm">
                    <input type="hidden" name="showId" value="${showId}">
                    <input type="hidden" name="selectedSeats" id="selectedSeatsInput">
                    <button type="submit" class="proceed-btn" id="proceedBtn" disabled>
                        Proceed to Booking
                    </button>
                </form>
            </div>
        </div>
    </div>
    
    <!-- Include Footer -->
    <jsp:include page="footer.jsp" />
    
    <script>
        let selectedSeats = [];
        let selectedSeatIds = [];
        let seatPrices = {};
        
        function toggleSeat(seatElement) {
            if (seatElement.classList.contains('booked')) {
                return;
            }
            
            const seatId = seatElement.getAttribute('data-seat-id');
            const seatLabel = seatElement.getAttribute('data-seat-label');
            const seatPrice = parseFloat(seatElement.getAttribute('data-price'));
            
            if (seatElement.classList.contains('selected')) {
                seatElement.classList.remove('selected');
                selectedSeats = selectedSeats.filter(s => s !== seatLabel);
                selectedSeatIds = selectedSeatIds.filter(id => id !== seatId);
                delete seatPrices[seatId];
            } else {
                if (selectedSeats.length >= 10) {
                    alert('You can select maximum 10 seats at a time');
                    return;
                }
                seatElement.classList.add('selected');
                selectedSeats.push(seatLabel);
                selectedSeatIds.push(seatId);
                seatPrices[seatId] = seatPrice;
            }
            
            updateSummary();
        }
        
        function updateSummary() {
            const totalPrice = Object.values(seatPrices).reduce((sum, price) => sum + price, 0);
            
            document.getElementById('seatCount').textContent = selectedSeats.length;
            document.getElementById('seatNumbers').textContent = selectedSeats.length > 0 ? selectedSeats.join(', ') : '-';
            document.getElementById('totalAmount').textContent = totalPrice.toFixed(2);
            document.getElementById('selectedSeatsInput').value = selectedSeatIds.join(',');
            
            const proceedBtn = document.getElementById('proceedBtn');
            proceedBtn.disabled = selectedSeats.length === 0;
        }
    </script>
</body>
</html>
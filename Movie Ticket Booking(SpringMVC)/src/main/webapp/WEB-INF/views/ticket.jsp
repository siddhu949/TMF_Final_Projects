<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Confirmed - MovieBox</title>
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
            padding: 2rem;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
        }
        .success-animation {
            text-align: center;
            margin-bottom: 2rem;
            animation: fadeInDown 0.8s ease-out;
        }
        .success-icon {
            width: 100px;
            height: 100px;
            background: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 3rem;
            margin: 0 auto 1rem;
            animation: scaleIn 0.5s ease-out;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
        }
        .success-text {
            color: white;
            font-size: 2rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
        }
        .success-subtext {
            color: rgba(255,255,255,0.9);
            font-size: 1.1rem;
        }
        .ticket-container {
            background: white;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            animation: fadeInUp 0.8s ease-out;
        }
        .ticket-header {
            background: linear-gradient(135deg, #2d3748 0%, #1a202c 100%);
            color: white;
            padding: 2rem;
            position: relative;
            overflow: hidden;
        }
        .ticket-header::before {
            content: '🎬';
            position: absolute;
            font-size: 15rem;
            opacity: 0.1;
            right: -3rem;
            top: -3rem;
        }
        .ticket-id {
            font-size: 0.875rem;
            color: rgba(255,255,255,0.7);
            margin-bottom: 0.5rem;
        }
        .ticket-title {
            font-size: 2rem;
            font-weight: 600;
            margin-bottom: 1rem;
        }
        .ticket-body {
            padding: 2.5rem;
        }
        .ticket-details {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 2rem;
            margin-bottom: 2rem;
        }
        .detail-box {
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
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        .detail-value {
            color: #2d3748;
            font-size: 1.25rem;
            font-weight: 600;
        }
        .seats-section {
            background: #ebf8ff;
            padding: 2rem;
            border-radius: 12px;
            margin-bottom: 2rem;
        }
        .seats-section h3 {
            color: #2c5282;
            margin-bottom: 1rem;
            font-size: 1.3rem;
        }
        .seat-numbers {
            display: flex;
            flex-wrap: wrap;
            gap: 0.75rem;
        }
        .seat-number {
            background: white;
            color: #667eea;
            padding: 0.75rem 1.5rem;
            border-radius: 25px;
            font-weight: 600;
            border: 2px solid #667eea;
            font-size: 1.1rem;
        }
        .price-section {
            background: #f7fafc;
            padding: 2rem;
            border-radius: 12px;
            margin-bottom: 2rem;
        }
        .price-row {
            display: flex;
            justify-content: space-between;
            padding: 0.75rem 0;
        }
        .price-total {
            font-size: 1.8rem;
            color: #667eea;
            font-weight: 700;
            margin-top: 1rem;
            padding-top: 1rem;
            border-top: 2px dashed #cbd5e0;
        }
        .qr-code {
            text-align: center;
            padding: 2rem;
            background: #f7fafc;
            border-radius: 12px;
            margin-bottom: 2rem;
        }
        .qr-placeholder {
            width: 200px;
            height: 200px;
            background: white;
            border: 2px dashed #cbd5e0;
            margin: 0 auto 1rem;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 5rem;
            border-radius: 12px;
        }
        .qr-text {
            color: #718096;
            font-size: 0.875rem;
        }
        .action-buttons {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 1rem;
            margin-bottom: 2rem;
        }
        .btn {
            padding: 1rem;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            text-align: center;
            text-decoration: none;
            display: inline-block;
        }
        .btn-primary {
            background: #667eea;
            color: white;
        }
        .btn-primary:hover {
            background: #5568d3;
            transform: translateY(-2px);
        }
        .btn-secondary {
            background: #e2e8f0;
            color: #2d3748;
        }
        .btn-secondary:hover {
            background: #cbd5e0;
        }
        .info-box {
            background: #fffaf0;
            border-left: 4px solid #ed8936;
            padding: 1.5rem;
            border-radius: 8px;
        }
        .info-box h4 {
            color: #c05621;
            margin-bottom: 0.75rem;
            font-size: 1.1rem;
        }
        .info-box ul {
            color: #744210;
            margin-left: 1.5rem;
            line-height: 1.8;
        }
        .ticket-footer {
            text-align: center;
            margin-top: 2rem;
        }
        .ticket-footer a {
            color: white;
            text-decoration: none;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            background: rgba(255,255,255,0.2);
            padding: 1rem 2rem;
            border-radius: 25px;
            transition: all 0.3s;
        }
        .ticket-footer a:hover {
            background: rgba(255,255,255,0.3);
        }
        @keyframes fadeInDown {
            from {
                opacity: 0;
                transform: translateY(-30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        @keyframes scaleIn {
            from {
                transform: scale(0);
            }
            to {
                transform: scale(1);
            }
        }
        @media print {
            body {
                background: white;
            }
            .action-buttons, .ticket-footer, .success-animation {
                display: none;
            }
        }
        @media (max-width: 768px) {
            .ticket-details {
                grid-template-columns: 1fr;
            }
            .action-buttons {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="success-animation">
            <div class="success-icon">✓</div>
            <h1 class="success-text">Booking Confirmed!</h1>
            <p class="success-subtext">Your tickets have been booked successfully</p>
        </div>
        
        <div class="ticket-container">
            <div class="ticket-header">
                <div class="ticket-id">Booking ID: ${ticketId}</div>
                <h2 class="ticket-title">🎬 ${movieName}</h2>
                <p style="font-size: 1.1rem; color: rgba(255,255,255,0.9);">${theatreName}</p>
            </div>
            
            <div class="ticket-body">
                <div class="ticket-details">
                    <div class="detail-box">
                        <div class="detail-label">Customer Name</div>
                        <div class="detail-value">${username}</div>
                    </div>
                    
                    <div class="detail-box">
                        <div class="detail-label">Booking Date</div>
                        <div class="detail-value">${bookingDate}</div>
                    </div>
                    
                    <div class="detail-box">
                        <div class="detail-label">Show Date</div>
                        <div class="detail-value">📅 ${date}</div>
                    </div>
                    
                    <div class="detail-box">
                        <div class="detail-label">Show Time</div>
                        <div class="detail-value">⏰ ${showTime}</div>
                    </div>
                </div>
                
                <div class="seats-section">
                    <h3>🎫 Your Seats</h3>
                    <div class="seat-numbers">
                        <c:choose>
                            <c:when test="${not empty selectedSeats}">
                                <c:forEach items="${selectedSeats.split(',')}" var="seat">
                                    <span class="seat-number">${seat.trim()}</span>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <span class="seat-number">No seats selected</span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
                
                <div class="price-section">
                    <h3 style="margin-bottom: 1rem; color: #2d3748;">💰 Payment Summary</h3>
                    <div class="price-row">
                        <span>Total Amount Paid</span>
                        <span style="font-weight: 600;">₹${totalPrice}</span>
                    </div>
                    <div class="price-row price-total">
                        <span>Status</span>
                        <span style="color: #48bb78;">PAID ✓</span>
                    </div>
                </div>
                
                <div class="qr-code">
                    <div class="qr-placeholder">📱</div>
                    <p class="qr-text">Show this QR code at the theatre entrance</p>
                </div>
                
                <div class="action-buttons">
                    <button onclick="window.print()" class="btn btn-primary">
                        🖨️ Print Ticket
                    </button>
                    <button onclick="downloadTicket()" class="btn btn-primary">
                        📥 Download PDF
                    </button>
                    <button onclick="shareTicket()" class="btn btn-secondary">
                        📤 Share Ticket
                    </button>
                    <a href="${pageContext.request.contextPath}/" class="btn btn-secondary">
                        🏠 Back to Home
                    </a>
                </div>
                
                <div class="info-box">
                    <h4>📋 Important Instructions</h4>
                    <ul>
                        <li>Please carry a valid ID proof to the theatre</li>
                        <li>Arrive at least 15 minutes before show time</li>
                        <li>Show this ticket (printed or on mobile) at the entrance</li>
                        <li>Outside food and beverages are not permitted</li>
                        <li>Tickets once booked cannot be cancelled or exchanged</li>
                    </ul>
                </div>
            </div>
        </div>
        
        <div class="ticket-footer">
            <a href="${pageContext.request.contextPath}/">
                ← Book More Tickets
            </a>
        </div>
    </div>
    
    <script>
        function downloadTicket() {
            alert('Download functionality would trigger PDF generation');
            // In real implementation, this would call a backend endpoint to generate PDF
        }
        
        function shareTicket() {
            if (navigator.share) {
                navigator.share({
                    title: 'Movie Ticket - ${movieName}',
                    text: 'I just booked tickets for ${movieName}!',
                    url: window.location.href
                }).catch(err => console.log('Error sharing:', err));
            } else {
                alert('Sharing not supported on this browser');
            }
        }
        
        // Confetti animation on page load
        window.onload = function() {
            console.log('Booking confirmed for: ${ticketId}');
        }
    </script>
</body>
</html>
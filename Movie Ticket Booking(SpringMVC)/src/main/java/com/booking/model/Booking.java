package com.booking.model;

import java.math.BigDecimal;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Booking {
	 private int bookingId;
	    private int userId;
	    private int showId;
	    private Timestamp bookingDate;
	    private int totalSeats;
	    private BigDecimal totalAmount;
	    private String bookingStatus;
	    private String paymentStatus;
	    private String paymentMethod;
	    private String ticketNumber;
	    
	    // Additional fields for display
	    private String username;
	    private String movieName;
	    private String theatreName;
	    private String showDate;
	    private String showTime;
}

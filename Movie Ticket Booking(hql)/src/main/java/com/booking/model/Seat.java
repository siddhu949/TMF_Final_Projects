package com.booking.model;

import java.math.BigDecimal;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Seat {
	  private int seatId;
	    private int screenId;
	    private String seatRow;
	    private int seatNumber;
	    private String seatType;
	    private BigDecimal price;
	    public String getSeatLabel() {
	        return seatRow + seatNumber;
	    }
}

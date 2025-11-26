package com.booking.model;

import java.math.BigDecimal;
import java.sql.Date;
import java.sql.Time;
import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Show {
	  private int showId;
	    private int movieId;
	    private int screenId;
	    private Date showDate;
	    private Time showTime;
	    private BigDecimal basePrice;
	    private boolean isActive;
	    private Timestamp createdAt;
	    
	    // Additional fields for display
	    private String movieName;
	    private String theatreName;
	    private String screenName;
	    
}

package com.booking.model;


import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Theatre {
	 private int theatreId;
	    private String theatreName;
	    private String location;
	    private String city;
	    private String address;
	    private String phoneNumber;
	    private int totalScreens;
	    private String facilities;
	    private boolean isActive;
	    private Timestamp createdAt;
	    private Timestamp updatedAt;
}

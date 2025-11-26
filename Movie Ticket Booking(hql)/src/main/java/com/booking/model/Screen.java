package com.booking.model;



import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Screen {
	private int screenId;
    private int theatreId;
    private String screenName;
    private int totalSeats;
    private String screenType;
}

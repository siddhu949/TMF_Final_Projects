package com.booking.model;

import java.sql.Date;
import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Movie {
	private int movieId;
    private String movieName;
    private String genre;
    private int duration;
    private double rating;
    private Date releaseDate;
    private String description;
    private String language;
    private String imageUrl;
    private boolean isActive;
    private Timestamp createdAt;
    private Timestamp updatedAt;
}

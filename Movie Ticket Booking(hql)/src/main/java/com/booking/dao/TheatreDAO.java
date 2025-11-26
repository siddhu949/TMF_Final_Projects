package com.booking.dao;

import com.booking.model.*;
import java.util.List;

// 2. TheatreDAO Interface
public interface TheatreDAO {
    List<Theatre> getAllActiveTheatres();
    Theatre getTheatreById(int theatreId);
    List<Theatre> getTheatresByCity(String city);
    List<Theatre> getTheatresByMovieId(int movieId);
    int addTheatre(Theatre theatre);
    int updateTheatre(Theatre theatre);
    int deleteTheatre(int theatreId);
}
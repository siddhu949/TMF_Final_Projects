package com.booking.dao;

import com.booking.model.*;
import java.util.List;


public interface ShowDAO {
    List<Show> getShowsByMovieId(int movieId);
    List<Show> getShowsByTheatreAndMovie(int movieId, int theatreId, String date);
    Show getShowById(int showId);
    List<Show> getShowsByDate(String date);
    int addShow(Show show);
    int updateShow(Show show);
    int deleteShow(int showId);
}

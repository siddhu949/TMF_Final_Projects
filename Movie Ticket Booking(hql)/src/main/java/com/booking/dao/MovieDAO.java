package com.booking.dao;

import com.booking.model.*;
import java.util.List;

// 1. MovieDAO Interface
public interface MovieDAO {
    List<Movie> getAllActiveMovies();
    Movie getMovieById(int movieId);
    List<Movie> searchMovies(String keyword);
    int addMovie(Movie movie);
    int updateMovie(Movie movie);
    int deleteMovie(int movieId);
}
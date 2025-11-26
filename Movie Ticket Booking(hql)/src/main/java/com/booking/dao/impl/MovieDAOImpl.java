package com.booking.dao.impl;

import com.booking.dao.MovieDAO;
import com.booking.model.Movie;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class MovieDAOImpl implements MovieDAO {
    
    @Autowired
    private JdbcTemplate jdbcTemplate;
    
    private static final class MovieRowMapper implements RowMapper<Movie> {
        @Override
        public Movie mapRow(ResultSet rs, int rowNum) throws SQLException {
            Movie movie = new Movie();
            movie.setMovieId(rs.getInt("movie_id"));
            movie.setMovieName(rs.getString("movie_name"));
            movie.setGenre(rs.getString("genre"));
            movie.setDuration(rs.getInt("duration"));
            movie.setRating(rs.getDouble("rating"));
            movie.setReleaseDate(rs.getDate("release_date"));
            movie.setDescription(rs.getString("description"));
            movie.setLanguage(rs.getString("language"));
            movie.setImageUrl(rs.getString("image_url"));
            movie.setActive(rs.getBoolean("is_active"));
            movie.setCreatedAt(rs.getTimestamp("created_at"));
            movie.setUpdatedAt(rs.getTimestamp("updated_at"));
            return movie;
        }
    }
    
    @Override
    public List<Movie> getAllActiveMovies() {
        String sql = "SELECT * FROM movies WHERE is_active = TRUE ORDER BY movie_name";
        return jdbcTemplate.query(sql, new MovieRowMapper());
    }
    
    @Override
    public Movie getMovieById(int movieId) {
        String sql = "SELECT * FROM movies WHERE movie_id = ?";
        return jdbcTemplate.queryForObject(sql, new MovieRowMapper(), movieId);
    }
    
    @Override
    public List<Movie> searchMovies(String keyword) {
        String sql = "SELECT * FROM movies WHERE is_active = TRUE AND " +
                     "(movie_name LIKE ? OR genre LIKE ? OR language LIKE ?)";
        String searchPattern = "%" + keyword + "%";
        return jdbcTemplate.query(sql, new MovieRowMapper(), searchPattern, searchPattern, searchPattern);
    }
    
    @Override
    public int addMovie(Movie movie) {
        String sql = "INSERT INTO movies (movie_name, genre, duration, rating, release_date, " +
                     "description, language, image_url, is_active) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        return jdbcTemplate.update(sql, movie.getMovieName(), movie.getGenre(), 
                movie.getDuration(), movie.getRating(), movie.getReleaseDate(),
                movie.getDescription(), movie.getLanguage(), movie.getImageUrl(), movie.isActive());
    }
    
    @Override
    public int updateMovie(Movie movie) {
        String sql = "UPDATE movies SET movie_name = ?, genre = ?, duration = ?, rating = ?, " +
                     "release_date = ?, description = ?, language = ?, image_url = ?, is_active = ? " +
                     "WHERE movie_id = ?";
        return jdbcTemplate.update(sql, movie.getMovieName(), movie.getGenre(),
                movie.getDuration(), movie.getRating(), movie.getReleaseDate(),
                movie.getDescription(), movie.getLanguage(), movie.getImageUrl(),
                movie.isActive(), movie.getMovieId());
    }
    
    @Override
    public int deleteMovie(int movieId) {
        String sql = "UPDATE movies SET is_active = FALSE WHERE movie_id = ?";
        return jdbcTemplate.update(sql, movieId);
    }
}
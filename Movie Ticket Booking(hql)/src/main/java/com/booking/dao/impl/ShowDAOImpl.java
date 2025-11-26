package com.booking.dao.impl;

import com.booking.dao.ShowDAO;
import com.booking.model.Show;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class ShowDAOImpl implements ShowDAO {
    
    @Autowired
    private JdbcTemplate jdbcTemplate;
    
    private static final class ShowRowMapper implements RowMapper<Show> {
        @Override
        public Show mapRow(ResultSet rs, int rowNum) throws SQLException {
            Show show = new Show();
            show.setShowId(rs.getInt("show_id"));
            show.setMovieId(rs.getInt("movie_id"));
            show.setScreenId(rs.getInt("screen_id"));
            show.setShowDate(rs.getDate("show_date"));
            show.setShowTime(rs.getTime("show_time"));
            show.setBasePrice(rs.getBigDecimal("base_price"));
            show.setActive(rs.getBoolean("is_active"));
            show.setCreatedAt(rs.getTimestamp("created_at"));
            
            // Additional fields if joined
            try {
                show.setMovieName(rs.getString("movie_name"));
                show.setTheatreName(rs.getString("theatre_name"));
                show.setScreenName(rs.getString("screen_name"));
            } catch (SQLException e) {
                // Fields not present in simple query
            }
            
            return show;
        }
    }
    
    @Override
    public List<Show> getShowsByMovieId(int movieId) {
        String sql = "SELECT sh.*, m.movie_name, t.theatre_name, sc.screen_name " +
                     "FROM shows sh " +
                     "INNER JOIN movies m ON sh.movie_id = m.movie_id " +
                     "INNER JOIN screens sc ON sh.screen_id = sc.screen_id " +
                     "INNER JOIN theatres t ON sc.theatre_id = t.theatre_id " +
                     "WHERE sh.movie_id = ? AND sh.is_active = TRUE " +
                     "ORDER BY sh.show_date, sh.show_time";
        return jdbcTemplate.query(sql, new ShowRowMapper(), movieId);
    }
    
    @Override
    public List<Show> getShowsByTheatreAndMovie(int movieId, int theatreId, String date) {
        String sql = "SELECT sh.*, m.movie_name, t.theatre_name, sc.screen_name " +
                     "FROM shows sh " +
                     "INNER JOIN movies m ON sh.movie_id = m.movie_id " +
                     "INNER JOIN screens sc ON sh.screen_id = sc.screen_id " +
                     "INNER JOIN theatres t ON sc.theatre_id = t.theatre_id " +
                     "WHERE sh.movie_id = ? AND t.theatre_id = ? AND sh.show_date = ? " +
                     "AND sh.is_active = TRUE " +
                     "ORDER BY sh.show_time";
        return jdbcTemplate.query(sql, new ShowRowMapper(), movieId, theatreId, date);
    }
    
    @Override
    public Show getShowById(int showId) {
        String sql = "SELECT sh.*, m.movie_name, t.theatre_name, sc.screen_name " +
                     "FROM shows sh " +
                     "INNER JOIN movies m ON sh.movie_id = m.movie_id " +
                     "INNER JOIN screens sc ON sh.screen_id = sc.screen_id " +
                     "INNER JOIN theatres t ON sc.theatre_id = t.theatre_id " +
                     "WHERE sh.show_id = ?";
        return jdbcTemplate.queryForObject(sql, new ShowRowMapper(), showId);
    }
    
    @Override
    public List<Show> getShowsByDate(String date) {
        String sql = "SELECT sh.*, m.movie_name, t.theatre_name, sc.screen_name " +
                     "FROM shows sh " +
                     "INNER JOIN movies m ON sh.movie_id = m.movie_id " +
                     "INNER JOIN screens sc ON sh.screen_id = sc.screen_id " +
                     "INNER JOIN theatres t ON sc.theatre_id = t.theatre_id " +
                     "WHERE sh.show_date = ? AND sh.is_active = TRUE " +
                     "ORDER BY m.movie_name, t.theatre_name, sh.show_time";
        return jdbcTemplate.query(sql, new ShowRowMapper(), date);
    }
    
    @Override
    public int addShow(Show show) {
        String sql = "INSERT INTO shows (movie_id, screen_id, show_date, show_time, base_price, is_active) " +
                     "VALUES (?, ?, ?, ?, ?, ?)";
        return jdbcTemplate.update(sql, show.getMovieId(), show.getScreenId(),
                show.getShowDate(), show.getShowTime(), show.getBasePrice(), show.isActive());
    }
    
    @Override
    public int updateShow(Show show) {
        String sql = "UPDATE shows SET movie_id = ?, screen_id = ?, show_date = ?, show_time = ?, " +
                     "base_price = ?, is_active = ? WHERE show_id = ?";
        return jdbcTemplate.update(sql, show.getMovieId(), show.getScreenId(),
                show.getShowDate(), show.getShowTime(), show.getBasePrice(),
                show.isActive(), show.getShowId());
    }
    
    @Override
    public int deleteShow(int showId) {
        String sql = "UPDATE shows SET is_active = FALSE WHERE show_id = ?";
        return jdbcTemplate.update(sql, showId);
    }
}
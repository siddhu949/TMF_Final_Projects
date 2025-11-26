package com.booking.dao.impl;

import com.booking.dao.TheatreDAO;
import com.booking.model.Theatre;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class TheatreDAOImpl implements TheatreDAO {
    
    @Autowired
    private JdbcTemplate jdbcTemplate;
    
    private static final class TheatreRowMapper implements RowMapper<Theatre> {
        @Override
        public Theatre mapRow(ResultSet rs, int rowNum) throws SQLException {
            Theatre theatre = new Theatre();
            theatre.setTheatreId(rs.getInt("theatre_id"));
            theatre.setTheatreName(rs.getString("theatre_name"));
            theatre.setLocation(rs.getString("location"));
            theatre.setCity(rs.getString("city"));
            theatre.setAddress(rs.getString("address"));
            theatre.setPhoneNumber(rs.getString("phone_number"));
            theatre.setTotalScreens(rs.getInt("total_screens"));
            theatre.setFacilities(rs.getString("facilities"));
            theatre.setActive(rs.getBoolean("is_active"));
            theatre.setCreatedAt(rs.getTimestamp("created_at"));
            theatre.setUpdatedAt(rs.getTimestamp("updated_at"));
            return theatre;
        }
    }
    
    @Override
    public List<Theatre> getAllActiveTheatres() {
        String sql = "SELECT * FROM theatres WHERE is_active = TRUE ORDER BY theatre_name";
        return jdbcTemplate.query(sql, new TheatreRowMapper());
    }
    
    @Override
    public Theatre getTheatreById(int theatreId) {
        String sql = "SELECT * FROM theatres WHERE theatre_id = ?";
        return jdbcTemplate.queryForObject(sql, new TheatreRowMapper(), theatreId);
    }
    
    @Override
    public List<Theatre> getTheatresByCity(String city) {
        String sql = "SELECT * FROM theatres WHERE is_active = TRUE AND city = ? ORDER BY theatre_name";
        return jdbcTemplate.query(sql, new TheatreRowMapper(), city);
    }
    
    @Override
    public List<Theatre> getTheatresByMovieId(int movieId) {
        String sql = "SELECT DISTINCT t.* FROM theatres t " +
                     "INNER JOIN screens sc ON t.theatre_id = sc.theatre_id " +
                     "INNER JOIN shows sh ON sc.screen_id = sh.screen_id " +
                     "WHERE t.is_active = TRUE AND sh.movie_id = ? AND sh.is_active = TRUE " +
                     "ORDER BY t.theatre_name";
        return jdbcTemplate.query(sql, new TheatreRowMapper(), movieId);
    }
    
    @Override
    public int addTheatre(Theatre theatre) {
        String sql = "INSERT INTO theatres (theatre_name, location, city, address, phone_number, " +
                     "total_screens, facilities, is_active) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        return jdbcTemplate.update(sql, theatre.getTheatreName(), theatre.getLocation(),
                theatre.getCity(), theatre.getAddress(), theatre.getPhoneNumber(),
                theatre.getTotalScreens(), theatre.getFacilities(), theatre.isActive());
    }
    
    @Override
    public int updateTheatre(Theatre theatre) {
        String sql = "UPDATE theatres SET theatre_name = ?, location = ?, city = ?, address = ?, " +
                     "phone_number = ?, total_screens = ?, facilities = ?, is_active = ? " +
                     "WHERE theatre_id = ?";
        return jdbcTemplate.update(sql, theatre.getTheatreName(), theatre.getLocation(),
                theatre.getCity(), theatre.getAddress(), theatre.getPhoneNumber(),
                theatre.getTotalScreens(), theatre.getFacilities(), theatre.isActive(),
                theatre.getTheatreId());
    }
    
    @Override
    public int deleteTheatre(int theatreId) {
        String sql = "UPDATE theatres SET is_active = FALSE WHERE theatre_id = ?";
        return jdbcTemplate.update(sql, theatreId);
    }
}
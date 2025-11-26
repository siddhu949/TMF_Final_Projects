package com.booking.dao.impl;

import com.booking.dao.SeatDAO;
import com.booking.model.Seat;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

@Repository
public class SeatDAOImpl implements SeatDAO {
    
    @Autowired
    private JdbcTemplate jdbcTemplate;
    
    private static final class SeatRowMapper implements RowMapper<Seat> {
        @Override
        public Seat mapRow(ResultSet rs, int rowNum) throws SQLException {
            Seat seat = new Seat();
            seat.setSeatId(rs.getInt("seat_id"));
            seat.setScreenId(rs.getInt("screen_id"));
            seat.setSeatRow(rs.getString("seat_row"));
            seat.setSeatNumber(rs.getInt("seat_number"));
            seat.setSeatType(rs.getString("seat_type"));
            seat.setPrice(rs.getBigDecimal("price"));
            return seat;
        }
    }
    
    @Override
    public List<Seat> getSeatsByScreenId(int screenId) {
        String sql = "SELECT * FROM seats WHERE screen_id = ? ORDER BY seat_row, seat_number";
        return jdbcTemplate.query(sql, new SeatRowMapper(), screenId);
    }
    
    @Override
    public Seat getSeatById(int seatId) {
        String sql = "SELECT * FROM seats WHERE seat_id = ?";
        return jdbcTemplate.queryForObject(sql, new SeatRowMapper(), seatId);
    }
    
    @Override
    public Map<String, List<Seat>> getSeatsByShowId(int showId) {
        String sql = "SELECT s.* FROM seats s " +
                     "INNER JOIN screens sc ON s.screen_id = sc.screen_id " +
                     "INNER JOIN shows sh ON sc.screen_id = sh.screen_id " +
                     "WHERE sh.show_id = ? " +
                     "ORDER BY s.seat_row, s.seat_number";
        
        List<Seat> allSeats = jdbcTemplate.query(sql, new SeatRowMapper(), showId);
        
        Map<String, List<Seat>> seatMap = new LinkedHashMap<>();
        for (Seat seat : allSeats) {
            seatMap.computeIfAbsent(seat.getSeatRow(), k -> new ArrayList<>()).add(seat);
        }
        
        return seatMap;
    }
    
    @Override
    public List<Integer> getBookedSeatIds(int showId) {
        String sql = "SELECT seat_id FROM show_seat_status WHERE show_id = ? AND is_booked = TRUE";
        return jdbcTemplate.queryForList(sql, Integer.class, showId);
    }
    
    @Override
    public int addSeat(Seat seat) {
        String sql = "INSERT INTO seats (screen_id, seat_row, seat_number, seat_type, price) " +
                     "VALUES (?, ?, ?, ?, ?)";
        return jdbcTemplate.update(sql, seat.getScreenId(), seat.getSeatRow(),
                seat.getSeatNumber(), seat.getSeatType(), seat.getPrice());
    }
}
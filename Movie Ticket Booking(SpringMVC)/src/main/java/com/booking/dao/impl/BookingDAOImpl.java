package com.booking.dao.impl;

import com.booking.dao.BookingDAO;
import com.booking.model.Booking;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;
import java.sql.*;
import java.util.List;
import java.util.UUID;

@Repository
public class BookingDAOImpl implements BookingDAO {
    
    @Autowired
    private JdbcTemplate jdbcTemplate;
    
    private static final class BookingRowMapper implements RowMapper<Booking> {
        @Override
        public Booking mapRow(ResultSet rs, int rowNum) throws SQLException {
            Booking booking = new Booking();
            booking.setBookingId(rs.getInt("booking_id"));
            booking.setUserId(rs.getInt("user_id"));
            booking.setShowId(rs.getInt("show_id"));
            booking.setBookingDate(rs.getTimestamp("booking_date"));
            booking.setTotalSeats(rs.getInt("total_seats"));
            booking.setTotalAmount(rs.getBigDecimal("total_amount"));
            booking.setBookingStatus(rs.getString("booking_status"));
            booking.setPaymentStatus(rs.getString("payment_status"));
            booking.setPaymentMethod(rs.getString("payment_method"));
            booking.setTicketNumber(rs.getString("ticket_number"));
            return booking;
        }
    }
    
    @Override
    public int createBooking(Booking booking) {
        String sql = "INSERT INTO bookings (user_id, show_id, total_seats, total_amount, " +
                     "booking_status, payment_status, payment_method, ticket_number) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        
        KeyHolder keyHolder = new GeneratedKeyHolder();
        jdbcTemplate.update(connection -> {
            PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, booking.getUserId());
            ps.setInt(2, booking.getShowId());
            ps.setInt(3, booking.getTotalSeats());
            ps.setBigDecimal(4, booking.getTotalAmount());
            ps.setString(5, booking.getBookingStatus());
            ps.setString(6, booking.getPaymentStatus());
            ps.setString(7, booking.getPaymentMethod());
            ps.setString(8, booking.getTicketNumber());
            return ps;
        }, keyHolder);
        
        return keyHolder.getKey().intValue();
    }
    
    @Override
    public int addBookingSeat(int bookingId, int seatId, double price) {
        String sql = "INSERT INTO booking_seats (booking_id, seat_id, seat_price) VALUES (?, ?, ?)";
        return jdbcTemplate.update(sql, bookingId, seatId, price);
    }
    
    @Override
    public int updateSeatStatus(int showId, int seatId, boolean isBooked, int bookingId) {
        String sql = "UPDATE show_seat_status SET is_booked = ?, booking_id = ? " +
                     "WHERE show_id = ? AND seat_id = ?";
        return jdbcTemplate.update(sql, isBooked, bookingId, showId, seatId);
    }
    
    @Override
    public Booking getBookingById(int bookingId) {
        String sql = "SELECT * FROM bookings WHERE booking_id = ?";
        return jdbcTemplate.queryForObject(sql, new BookingRowMapper(), bookingId);
    }
    
    @Override
    public List<Booking> getBookingsByUserId(int userId) {
        String sql = "SELECT * FROM bookings WHERE user_id = ? ORDER BY booking_date DESC";
        return jdbcTemplate.query(sql, new BookingRowMapper(), userId);
    }
    
    @Override
    public List<Integer> getBookedSeats(int bookingId) {
        String sql = "SELECT seat_id FROM booking_seats WHERE booking_id = ?";
        return jdbcTemplate.queryForList(sql, Integer.class, bookingId);
    }
    
    @Override
    public int cancelBooking(int bookingId) {
        String sql = "UPDATE bookings SET booking_status = 'CANCELLED' WHERE booking_id = ?";
        return jdbcTemplate.update(sql, bookingId);
    }
    
    @Override
    public String generateTicketNumber() {
        return "TKT" + System.currentTimeMillis() + UUID.randomUUID().toString().substring(0, 6).toUpperCase();
    }
}
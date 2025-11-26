package com.booking.service;

import com.booking.dao.*;
import com.booking.model.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.math.BigDecimal;
import java.util.*;

@Service
public class BookingService {
    
    @Autowired
    private MovieDAO movieDAO;
    
    @Autowired
    private TheatreDAO theatreDAO;
    
    @Autowired
    private ShowDAO showDAO;
    
    @Autowired
    private SeatDAO seatDAO;
    
    @Autowired
    private UserDAO userDAO;
    
    @Autowired
    private BookingDAO bookingDAO;
    
    // ========== Movie Operations ==========
    
    public List<Movie> getAllMovies() {
        return movieDAO.getAllActiveMovies();
    }
    
    public Movie getMovieById(int movieId) {
        return movieDAO.getMovieById(movieId);
    }
    
    public List<Movie> searchMovies(String keyword) {
        return movieDAO.searchMovies(keyword);
    }
    
    // ========== Theatre Operations ==========
    
    public List<Theatre> getAllTheatres() {
        return theatreDAO.getAllActiveTheatres();
    }
    
    public Theatre getTheatreById(int theatreId) {
        return theatreDAO.getTheatreById(theatreId);
    }
    
    public List<Theatre> getTheatresByMovieId(int movieId) {
        return theatreDAO.getTheatresByMovieId(movieId);
    }
    
    public List<Theatre> getTheatresByCity(String city) {
        return theatreDAO.getTheatresByCity(city);
    }
    
    // ========== Show Operations ==========
    
    public List<Show> getShowsByMovieId(int movieId) {
        return showDAO.getShowsByMovieId(movieId);
    }
    
    public List<Show> getShowsByTheatreAndMovie(int movieId, int theatreId, String date) {
        return showDAO.getShowsByTheatreAndMovie(movieId, theatreId, date);
    }
    
    public Show getShowById(int showId) {
        return showDAO.getShowById(showId);
    }
    
    public List<Show> getShowsByDate(String date) {
        return showDAO.getShowsByDate(date);
    }
    
    // ========== Seat Operations ==========
    
    public Map<String, List<Seat>> getSeatsForShow(int showId) {
        return seatDAO.getSeatsByShowId(showId);
    }
    
    public List<Integer> getBookedSeats(int showId) {
        return seatDAO.getBookedSeatIds(showId);
    }
    
    public Seat getSeatById(int seatId) {
        return seatDAO.getSeatById(seatId);
    }
    
    // ========== User Operations ==========
    
    public User validateUser(String username, String password) {
        return userDAO.validateUser(username, password);
    }
    
    public User getUserByUsername(String username) {
        return userDAO.getUserByUsername(username);
    }
    
    public User getUserById(int userId) {
        return userDAO.getUserById(userId);
    }
    
    public boolean registerUser(User user) {
        if (userDAO.isUsernameExists(user.getUsername())) {
            return false;
        }
        if (userDAO.isEmailExists(user.getEmail())) {
            return false;
        }
        return userDAO.addUser(user) > 0;
    }
    
    // ========== Booking Operations ==========
    
    @Transactional
    public Booking createBooking(int userId, int showId, List<Integer> seatIds) {
        try {
            // Calculate total amount
            BigDecimal totalAmount = BigDecimal.ZERO;
            for (Integer seatId : seatIds) {
                Seat seat = seatDAO.getSeatById(seatId);
                totalAmount = totalAmount.add(seat.getPrice());
            }
            
            // Add convenience fee and GST
            BigDecimal convenienceFee = new BigDecimal("50");
            BigDecimal subtotal = totalAmount.add(convenienceFee);
            BigDecimal gst = subtotal.multiply(new BigDecimal("0.18"));
            BigDecimal finalAmount = subtotal.add(gst);
            
            // Create booking object
            Booking booking = new Booking();
            booking.setUserId(userId);
            booking.setShowId(showId);
            booking.setTotalSeats(seatIds.size());
            booking.setTotalAmount(finalAmount);
            booking.setBookingStatus("CONFIRMED");
            booking.setPaymentStatus("PAID");
            booking.setPaymentMethod("Online");
            booking.setTicketNumber(bookingDAO.generateTicketNumber());
            
            // Insert booking
            int bookingId = bookingDAO.createBooking(booking);
            booking.setBookingId(bookingId);
            
            // Add booking seats and update seat status
            for (Integer seatId : seatIds) {
                Seat seat = seatDAO.getSeatById(seatId);
                bookingDAO.addBookingSeat(bookingId, seatId, seat.getPrice().doubleValue());
                bookingDAO.updateSeatStatus(showId, seatId, true, bookingId);
            }
            
            return booking;
            
        } catch (Exception e) {
            throw new RuntimeException("Error creating booking: " + e.getMessage());
        }
    }
    
    public Booking getBookingById(int bookingId) {
        return bookingDAO.getBookingById(bookingId);
    }
    
    public List<Booking> getUserBookings(int userId) {
        return bookingDAO.getBookingsByUserId(userId);
    }
    
    public List<Integer> getBookedSeatsForBooking(int bookingId) {
        return bookingDAO.getBookedSeats(bookingId);
    }
    
    public List<String> getSeatLabelsForBooking(int bookingId) {
        List<Integer> seatIds = bookingDAO.getBookedSeats(bookingId);
        List<String> seatLabels = new ArrayList<>();
        
        for (Integer seatId : seatIds) {
            Seat seat = seatDAO.getSeatById(seatId);
            seatLabels.add(seat.getSeatLabel());
        }
        
        return seatLabels;
    }
    
    public BigDecimal calculateTotalPrice(List<Integer> seatIds) {
        BigDecimal total = BigDecimal.ZERO;
        
        for (Integer seatId : seatIds) {
            Seat seat = seatDAO.getSeatById(seatId);
            total = total.add(seat.getPrice());
        }
        
        return total;
    }
    
    public Map<String, BigDecimal> calculatePriceBreakdown(List<Integer> seatIds) {
        Map<String, BigDecimal> breakdown = new LinkedHashMap<>();
        
        BigDecimal ticketPrice = calculateTotalPrice(seatIds);
        BigDecimal convenienceFee = new BigDecimal("50");
        BigDecimal subtotal = ticketPrice.add(convenienceFee);
        BigDecimal gst = subtotal.multiply(new BigDecimal("0.18"));
        BigDecimal total = subtotal.add(gst);
        
        breakdown.put("ticketPrice", ticketPrice);
        breakdown.put("convenienceFee", convenienceFee);
        breakdown.put("gst", gst);
        breakdown.put("total", total);
        
        return breakdown;
    }
    
    @Transactional
    public boolean cancelBooking(int bookingId) {
        try {
            // Get booking details
            Booking booking = bookingDAO.getBookingById(bookingId);
            List<Integer> seatIds = bookingDAO.getBookedSeats(bookingId);
            
            // Update seat status to available
            for (Integer seatId : seatIds) {
                bookingDAO.updateSeatStatus(booking.getShowId(), seatId, false, 0);
            }
            
            // Cancel booking
            bookingDAO.cancelBooking(bookingId);
            
            return true;
        } catch (Exception e) {
            return false;
        }
    }
}
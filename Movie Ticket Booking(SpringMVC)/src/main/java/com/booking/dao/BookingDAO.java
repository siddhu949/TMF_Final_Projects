package com.booking.dao;

import com.booking.model.*;
import java.util.List;


public interface BookingDAO {
    int createBooking(Booking booking);
    int addBookingSeat(int bookingId, int seatId, double price);
    int updateSeatStatus(int showId, int seatId, boolean isBooked, int bookingId);
    Booking getBookingById(int bookingId);
    List<Booking> getBookingsByUserId(int userId);
    List<Integer> getBookedSeats(int bookingId);
    int cancelBooking(int bookingId);
    String generateTicketNumber();
}
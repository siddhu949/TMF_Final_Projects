package com.booking.dao;

import com.booking.model.*;
import java.util.List;
import java.util.Map;


public interface SeatDAO {
    List<Seat> getSeatsByScreenId(int screenId);
    Seat getSeatById(int seatId);
    Map<String, List<Seat>> getSeatsByShowId(int showId);
    List<Integer> getBookedSeatIds(int showId);
    int addSeat(Seat seat);
}
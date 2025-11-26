package com.booking.controller;

import com.booking.model.*;
import com.booking.service.BookingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import jakarta.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.stream.Collectors;

@Controller
public class BookingController {
    
    @Autowired
    private BookingService bookingService;
    
    // Home Page - Display all active movies
    @GetMapping("/")
    public String home(Model model) {
        try {
            List<Movie> movies = bookingService.getAllMovies();
            model.addAttribute("movies", movies);
            System.out.println("Loaded " + movies.size() + " movies"); // Debug log
        } catch (Exception e) {
            System.err.println("Error loading movies: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("movies", new ArrayList<>());
            model.addAttribute("error", "Unable to load movies. Please try again later.");
        }
        return "home";
    }
    
    // Movies Page - Same as home but can be extended
    @GetMapping("/movies")
    public String moviesPage(Model model) {
        try {
            List<Movie> movies = bookingService.getAllMovies();
            model.addAttribute("movies", movies);
        } catch (Exception e) {
            System.err.println("Error loading movies: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("movies", new ArrayList<>());
            model.addAttribute("error", "Unable to load movies. Please try again later.");
        }
        return "movies";
    }
    
    // About Page
    @GetMapping("/about")
    public String aboutPage() {
        return "about";
    }
    
    // Search Movies
    @GetMapping("/search")
    public String searchMovies(@RequestParam(value = "movieName", required = false) String movieName, 
                               @RequestParam(value = "theatre", required = false) String theatre,
                               Model model) {
        try {
            List<Movie> movies;
            
            if (movieName != null && !movieName.trim().isEmpty()) {
                movies = bookingService.searchMovies(movieName.trim());
                System.out.println("Search results for '" + movieName + "': " + movies.size() + " movies"); // Debug log
            } else {
                movies = bookingService.getAllMovies();
            }
            
            model.addAttribute("movies", movies);
            model.addAttribute("searchTerm", movieName);
            
            if (movies.isEmpty()) {
                model.addAttribute("message", "No movies found matching your search.");
            }
        } catch (Exception e) {
            System.err.println("Error searching movies: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("movies", new ArrayList<>());
            model.addAttribute("error", "Search failed. Please try again.");
        }
        return "home";
    }
    
    // Theatre Selection Page - Show theatres and shows for selected movie
    @GetMapping("/theatres")
    public String showTheatres(@RequestParam(value = "movieId") int movieId,
                               @RequestParam(value = "date", required = false) String date,
                               Model model) {
        try {
            // Get movie details
            Movie movie = bookingService.getMovieById(movieId);
            model.addAttribute("movieId", movieId);
            model.addAttribute("movieName", movie.getMovieName());
            
            // Set date (current date if not provided)
            String selectedDate = (date != null && !date.isEmpty()) ? date : getCurrentDate();
            model.addAttribute("selectedDate", selectedDate);
            
            System.out.println("Fetching theatres for movieId: " + movieId + ", date: " + selectedDate);
            
            // Get theatres showing this movie
            List<Theatre> theatres = bookingService.getTheatresByMovieId(movieId);
            System.out.println("Found " + theatres.size() + " theatres for movie: " + movie.getMovieName());
            
            // For each theatre, get shows for the selected date
            Map<Integer, List<Show>> theatreShowsMap = new HashMap<>();
            for (Theatre theatre : theatres) {
                List<Show> shows = bookingService.getShowsByTheatreAndMovie(movieId, theatre.getTheatreId(), selectedDate);
                System.out.println("Theatre: " + theatre.getTheatreName() + " has " + shows.size() + " shows");
                
                // Add to map even if empty to maintain theatre visibility
                theatreShowsMap.put(theatre.getTheatreId(), shows);
            }
            
            model.addAttribute("theatres", theatres);
            model.addAttribute("theatreShowsMap", theatreShowsMap);
            
            if (theatres.isEmpty()) {
                model.addAttribute("message", "No theatres available for this movie at the moment. Please try again later or select a different movie.");
            }
            
        } catch (Exception e) {
            System.err.println("Error loading theatres: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("error", "Unable to load theatre information. Please try again.");
            model.addAttribute("theatres", new ArrayList<>());
            model.addAttribute("theatreShowsMap", new HashMap<>());
        }
        
        return "theatres";
    }
    
    // Seat Selection Page
    @GetMapping("/seats")
    public String showSeats(@RequestParam(value = "showId") int showId,
                           Model model) {
        try {
            // Get show details
            Show show = bookingService.getShowById(showId);
            
            model.addAttribute("showId", showId);
            model.addAttribute("movieId", show.getMovieId());
            model.addAttribute("movieName", show.getMovieName());
            model.addAttribute("theatreName", show.getTheatreName());
            model.addAttribute("showTime", show.getShowTime().toString());
            model.addAttribute("date", show.getShowDate().toString());
            
            // Get seats layout
            Map<String, List<Seat>> seats = bookingService.getSeatsForShow(showId);
            model.addAttribute("seats", seats);
            
            // Get booked seats
            List<Integer> bookedSeatIds = bookingService.getBookedSeats(showId);
            model.addAttribute("bookedSeatIds", bookedSeatIds);
            
            System.out.println("Show ID: " + showId);
            System.out.println("Total seats: " + seats.values().stream().mapToInt(List::size).sum());
            System.out.println("Booked seats: " + bookedSeatIds.size());
            System.out.println("Booked seat IDs: " + bookedSeatIds);
            
        } catch (Exception e) {
            System.err.println("Error loading seats: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("error", "Unable to load seat information.");
        }
        
        return "seats";
    }
    
    // Booking Summary Page (Check Login)
    @PostMapping("/booking-summary")
    public String bookingSummary(@RequestParam(value = "showId") int showId,
                                 @RequestParam(value = "selectedSeats") String selectedSeats,
                                 HttpSession session,
                                 Model model) {
        
        System.out.println("Booking summary requested for showId: " + showId);
        System.out.println("Selected seat IDs: " + selectedSeats);
        
        // Check if user is logged in
        User user = (User) session.getAttribute("user");
        if (user == null) {
            // Store booking details in session for after login
            Map<String, String> pendingBooking = new HashMap<>();
            pendingBooking.put("showId", String.valueOf(showId));
            pendingBooking.put("selectedSeats", selectedSeats);
            session.setAttribute("pendingBooking", pendingBooking);
            System.out.println("User not logged in, redirecting to login");
            return "redirect:/login";
        }
        
        try {
            // Get show details
            Show show = bookingService.getShowById(showId);
            
            // Parse seat IDs
            List<Integer> seatIds = Arrays.stream(selectedSeats.split(","))
                    .map(String::trim)
                    .filter(s -> !s.isEmpty())
                    .map(Integer::parseInt)
                    .collect(Collectors.toList());
            
            System.out.println("Parsed " + seatIds.size() + " seat IDs");
            
            // Get seat labels
            List<String> seatLabels = new ArrayList<>();
            for (Integer seatId : seatIds) {
                Seat seat = bookingService.getSeatById(seatId);
                seatLabels.add(seat.getSeatLabel());
            }
            
            // Calculate price breakdown
            Map<String, BigDecimal> priceBreakdown = bookingService.calculatePriceBreakdown(seatIds);
            
            model.addAttribute("showId", showId);
            model.addAttribute("movieName", show.getMovieName());
            model.addAttribute("theatreName", show.getTheatreName());
            model.addAttribute("showTime", show.getShowTime().toString());
            model.addAttribute("date", show.getShowDate().toString());
            model.addAttribute("selectedSeats", String.join(", ", seatLabels));
            model.addAttribute("selectedSeatIds", selectedSeats);
            model.addAttribute("ticketPrice", priceBreakdown.get("ticketPrice"));
            model.addAttribute("convenienceFee", priceBreakdown.get("convenienceFee"));
            model.addAttribute("gst", priceBreakdown.get("gst"));
            model.addAttribute("totalPrice", priceBreakdown.get("total"));
            
            System.out.println("Booking summary prepared successfully");
            
        } catch (Exception e) {
            System.err.println("Error preparing booking summary: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("error", "Unable to process booking. Please try again.");
            return "error";
        }
        
        return "booking-summary";
    }
    
    // Login Page
    @GetMapping("/login")
    public String showLogin() {
        return "login";
    }
    
    // Login Process
    @PostMapping("/login")
    public String login(@RequestParam(value = "username") String username,
                       @RequestParam(value = "password") String password,
                       HttpSession session,
                       Model model) {
        
        // Validate user from database
        User user = bookingService.validateUser(username, password);
        
        if (user != null) {
            session.setAttribute("user", user);
            session.setAttribute("username", user.getUsername());
            
            // Check if there's a pending booking
            @SuppressWarnings("unchecked")
            Map<String, String> pendingBooking = (Map<String, String>) session.getAttribute("pendingBooking");
            
            if (pendingBooking != null) {
                session.removeAttribute("pendingBooking");
                
                int showId = Integer.parseInt(pendingBooking.get("showId"));
                String selectedSeats = pendingBooking.get("selectedSeats");
                
                // Redirect to booking summary with parameters
                return "redirect:/booking-summary?showId=" + showId + "&selectedSeats=" + selectedSeats;
            }
            
            return "redirect:/";
        }
        
        model.addAttribute("error", "Invalid username or password");
        return "login";
    }
    
    // Register Page
    @GetMapping("/register")
    public String showRegister() {
        return "register";
    }
    
    // Register Process
    @PostMapping("/register")
    public String register(@RequestParam(value = "username") String username,
                          @RequestParam(value = "password") String password,
                          @RequestParam(value = "email") String email,
                          @RequestParam(value = "fullName") String fullName,
                          @RequestParam(value = "phoneNumber") String phoneNumber,
                          Model model) {
        
        User user = new User();
        user.setUsername(username);
        user.setPassword(password);
        user.setEmail(email);
        user.setFullName(fullName);
        user.setPhoneNumber(phoneNumber);
        
        boolean success = bookingService.registerUser(user);
        
        if (success) {
            model.addAttribute("success", "Registration successful! Please login.");
            return "login";
        } else {
            model.addAttribute("error", "Username or email already exists");
            return "register";
        }
    }
    
    // Confirm Booking and Generate Ticket
    @PostMapping("/confirm-booking")
    public String confirmBooking(@RequestParam(value = "showId") int showId,
                                @RequestParam(value = "selectedSeatIds") String selectedSeatIds,
                                @RequestParam(value = "movieName") String movieName,
                                @RequestParam(value = "theatreName") String theatreName,
                                @RequestParam(value = "showTime") String showTime,
                                @RequestParam(value = "date", required = false) String date,
                                @RequestParam(value = "selectedSeats") String selectedSeats,
                                @RequestParam(value = "totalPrice") String totalPrice,
                                HttpSession session,
                                Model model) {
        
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        
        // Validate date parameter
        if (date == null || date.trim().isEmpty()) {
            Show show = bookingService.getShowById(showId);
            date = new SimpleDateFormat("yyyy-MM-dd").format(show.getShowDate());
        }
        
        try {
            List<Integer> seatIds = Arrays.stream(selectedSeatIds.split(","))
                    .map(Integer::parseInt)
                    .collect(Collectors.toList());
            
            Booking booking = bookingService.createBooking(user.getUserId(), showId, seatIds);
            
            List<String> seatLabels = bookingService.getSeatLabelsForBooking(booking.getBookingId());
            
            model.addAttribute("ticketId", booking.getTicketNumber());
            model.addAttribute("bookingId", booking.getBookingId());
            model.addAttribute("username", user.getFullName());
            model.addAttribute("movieName", movieName);
            model.addAttribute("theatreName", theatreName);
            model.addAttribute("showTime", showTime);
            model.addAttribute("date", date);
            model.addAttribute("selectedSeats", String.join(",", seatLabels));
            model.addAttribute("totalPrice", booking.getTotalAmount());
            model.addAttribute("bookingDate", new SimpleDateFormat("yyyy-MM-dd").format(booking.getBookingDate()));
            
            return "ticket";
            
        } catch (Exception e) {
            model.addAttribute("error", "Booking failed: " + e.getMessage());
            e.printStackTrace();
            return "error";
        }
    }
    
    // My Bookings Page
    @GetMapping("/my-bookings")
    public String myBookings(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        
        try {
            List<Booking> bookings = bookingService.getUserBookings(user.getUserId());
            
            // Enhance bookings with show and movie details
            for (Booking booking : bookings) {
                Show show = bookingService.getShowById(booking.getShowId());
                booking.setMovieName(show.getMovieName());
                booking.setTheatreName(show.getTheatreName());
                booking.setShowDate(show.getShowDate().toString());
                booking.setShowTime(show.getShowTime().toString());
            }
            
            model.addAttribute("bookings", bookings);
            System.out.println("Loaded " + bookings.size() + " bookings for user: " + user.getUsername());
            
        } catch (Exception e) {
            System.err.println("Error loading bookings: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("bookings", new ArrayList<>());
            model.addAttribute("error", "Unable to load your bookings.");
        }
        
        return "my-bookings";
    }
    
    // View Ticket
    @GetMapping("/view-ticket")
    public String viewTicket(@RequestParam(value = "bookingId") int bookingId, 
                            HttpSession session, 
                            Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        
        try {
            Booking booking = bookingService.getBookingById(bookingId);
            
            // Verify this booking belongs to the logged-in user
            if (booking.getUserId() != user.getUserId()) {
                model.addAttribute("error", "Unauthorized access to booking.");
                return "error";
            }
            
            // Get show and seat details
            Show show = bookingService.getShowById(booking.getShowId());
            List<String> seatLabels = bookingService.getSeatLabelsForBooking(bookingId);
            
            model.addAttribute("ticketId", booking.getTicketNumber());
            model.addAttribute("bookingId", booking.getBookingId());
            model.addAttribute("username", user.getFullName());
            model.addAttribute("movieName", show.getMovieName());
            model.addAttribute("theatreName", show.getTheatreName());
            model.addAttribute("showTime", show.getShowTime().toString());
            model.addAttribute("date", show.getShowDate().toString());
            model.addAttribute("selectedSeats", String.join(", ", seatLabels));
            model.addAttribute("totalPrice", booking.getTotalAmount());
            model.addAttribute("bookingDate", new SimpleDateFormat("yyyy-MM-dd").format(booking.getBookingDate()));
            
            return "ticket";
            
        } catch (Exception e) {
            System.err.println("Error loading ticket: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("error", "Unable to load ticket details.");
            return "error";
        }
    }
    
    // Cancel Booking
    @GetMapping("/cancel-booking")
    public String cancelBooking(@RequestParam(value = "bookingId") int bookingId, 
                               HttpSession session, 
                               Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        
        try {
            Booking booking = bookingService.getBookingById(bookingId);
            
            // Verify this booking belongs to the logged-in user
            if (booking.getUserId() != user.getUserId()) {
                model.addAttribute("error", "Unauthorized access.");
                return "error";
            }
            
            // Cancel the booking
            boolean cancelled = bookingService.cancelBooking(bookingId);
            
            if (cancelled) {
                model.addAttribute("success", "Booking cancelled successfully.");
            } else {
                model.addAttribute("error", "Unable to cancel booking.");
            }
            
        } catch (Exception e) {
            System.err.println("Error cancelling booking: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("error", "Error processing cancellation.");
        }
        
        return "redirect:/my-bookings";
    }
    
    // Logout
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }
    
    // Helper method to get current date
    private String getCurrentDate() {
        return new SimpleDateFormat("yyyy-MM-dd").format(new Date());
    }
}
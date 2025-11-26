# 🎬 Movie Booking System - Project Structure

## Complete Directory Layout

```
movie-booking-system/
│
├── pom.xml                                 # Maven dependencies
│
├── src/
│   └── main/
│       ├── java/
│       │   └── com/
│       │       └── booking/
│       │           └── controller/
│       │               └── BookingController.java    # Main controller with all routes
│       │
│       └── webapp/
│           ├── index.jsp                   # Entry point (redirects to home)
│           │
│           ├── WEB-INF/
│           │   ├── web.xml                 # Deployment descriptor
│           │   ├── dispatcher-servlet.xml  # Spring MVC configuration
│           │   │
│           │   └── views/                  # All JSP pages
│           │       ├── header.jsp          # Reusable header component
│           │       ├── footer.jsp          # Reusable footer component
│           │       ├── home.jsp            # Home page with movie cards
│           │       ├── theatres.jsp        # Theatre and show selection
│           │       ├── seats.jsp           # Seat selection page
│           │       ├── login.jsp           # Login page
│           │       ├── booking-summary.jsp # Booking confirmation
│           │       └── ticket.jsp          # Final ticket generation
│           │
│           └── WEB-INF/
│               ├── css/                    # (Optional) External CSS files
│               ├── js/                     # (Optional) External JavaScript files
│               └── images/                 # (Optional) Static images
│
└── target/                                 # Maven build output (auto-generated)
```

---

## 📋 Page Flow Diagram

```
┌─────────────┐
│  index.jsp  │ (Redirects to /)
└──────┬──────┘
       ↓
┌─────────────────────────────────────────────┐
│  home.jsp (/)                               │
│  - Header with login/logout                 │
│  - Search bar (movie + theatre)             │
│  - Movie cards with "Book Now" button       │
│  - Footer                                   │
└──────────────┬──────────────────────────────┘
               ↓ (Click "Book Now")
┌─────────────────────────────────────────────┐
│  theatres.jsp (/theatres)                   │
│  - Selected movie information               │
│  - Date selector                            │
│  - Location search                          │
│  - List of theatres with shows             │
│  - Show timings as buttons                  │
└──────────────┬──────────────────────────────┘
               ↓ (Select show time)
┌─────────────────────────────────────────────┐
│  seats.jsp (/seats)                         │
│  - Booking info bar                         │
│  - Screen indicator                         │
│  - Seat layout (A-H rows, 1-12 columns)    │
│  - Seat legend (Available/Selected/Booked) │
│  - Live booking summary with price         │
│  - "Proceed to Booking" button             │
└──────────────┬──────────────────────────────┘
               ↓ (Submit selected seats)
               ↓
        ┌──────┴──────┐
        │ Check Login │
        └──────┬──────┘
               │
       ┌───────┴────────┐
       │                │
   NOT LOGGED IN    LOGGED IN
       │                │
       ↓                ↓
┌──────────────┐  ┌─────────────────────────────┐
│ login.jsp    │  │ booking-summary.jsp         │
│ (/login)     │  │ (/booking-summary)          │
│              │  │ - Movie & theatre details   │
│ - Username   │  │ - Show date & time          │
│ - Password   │  │ - Selected seats display    │
│ - Demo mode  │  │ - Price breakdown           │
│              │  │ - Total amount              │
└──────┬───────┘  │ - Confirm & Pay button      │
       │          └──────────┬──────────────────┘
       │ (After login)       ↓ (Confirm booking)
       └─────────────────────┘
                  ↓
┌─────────────────────────────────────────────┐
│  ticket.jsp (/confirm-booking)              │
│  - Success animation                        │
│  - Booking ID                               │
│  - Customer details                         │
│  - Movie, theatre, date, time               │
│  - Seat numbers                             │
│  - Payment summary                          │
│  - QR code placeholder                      │
│  - Print/Download/Share buttons             │
│  - Important instructions                   │
└─────────────────────────────────────────────┘
```

---

## 🔄 Controller Routes

### BookingController.java - All Endpoints

| Method | URL | Description | View |
|--------|-----|-------------|------|
| GET | `/` | Home page with movies | home.jsp |
| GET | `/search` | Search movies by name/theatre | home.jsp |
| GET | `/theatres` | Show theatres for selected movie | theatres.jsp |
| GET | `/seats` | Seat selection for show | seats.jsp |
| POST | `/booking-summary` | Review booking (checks login) | booking-summary.jsp or redirect to login |
| GET | `/login` | Show login page | login.jsp |
| POST | `/login` | Process login | Redirect to home or booking-summary |
| POST | `/confirm-booking` | Confirm and generate ticket | ticket.jsp |
| GET | `/logout` | Logout user | Redirect to home |

---

## 🎨 Key Features

### 1. **No Database Required**
- All data is hardcoded in the controller
- Session management for user login
- In-memory mock data for movies, theatres, and seats

### 2. **Pure Page Navigation**
- Complete flow using only Spring MVC and JSP
- No AJAX calls
- Form submissions and redirects

### 3. **Session Management**
- User login stored in `HttpSession`
- Pending bookings stored in session before login
- After login, redirects back to booking flow

### 4. **Reusable Components**
- `header.jsp` - Navigation bar with login/logout
- `footer.jsp` - Footer with links and info

### 5. **Responsive Design**
- Inline CSS with modern styling
- Mobile-friendly layouts
- Gradient backgrounds and animations

---

## 📦 Mock Data Structure

### Movies (in Controller)
```java
- Movie 1: Inception (Sci-Fi, 148 min, 8.8/10)
- Movie 2: The Dark Knight (Action, 152 min, 9.0/10)
- Movie 3: Interstellar (Sci-Fi, 169 min, 8.7/10)
```

### Theatres (in Controller)
```java
- Theatre 1: PVR Cinemas (Downtown Mall)
  Shows: 10:00 AM, 01:00 PM, 04:00 PM, 07:00 PM, 10:00 PM
  
- Theatre 2: INOX Theatre (City Center)
  Shows: 11:00 AM, 02:00 PM, 05:00 PM, 08:00 PM
  
- Theatre 3: Cinepolis (Metro Mall)
  Shows: 09:00 AM, 12:00 PM, 03:00 PM, 06:00 PM, 09:00 PM
```

### Seats (Dynamically Generated)
```java
- Rows: A to H (8 rows)
- Seats per row: 1 to 12 (12 seats)
- Total seats: 96
- Pre-booked seats: Some seats in rows A & B (randomly)
```

---

## 🚀 How to Run

### 1. Prerequisites
- Java 11 or higher
- Maven 3.6+
- Apache Tomcat 9.0+ or any servlet container

### 2. Build the Project
```bash
mvn clean install
```

### 3. Deploy
- Copy the generated WAR file from `target/` folder
- Deploy to Tomcat `webapps/` directory
- Or run using Maven Tomcat plugin:
```bash
mvn tomcat7:run
```

### 4. Access Application
```
http://localhost:8080/movie-booking-system/
```

---

## 🎯 User Journey Example

1. **Visit Home** → See 3 movie cards
2. **Click "Book Now"** on "Inception"
3. **Select Theatre** → Choose "PVR Cinemas"
4. **Select Show** → Choose "07:00 PM" slot
5. **Select Seats** → Choose seats A5, A6, A7
6. **Login** (if not logged in) → Enter any username/password
7. **Confirm Booking** → Review details and confirm
8. **Get Ticket** → Ticket with booking ID generated

---

## 🎨 Design Highlights

### Color Scheme
- Primary: Purple gradient (#667eea → #764ba2)
- Success: Green (#48bb78)
- Background: Light gray (#f7fafc)
- Text: Dark gray (#2d3748)

### Typography
- Font: Segoe UI
- Headers: 2rem - 2.5rem
- Body: 1rem
- Buttons: 1.1rem

### Components
- Rounded corners (8px - 20px)
- Box shadows for depth
- Hover animations
- Gradient buttons
- Responsive grid layouts

---

## 📝 Important Notes

1. **No DAO/Service Layer**: Since there's no database, no need for DAO or Service classes
2. **Session-based**: Login uses session, no JWT or tokens
3. **Mock Data**: All movies, theatres, and seats are hardcoded
4. **In-line CSS**: All styling is in JSP files for simplicity
5. **No Validation**: Minimal server-side validation (add as needed)

---

## 🔧 Customization Options

### Add More Movies
Edit `getMoviesList()` method in `BookingController.java`

### Add More Theatres
Edit `getTheatresList()` method in `BookingController.java`

### Change Seat Layout
Modify `generateSeats()` method to adjust rows/columns

### Modify Prices
Change `pricePerSeat` in `seats.jsp` and controller

---

## 📂 File Locations Summary

```
✅ pom.xml                                    → Root directory
✅ web.xml                                    → src/main/webapp/WEB-INF/
✅ dispatcher-servlet.xml                     → src/main/webapp/WEB-INF/
✅ BookingController.java                     → src/main/java/com/booking/controller/
✅ index.jsp                                  → src/main/webapp/
✅ All view JSPs (home, theatres, etc.)       → src/main/webapp/WEB-INF/views/
```

---

## ✨ Features Implemented

✅ Home page with movie cards  
✅ Search functionality (UI only)  
✅ Theatre listing with shows  
✅ Date-wise show selection  
✅ Interactive seat selection  
✅ Login/Logout functionality  
✅ Session management  
✅ Booking summary with pricing  
✅ Ticket generation with booking ID  
✅ Print/Download ticket options  
✅ Responsive design  
✅ Header/Footer components  
✅ Animated transitions  

---

## 🎬 Ready to Deploy!

Your complete movie booking system is ready with:
- Pure Spring MVC architecture
- JSP for front-end
- No database dependency
- Complete booking flow
- Modern UI/UX design

**Happy Coding! 🚀**
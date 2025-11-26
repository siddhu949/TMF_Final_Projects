# 🏗️ Movie Booking System - Architecture Overview

## 📐 System Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                         PRESENTATION LAYER                   │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────┐   │
│  │ home.jsp │  │theatres  │  │seats.jsp │  │ login.jsp│   │
│  │          │  │  .jsp    │  │          │  │          │   │
│  └──────────┘  └──────────┘  └──────────┘  └──────────┘   │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────┐   │
│  │booking-  │  │ticket.jsp│  │header.jsp│  │footer.jsp│   │
│  │summary   │  │          │  │          │  │          │   │
│  └──────────┘  └──────────┘  └──────────┘  └──────────┘   │
└────────────────────────┬────────────────────────────────────┘
                         │ HTTP Requests/Responses
                         ↓
┌─────────────────────────────────────────────────────────────┐
│                      CONTROLLER LAYER                        │
│  ┌─────────────────────────────────────────────────────┐   │
│  │           BookingController.java                     │   │
│  │  • Home page routing                                 │   │
│  │  • Search movies                                     │   │
│  │  • Show theatres and times                           │   │
│  │  • Seat selection                                    │   │
│  │  • Login/Logout                                      │   │
│  │  • Booking confirmation                              │   │
│  │  • Ticket generation                                 │   │
│  └─────────────────────────────────────────────────────┘   │
└────────────────────────┬────────────────────────────────────┘
                         │ Method Calls
                         ↓
┌─────────────────────────────────────────────────────────────┐
│                       SERVICE LAYER                          │
│  ┌─────────────────────────────────────────────────────┐   │
│  │            BookingService.java                       │   │
│  │  • Business logic processing                         │   │
│  │  • Data transformation                               │   │
│  │  • Transaction management                            │   │
│  │  • Price calculation                                 │   │
│  │  • Booking validation                                │   │
│  └─────────────────────────────────────────────────────┘   │
└────────────────────────┬────────────────────────────────────┘
                         │ DAO Method Calls
                         ↓
┌─────────────────────────────────────────────────────────────┐
│                         DAO LAYER                            │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────┐   │
│  │ MovieDAO │  │Theatre   │  │ ShowDAO  │  │ SeatDAO  │   │
│  │   Impl   │  │DAOImpl   │  │   Impl   │  │   Impl   │   │
│  └──────────┘  └──────────┘  └──────────┘  └──────────┘   │
│  ┌──────────┐  ┌──────────┐                                │
│  │ UserDAO  │  │ Booking  │                                │
│  │   Impl   │  │DAOImpl   │                                │
│  └──────────┘  └──────────┘                                │
└────────────────────────┬────────────────────────────────────┘
                         │ JDBC Queries
                         ↓
┌─────────────────────────────────────────────────────────────┐
│                      DATABASE LAYER                          │
│  ┌─────────────────────────────────────────────────────┐   │
│  │              MySQL Database                          │   │
│  │  • users                    • bookings               │   │
│  │  • movies                   • booking_seats          │   │
│  │  • theatres                 • show_seat_status       │   │
│  │  • screens                                           │   │
│  │  • seats                                             │   │
│  │  • shows                                             │   │
│  └─────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────┘
```

---

## 🔄 Request Flow Example: Booking a Movie

```
User Action                    System Processing
─────────────────────────────────────────────────────────────

1. Click "Book Now"     →     BookingController.showTheatres()
   on Movie Card                     ↓
                                BookingService.getTheatresByMovieId()
                                     ↓
                                TheatreDAO.getTheatresByMovieId()
                                     ↓
                              [SQL Query to Database]
                                     ↓
                           Return Theatre List with Shows
                                     ↓
                              Render theatres.jsp

2. Select Show Time     →     BookingController.showSeats()
                                     ↓
                           BookingService.getSeatsForShow()
                                     ↓
                              SeatDAO.getSeatsByShowId()
                                     ↓
                          BookingService.getBookedSeats()
                                     ↓
                              [SQL Queries to Database]
                                     ↓
                           Return Seat Layout + Status
                                     ↓
                              Render seats.jsp

3. Select Seats         →     JavaScript updates UI
                              (No server call yet)

4. Click "Proceed"      →     BookingController.bookingSummary()
                                     ↓
                           Check if User Logged In (Session)
                                     ↓
                              If Not → Redirect to login.jsp
                              If Yes → Continue
                                     ↓
                           BookingService.calculatePriceBreakdown()
                                     ↓
                              [Calculate Prices]
                                     ↓
                         Render booking-summary.jsp

5. Login (if needed)    →     BookingController.login()
                                     ↓
                           BookingService.validateUser()
                                     ↓
                              UserDAO.validateUser()
                                     ↓
                              [SQL Query to Database]
                                     ↓
                           Return User Object + Store in Session
                                     ↓
                        Redirect back to booking-summary

6. Confirm Booking      →     BookingController.confirmBooking()
                                     ↓
                           BookingService.createBooking()
                              (Transaction Starts)
                                     ↓
                           1. Calculate Final Amount
                           2. Generate Ticket Number
                           3. Insert into bookings table
                           4. Insert into booking_seats table
                           5. Update show_seat_status table
                              (Transaction Commits)
                                     ↓
                              [Multiple SQL Inserts/Updates]
                                     ↓
                           Return Booking Object
                                     ↓
                              Render ticket.jsp
```

---

## 📦 Component Responsibilities

### 1. **Presentation Layer (JSP)**
- **Purpose**: Display data and capture user input
- **Responsibilities**:
  - Render HTML with dynamic data
  - Handle form submissions
  - Client-side validation (JavaScript)
  - UI/UX interactions
- **Files**: All JSP files in `/WEB-INF/views/`

### 2. **Controller Layer**
- **Purpose**: Handle HTTP requests and route to appropriate services
- **Responsibilities**:
  - Route mapping (@GetMapping, @PostMapping)
  - Request parameter extraction
  - Session management
  - Model data preparation
  - View selection
- **Files**: `BookingController.java`

### 3. **Service Layer**
- **Purpose**: Business logic and orchestration
- **Responsibilities**:
  - Coordinate multiple DAO operations
  - Transaction management (@Transactional)
  - Business rules implementation
  - Data transformation
  - Complex calculations
- **Files**: `BookingService.java`

### 4. **DAO Layer**
- **Purpose**: Data access and persistence
- **Responsibilities**:
  - CRUD operations
  - SQL query execution
  - ResultSet mapping to objects
  - Database connection management
- **Files**: All DAO interfaces and implementations

### 5. **Model Layer**
- **Purpose**: Data representation
- **Responsibilities**:
  - Entity definitions
  - Data encapsulation
  - Getters/Setters
- **Files**: All model classes (User, Movie, Theatre, etc.)

### 6. **Database Layer**
- **Purpose**: Data storage and retrieval
- **Responsibilities**:
  - Data persistence
  - Referential integrity
  - Indexing for performance
  - Transaction support
- **Files**: MySQL tables

---

## 🔐 Security Considerations

### Current Implementation
1. **Session Management**: User authentication stored in HttpSession
2. **Login Check**: Redirects to login if not authenticated
3. **SQL Injection Prevention**: Using PreparedStatements
4. **Input Validation**: Basic validation in controller

### Recommended Enhancements
1. **Password Encryption**: Use BCrypt for password hashing
2. **CSRF Protection**: Add CSRF tokens to forms
3. **XSS Prevention**: Sanitize user inputs
4. **HTTPS**: Use SSL/TLS for secure communication
5. **Rate Limiting**: Prevent brute force attacks
6. **Session Timeout**: Auto logout after inactivity

---

## 🎯 Design Patterns Used

### 1. **MVC (Model-View-Controller)**
- **Model**: Entity classes (User, Movie, etc.)
- **View**: JSP files
- **Controller**: BookingController

### 2. **DAO (Data Access Object)**
- Separate data access logic from business logic
- Interfaces define contracts
- Implementations handle database operations

### 3. **Service Layer Pattern**
- Centralizes business logic
- Coordinates multiple DAOs
- Manages transactions

### 4. **Dependency Injection**
- Spring's @Autowired for loose coupling
- Easy to test and maintain

### 5. **Repository Pattern**
- DAO implementations act as repositories
- Abstract database details from service layer

---

## 📊 Database Design Principles

### Normalization
- **3NF (Third Normal Form)** achieved
- No redundant data
- Proper relationships with foreign keys

### Relationships
- **One-to-Many**: User → Bookings, Theatre → Screens
- **Many-to-One**: Shows → Movies, Shows → Screens
- **Many-to-Many**: Bookings ↔ Seats (via booking_seats)

### Constraints
- **Primary Keys**: Auto-increment for all tables
- **Foreign Keys**: Maintain referential integrity
- **Unique Keys**: Prevent duplicates (username, email, ticket_number)
- **Check Constraints**: Data validation at DB level

---

## 🚀 Performance Optimizations

### Current Optimizations
1. **Connection Pooling**: Apache DBCP2
2. **Indexes**: On frequently queried columns
3. **Prepared Statements**: Query optimization
4. **Lazy Loading**: Only fetch required data

### Recommended Optimizations
1. **Caching**: Redis for frequently accessed data
2. **Query Optimization**: Analyze and optimize slow queries
3. **Database Partitioning**: For large datasets
4. **CDN**: For static resources
5. **Load Balancing**: For high traffic

---

## 🧪 Testing Strategy

### Unit Testing
- Test individual DAO methods
- Test service layer business logic
- Mock dependencies

### Integration Testing
- Test controller endpoints
- Test database transactions
- Test complete workflows

### End-to-End Testing
- Test complete user journeys
- Test different browsers
- Test edge cases

---

## 📈 Scalability Considerations

### Horizontal Scaling
- Multiple application servers
- Load balancer distribution
- Session replication

### Vertical Scaling
- Increase server resources
- Database optimization
- Index tuning

### Database Scaling
- Master-Slave replication
- Read replicas
- Sharding for large data

---

## 🔧 Configuration Management

### Environment-Specific Configs
```
Development:  localhost:3306
Testing:      test-db:3306
Production:   prod-db:3306
```

### Externalized Configuration
- Database credentials in properties file
- Environment variables for sensitive data
- Spring profiles for different environments

---

## 📝 API Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | / | Home page with movies |
| GET | /search | Search movies |
| GET | /theatres | Show theatres and times |
| GET | /seats | Seat selection page |
| POST | /booking-summary | Booking summary |
| GET | /login | Login page |
| POST | /login | Process login |
| POST | /confirm-booking | Confirm and create booking |
| GET | /my-bookings | User booking history |
| GET | /logout | Logout user |

---

## 🎬 Conclusion

This architecture provides:
- ✅ Clear separation of concerns
- ✅ Scalable and maintainable code
- ✅ Database-driven dynamic content
- ✅ Complete booking workflow
- ✅ User authentication and session management
- ✅ Transaction support for data integrity

**Ready for deployment and further enhancements!** 🚀
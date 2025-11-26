# 🎬 Movie Booking System - Complete Setup Guide

## 📋 Prerequisites

1. **Java Development Kit (JDK) 11 or higher**
   - Download from: https://www.oracle.com/java/technologies/javase-downloads.html
   - Verify: `java -version`

2. **Apache Maven 3.6+**
   - Download from: https://maven.apache.org/download.cgi
   - Verify: `mvn -version`

3. **MySQL Server 8.0+**
   - Download from: https://dev.mysql.com/downloads/mysql/
   - Verify: `mysql --version`

4. **Apache Tomcat 9.0+**
   - Download from: https://tomcat.apache.org/download-90.cgi

5. **IDE (Optional but Recommended)**
   - IntelliJ IDEA / Eclipse / VS Code

---

## 🗂️ Project Structure

```
movie-booking-system/
│
├── pom.xml
├── src/
│   └── main/
│       ├── java/
│       │   └── com/
│       │       └── booking/
│       │           ├── controller/
│       │           │   └── BookingController.java
│       │           ├── dao/
│       │           │   ├── MovieDAO.java
│       │           │   ├── TheatreDAO.java
│       │           │   ├── ShowDAO.java
│       │           │   ├── SeatDAO.java
│       │           │   ├── UserDAO.java
│       │           │   ├── BookingDAO.java
│       │           │   └── impl/
│       │           │       ├── MovieDAOImpl.java
│       │           │       ├── TheatreDAOImpl.java
│       │           │       ├── ShowDAOImpl.java
│       │           │       ├── SeatDAOImpl.java
│       │           │       ├── UserDAOImpl.java
│       │           │       └── BookingDAOImpl.java
│       │           ├── model/
│       │           │   ├── User.java
│       │           │   ├── Movie.java
│       │           │   ├── Theatre.java
│       │           │   ├── Screen.java
│       │           │   ├── Seat.java
│       │           │   ├── Show.java
│       │           │   └── Booking.java
│       │           └── service/
│       │               └── BookingService.java
│       │
│       └── webapp/
│           ├── index.jsp
│           └── WEB-INF/
│               ├── web.xml
│               ├── dispatcher-servlet.xml
│               └── views/
│                   ├── header.jsp
│                   ├── footer.jsp
│                   ├── home.jsp
│                   ├── theatres.jsp
│                   ├── seats.jsp
│                   ├── login.jsp
│                   ├── booking-summary.jsp
│                   └── ticket.jsp
```

---

## 🔧 Step-by-Step Installation

### Step 1: Database Setup

1. **Start MySQL Server**
   ```bash
   # Windows
   net start MySQL80
   
   # Mac/Linux
   sudo service mysql start
   ```

2. **Login to MySQL**
   ```bash
   mysql -u root -p
   ```

3. **Create Database**
   ```sql
   CREATE DATABASE movie_booking_db;
   USE movie_booking_db;
   ```

4. **Run the SQL Schema**
   - Copy the entire content from `database_schema.sql`
   - Execute it in MySQL Workbench or command line
   ```bash
   mysql -u root -p movie_booking_db < database_schema.sql
   ```

5. **Verify Tables Created**
   ```sql
   SHOW TABLES;
   -- Should show: users, movies, theatres, screens, seats, shows, bookings, booking_seats, show_seat_status
   
   SELECT COUNT(*) FROM movies;
   -- Should return 5 (sample movies inserted)
   ```

---

### Step 2: Configure Database Connection

1. **Update dispatcher-servlet.xml**
   - Open `src/main/webapp/WEB-INF/dispatcher-servlet.xml`
   - Update database credentials:
   ```xml
   <bean id="dataSource" class="org.apache.commons.dbcp2.BasicDataSource" destroy-method="close">
       <property name="driverClassName" value="com.mysql.cj.jdbc.Driver"/>
       <property name="url" value="jdbc:mysql://localhost:3306/movie_booking_db?useSSL=false&amp;serverTimezone=UTC"/>
       <property name="username" value="YOUR_MYSQL_USERNAME"/>
       <property name="password" value="YOUR_MYSQL_PASSWORD"/>
   </bean>
   ```

---

### Step 3: Build the Project

1. **Navigate to project directory**
   ```bash
   cd movie-booking-system
   ```

2. **Clean and build with Maven**
   ```bash
   mvn clean install
   ```

3. **Verify WAR file created**
   ```bash
   ls target/
   # Should see: movie-booking-system-1.0-SNAPSHOT.war
   ```

---

### Step 4: Deploy to Tomcat

#### Option A: Manual Deployment

1. **Copy WAR file to Tomcat**
   ```bash
   cp target/movie-booking-system-1.0-SNAPSHOT.war /path/to/tomcat/webapps/
   ```

2. **Start Tomcat**
   ```bash
   # Windows
   cd C:\path\to\tomcat\bin
   startup.bat
   
   # Mac/Linux
   cd /path/to/tomcat/bin
   ./startup.sh
   ```

3. **Access Application**
   ```
   http://localhost:8080/movie-booking-system-1.0-SNAPSHOT/
   ```

#### Option B: Maven Tomcat Plugin

1. **Add plugin to pom.xml** (if not already present)
   ```xml
   <plugin>
       <groupId>org.apache.tomcat.maven</groupId>
       <artifactId>tomcat7-maven-plugin</artifactId>
       <version>2.2</version>
       <configuration>
           <port>8080</port>
           <path>/booking</path>
       </configuration>
   </plugin>
   ```

2. **Run with Maven**
   ```bash
   mvn tomcat7:run
   ```

3. **Access Application**
   ```
   http://localhost:8080/booking/
   ```

---

### Step 5: Test the Application

1. **Home Page**
   - Visit: `http://localhost:8080/movie-booking-system/`
   - Should see 5 movies displayed

2. **Test Login**
   - Username: `john_doe`
   - Password: `password123`
   
   OR
   
   - Username: `jane_smith`
   - Password: `password456`

3. **Complete Booking Flow**
   - Select a movie (e.g., "Inception")
   - Choose a theatre and show time
   - Select seats
   - Login if not logged in
   - Confirm booking
   - View ticket

---

## 🎯 Application Features

### ✅ Implemented Features

1. **User Management**
   - Login with database validation
   - User registration (optional)
   - Session management

2. **Movie Browsing**
   - View all active movies
   - Search movies by name, genre, language
   - Movie details display

3. **Theatre & Show Selection**
   - View theatres showing selected movie
   - Filter by date
   - See available show times

4. **Seat Selection**
   - Interactive seat layout
   - Real-time availability
   - Different seat types (Standard/Premium)
   - Dynamic pricing

5. **Booking Process**
   - Login check before booking
   - Price calculation (ticket + convenience fee + GST)
   - Booking confirmation
   - Ticket generation with unique ID

6. **Ticket Management**
   - View booking details
   - Print ticket option
   - Download/Share functionality

---

## 🔑 Default Credentials

### Database Users (Pre-inserted)

| Username | Password | Email | Full Name |
|----------|----------|-------|-----------|
| john_doe | password123 | john@example.com | John Doe |
| jane_smith | password456 | jane@example.com | Jane Smith |

### Sample Movies (Pre-inserted)

1. Inception (Sci-Fi, 148 min, 8.8/10)
2. The Dark Knight (Action, 152 min, 9.0/10)
3. Interstellar (Sci-Fi, 169 min, 8.7/10)
4. Avengers Endgame (Action, 181 min, 8.4/10)
5. Parasite (Thriller, 132 min, 8.6/10)

### Sample Theatres (Pre-inserted)

1. PVR Cinemas - Downtown Mall, Mumbai
2. INOX Theatre - City Center, Mumbai
3. Cinepolis - Metro Mall, Mumbai

---

## 🐛 Troubleshooting

### Issue 1: Database Connection Failed

**Error:** `Cannot create PoolableConnectionFactory`

**Solution:**
- Verify MySQL is running: `sudo service mysql status`
- Check database credentials in `dispatcher-servlet.xml`
- Ensure database `movie_booking_db` exists
- Test connection: `mysql -u root -p movie_booking_db`

### Issue 2: Tables Not Found

**Error:** `Table 'movie_booking_db.movies' doesn't exist`

**Solution:**
- Run the SQL schema again
- Verify tables: `SHOW TABLES;`
- Check if you're using the correct database: `SELECT DATABASE();`

### Issue 3: No Movies Displayed

**Solution:**
- Check if sample data was inserted
- Query: `SELECT * FROM movies;`
- If empty, run the INSERT statements from schema

### Issue 4: Port Already in Use

**Error:** `Address already in use: 8080`

**Solution:**
- Change Tomcat port in `server.xml` or Maven plugin
- Or kill process using port 8080:
  ```bash
  # Windows
  netstat -ano | findstr :8080
  taskkill /PID <PID> /F
  
  # Mac/Linux
  lsof -ti:8080 | xargs kill -9
  ```

### Issue 5: 404 Error

**Solution:**
- Check WAR file deployed correctly
- Verify URL matches context path
- Check Tomcat logs: `catalina.out` or `localhost.log`

---

## 📊 Database Schema Overview

### Key Tables

1. **users** - User accounts
2. **movies** - Movie catalog
3. **theatres** - Theatre locations
4. **screens** - Theatre screens
5. **seats** - Seat layout per screen
6. **shows** - Movie shows with timing
7. **bookings** - Booking records
8. **booking_seats** - Seats booked per booking
9. **show_seat_status** - Real-time seat availability

### Relationships

```
users (1) ─── (N) bookings
movies (1) ─── (N) shows
theatres (1) ─── (N) screens
screens (1) ─── (N) seats
screens (1) ─── (N) shows
shows (1) ─── (N) bookings
shows (1) ─── (N) show_seat_status
seats (1) ─── (N) show_seat_status
```

---

## 🚀 Next Steps / Enhancements

1. **Add User Registration Page**
2. **Implement Password Encryption (BCrypt)**
3. **Add Payment Gateway Integration**
4. **Email Ticket Confirmation**
5. **Admin Panel for Managing Movies/Theatres**
6. **Booking History Page**
7. **Cancel Booking Functionality**
8. **Add Movie Images/Posters**
9. **Mobile Responsive Design**
10. **Add Reviews and Ratings**

---

## 📞 Support

For issues or questions:
- Check database connection
- Verify all tables exist
- Review Tomcat logs
- Ensure Maven build successful

**Happy Booking! 🎬🍿**
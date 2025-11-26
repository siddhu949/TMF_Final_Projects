package com.booking.model;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class User {
    private int userId;
    private String username;
    private String password;
    private String email;
    private String fullName;
    private String phoneNumber;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    
}

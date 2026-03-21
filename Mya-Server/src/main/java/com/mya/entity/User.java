package com.mya.entity;

import jakarta.persistence.*;
import lombok.*;

@Getter
@Entity
@Table(name = "users")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    int UserNo;
}

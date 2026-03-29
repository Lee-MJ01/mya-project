package com.mya.entity;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "schedules")
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
@Builder
public class Schedule {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    private User user;

    @Column(nullable = false)
    private String title;

    private String content;

    @Column(nullable = false)
    private LocalDateTime startTime;

    @Column(nullable = false)
    private LocalDateTime endTime;

    private String locationName;

    private Double latitude;

    private Double longitude;

    @Enumerated(EnumType.STRING)
    private ScheduleStatus status;

    private LocalDateTime createdAt;

    @PrePersist
    public void prePersist() {
        this.status = this.status == null ? ScheduleStatus.UPCOMING : this.status;
        this.createdAt = LocalDateTime.now();
    }
}

enum ScheduleStatus {
    UPCOMING, ONGOING, COMPLETED, CANCELLED
}
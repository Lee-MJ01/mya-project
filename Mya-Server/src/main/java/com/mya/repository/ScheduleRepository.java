package com.mya.repository;

import com.mya.entity.Schedule;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface ScheduleRepository extends JpaRepository<Schedule, Long> {
    // 특정 유저의 모든 일정 조회
    List<Schedule> findByUserId(Long userId);

    // 특정 시간대 사이의 일정 조회 (알림 엔진용)
    List<Schedule> findByStartTimeBetween(java.time.LocalDateTime start, java.time.LocalDateTime end);
}
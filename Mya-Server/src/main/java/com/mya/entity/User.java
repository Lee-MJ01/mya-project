package com.mya.entity;

import jakarta.persistence.*;
import lombok.*;
import org.springframework.data.annotation.CreatedDate;

import java.time.LocalDateTime;

@Entity
@Table(name = "users")
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
@Builder
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // --- 개인 정보 ---
    @Column(nullable = false, unique = true)
    private String email;

    @Column(nullable = false)
    private String password;

    @Column(nullable = false)
    private String nickname;

    @Column(nullable = false, unique = true)
    private String phoneNumber;

    // --- 인증 상태 ---
    private boolean isEmailVerified;
    private boolean isSmsVerified;

    // --- 주소 정보 (지도 API 연동용) ---
    private String address;        // 전체 주소 문자열
    private Double latitude;       // 위도
    private Double longitude;      // 경도

    // --- 먀비서 핵심 데이터 ---
    private Integer avgPrepTime;   // 평균 외출 준비 시간 (분 단위)

    // --- 약관 및 기기 권한 동의 여부 ---
    private boolean termsAgreed;     // 필수 약관 동의
    private boolean locationPermitted; // 위치 권한 허용
    private boolean recordPermitted;   // 음성 녹음(비서 호출) 권한 허용

    // --- 메타데이터 ---
    @CreatedDate
    private LocalDateTime createdAt;
}

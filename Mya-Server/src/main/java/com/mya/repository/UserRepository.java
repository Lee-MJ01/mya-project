package com.mya.repository;

import com.mya.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    // 중복 가입 방지를 위한 쿼리 메서드
    boolean existsByEmail(String email);
    boolean existsByPhoneNumber(String phoneNumber);

    // 로그인 등을 위한 이메일 조회
    Optional<User> findByEmail(String email);
}
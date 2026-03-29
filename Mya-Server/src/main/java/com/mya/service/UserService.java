package com.mya.service;

import com.mya.dto.request.UserLoginRequest;
import com.mya.dto.request.UserSignUpRequest;
import com.mya.entity.User;
import com.mya.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional(readOnly = true)
@RequiredArgsConstructor
public class UserService {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    @Transactional
    public Long signUp(UserSignUpRequest request) {
        // 1. 중복 검사 (Email)
        if (userRepository.existsByEmail(request.getEmail())) {
            throw new IllegalArgumentException("이미 존재하는 이메일입니다.");
        }

        // 2. 중복 검사 (Phone)
        if (userRepository.existsByPhoneNumber(request.getPhoneNumber())) {
            throw new IllegalArgumentException("이미 등록된 전화번호입니다.");
        }

        // 3. DTO -> Entity 변환 및 저장
        // (주의: 실제 서비스에서는 비밀번호 암호화 로직이 여기에 들어가야 함)
        User user = User.builder()
                .email(request.getEmail())
                .password(passwordEncoder.encode(request.getPassword())) // 암호화 적용
                .nickname(request.getNickname())
                .phoneNumber(request.getPhoneNumber())
                .address(request.getAddress())
                .latitude(request.getLatitude())
                .longitude(request.getLongitude())
                .avgPrepTime(request.getAvgPrepTime())
                .termsAgreed(request.isTermsAgreed())
                .build();

        return userRepository.save(user).getId();
    }


    public String login(UserLoginRequest request) {
        User user = userRepository.findByEmail(request.getEmail())
                .orElseThrow(() -> new IllegalArgumentException("가입되지 않은 이메일입니다."));

        if (!passwordEncoder.matches(request.getPassword(), user.getPassword())) {
            throw new IllegalArgumentException("비밀번호가 일치하지 않습니다.");
        }

        // 여기서 토큰을 발행해서 반환해야 함 (우선은 성공 메시지 반환)
        return "SUCCESS_TOKEN_MOCK";
    }
}
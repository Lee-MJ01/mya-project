package com.mya.dto.request;

import jakarta.validation.constraints.*;
import lombok.*;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserSignUpRequest {

    @Email(message = "유효한 이메일 형식이 아닙니다.")
    @NotBlank(message = "이메일은 필수 입력 항목입니다.")
    private String email;

    @NotBlank(message = "비밀번호는 필수 입력 항목입니다.")
    @Size(min = 8, message = "비밀번호는 최소 8자 이상이어야 합니다.")
    private String password;

    @NotBlank(message = "닉네임은 필수 입력 항목입니다.")
    private String nickname;

    @NotBlank(message = "전화번호는 필수 입력 항목입니다.")
    private String phoneNumber;

    private String address;
    private Double latitude;
    private Double longitude;
    private Integer avgPrepTime;

    @AssertTrue(message = "약관 동의는 필수입니다.")
    private boolean termsAgreed;
}
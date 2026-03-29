package com.mya.controller;

import com.mya.dto.request.UserSignUpRequest;
import com.mya.service.UserService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/users")
@RequiredArgsConstructor
public class UserController {

    private final UserService userService;

    @PostMapping("/signup")
    public ResponseEntity<Long> signUp(@Valid @RequestBody UserSignUpRequest request) {
        Long userId = userService.signUp(request);
        return ResponseEntity.ok(userId);
    }
}
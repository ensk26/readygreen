package com.ddubucks.readygreen.model.member;

import com.ddubucks.readygreen.model.BaseEntity;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

@Entity
@Table(name = "member")
@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Member extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(nullable = false, unique = true)
    private String email;

    @Column(nullable = false)
    private String nickname;

    private String profileImg;

    private LocalDate birth;

    @Column(nullable = false)
    private String socialId;

    @Column(nullable = false)
    @Enumerated(EnumType.STRING)
    private SocialType socialType;

    private int point;

    @Column(nullable = false)
    @Enumerated(EnumType.STRING)
    private Role role;
}
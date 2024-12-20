package com.ddubucks.readygreen.config;

import io.swagger.v3.oas.models.Components;
import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;
import io.swagger.v3.oas.models.security.SecurityRequirement;
import io.swagger.v3.oas.models.security.SecurityScheme;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springdoc.core.models.GroupedOpenApi;

@Configuration
public class SwaggerConfig {

    @Bean
    public OpenAPI openAPI() {
        return new OpenAPI()
                .components(new Components()
                        .addSecuritySchemes("bearerAuth",
                                new SecurityScheme()
                                        .type(SecurityScheme.Type.HTTP)
                                        .scheme("bearer")
                                        .bearerFormat("JWT")
                                        .in(SecurityScheme.In.HEADER)
                                        .name("Authorization")
                        )
                )
                .addSecurityItem(new SecurityRequirement().addList("bearerAuth"))
                .info(apiInfo());
    }

    private Info apiInfo() {
        return new Info()
                .title("ReadyGreen Swagger")
                .description("언제그린 프로젝트 Swagger")
                .version("1.0.0");
    }
    @Bean
    public GroupedOpenApi adminFeedbackApi() {
        return GroupedOpenApi.builder()
                .group("관리자")
                .pathsToMatch("/admin/**")
                .build();
    }

    @Bean
    public GroupedOpenApi feedbackApi() {
        return GroupedOpenApi.builder()
                .group("건의함")
                .pathsToMatch("/feedback/**")
                .build();
    }

    @Bean
    public GroupedOpenApi healthCheckApi() {
        return GroupedOpenApi.builder()
                .group("헬스체크")
                .pathsToMatch("/health/**")
                .build();
    }

    @Bean
    public GroupedOpenApi redisApi() {
        return GroupedOpenApi.builder()
                .group("redis")
                .pathsToMatch("/redis/**")
                .build();
    }

    @Bean
    public GroupedOpenApi mainApi() {
        return GroupedOpenApi.builder()
                .group("메인")
                .pathsToMatch("/main/**")
                .build();
    }
    @Bean
    public GroupedOpenApi linkApi() {
        return GroupedOpenApi.builder()
                .group("워치연동")
                .pathsToMatch("/link/**")
                .build();
    }

    @Bean
    public GroupedOpenApi mapApi() {
        return GroupedOpenApi.builder()
                .group("지도")
                .pathsToMatch("/map/**")
                .build();
    }

    @Bean
    public GroupedOpenApi memberApi() {
        return GroupedOpenApi.builder()
                .group("멤버")
                .pathsToMatch("/auth/**")
                .build();
    }

    @Bean
    public GroupedOpenApi noticeApi() {
        return GroupedOpenApi.builder()
                .group("공지사항")
                .pathsToMatch("/notice/**")
                .build();
    }

    @Bean
    public GroupedOpenApi pointApi() {
        return GroupedOpenApi.builder()
                .group("포인트")
                .pathsToMatch("/point/**")
                .build();
    }
    @Bean
    public GroupedOpenApi FcmApi(){
        return GroupedOpenApi.builder()
                .group("FCM")
                .pathsToMatch("/fcm/**")
                .build();
    }
    @Bean
    public GroupedOpenApi BadgeApi(){
        return GroupedOpenApi.builder()
                .group("badge")
                .pathsToMatch("/badge/**")
                .build();
    }
    @Bean
    public GroupedOpenApi ReportApi(){
        return GroupedOpenApi.builder()
                .group("제보")
                .pathsToMatch("/report/**")
                .build();
    }

    @Bean
    public GroupedOpenApi PlaceApi(){
        return GroupedOpenApi.builder()
                .group("장소")
                .pathsToMatch("/place/**")
                .build();
    }
    @Bean
    public GroupedOpenApi QuestionApi() {
        return GroupedOpenApi.builder()
                .group("질문")
                .pathsToMatch("/question/**")
                .build();
    }
    @Bean
    public GroupedOpenApi placeApi() {
        return GroupedOpenApi.builder()
                .group("장소 추천")
                .pathsToMatch("/place/**")
                .build();
    }
}

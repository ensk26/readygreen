package com.ddubucks.readygreen.controller;

import com.ddubucks.readygreen.dto.ChatGPTRequestDTO;
import com.ddubucks.readygreen.dto.ChatGPTResponseDTO;
import com.ddubucks.readygreen.dto.WeatherResponseDTO;
import com.ddubucks.readygreen.model.member.Member;
import com.ddubucks.readygreen.service.MainService;
import com.ddubucks.readygreen.service.MemberService;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/main")
public class MainController {

    private final MainService mainService;
    private final MemberService memberService;

    @Autowired
    private RestTemplate template;


    @GetMapping("/weather")
    public ResponseEntity<?> weather(@RequestParam("x")String x, @RequestParam("y") String y) throws Exception {
//        List<WeatherResponse> list = mainService.weather(x,y);
//        if(list.isEmpty())return new ResponseEntity<>("날씨 조회 실패", HttpStatus.NOT_FOUND);
//        return ResponseEntity.ok(list);
        List<WeatherResponseDTO> list = mainService.weathers(x,y);
        if(list.isEmpty())return new ResponseEntity<>("날씨 조회 실패", HttpStatus.NOT_FOUND);
        return ResponseEntity.ok(list);
    }

    @GetMapping
    public ResponseEntity<?> mainPage(@RequestParam("x") String x, @RequestParam("y") String y) throws Exception {
        WeatherResponseDTO weatherResponseDTO = mainService.weather(x, y);
        return ResponseEntity.ok(weatherResponseDTO);
    }

    @GetMapping("/fortune")
    public ResponseEntity<?> chat(@AuthenticationPrincipal UserDetails userDetails){
        Member member = memberService.getMemberInfo(userDetails.getUsername());
        if (member.getBirth() == null) {
            return ResponseEntity.badRequest().body("생일 정보가 없습니다.");
        }
        // 프롬프트 생성
        String prompt = String.format("당신의 이름은 %s이고, 생일은 %s입니다. 오늘의 운세를 알려주세요. 오늘의 운세는 일, 사랑, 건강, 금전, 행운의 숫자 등 다양한 측면을 포함하여 상세하게 설명해 주세요. 최대 글자수 200자 이내로 해주세요",
                member.getNickname(), member.getBirth().toString());
        String apiURL = "https://api.openai.com/v1/chat/completions";
        String model = "gpt-4-turbo";
        ChatGPTRequestDTO request = new ChatGPTRequestDTO(model, prompt);
        System.out.println(apiURL+" "+request);
        ChatGPTResponseDTO chatGPTResponse =  template.postForObject(apiURL, request, ChatGPTResponseDTO.class);
        return ResponseEntity.ok(chatGPTResponse.getChoices().get(0).getMessage().getContent());
    }
}

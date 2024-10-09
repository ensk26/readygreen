package com.ddubucks.readygreen.dto;

import lombok.Data;

import java.util.ArrayList;
import java.util.List;

@Data
public class ChatGPTRequestDTO {
    private String model;
    private List<MessageDTO> messages;

    public ChatGPTRequestDTO(String model, String prompt) {
        this.model = model;
        this.messages =  new ArrayList<>();
        this.messages.add(new MessageDTO("user", prompt));
    }
}
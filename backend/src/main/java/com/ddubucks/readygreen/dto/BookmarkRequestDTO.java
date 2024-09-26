package com.ddubucks.readygreen.dto;

import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class BookmarkRequestDTO {
    @NotNull(message = "blinkerIDs cannot null")
    private String name;

    @NotNull(message = "blinkerIDs cannot null")
    private String destinationName;

    @NotNull(message = "latitude cannot null")
    private double latitude;

    @NotNull(message = "longitude cannot null")
    private double longitude;
}

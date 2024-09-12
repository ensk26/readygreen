package com.ddubucks.readygreen.presentation.screen

import SearchViewModel
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import com.airbnb.lottie.compose.*
import androidx.compose.ui.unit.dp
import androidx.wear.compose.material.Text
import com.ddubucks.readygreen.R
import com.ddubucks.readygreen.presentation.theme.Black
import h3Style
import pStyle


@Composable
fun SearchScreen(viewModel: SearchViewModel) {
    val composition by rememberLottieComposition(LottieCompositionSpec.RawRes(R.raw.search_mike))

    LaunchedEffect(Unit) {
        // TODO 음성인식 결과 가정 실제 결과로 변경
        val voiceInput = "말한 결과"
        viewModel.updateVoiceResult(voiceInput)
    }

    Column(
        modifier = Modifier
            .fillMaxSize()
            .background(Black),
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.Center
    ) {
        Text(
            text = "음성검색",
            color = Color.Yellow,
            style = h3Style,
            modifier = Modifier.padding(bottom = 14.dp, top = 16.dp)
        )
        Text(
            text = "목적지를 말씀해주세요",
            style = pStyle,
            modifier = Modifier.padding(bottom = 5.dp)
        )
        LottieAnimation(
            composition = composition,
            iterations = LottieConstants.IterateForever,
            modifier = Modifier
                .size(140.dp)
                .fillMaxWidth()
        )
    }
}
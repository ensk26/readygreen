package com.ddubucks.readygreen.presentation.activity

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.lifecycle.viewmodel.compose.viewModel
import androidx.navigation.NavType
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import androidx.navigation.navArgument
import com.ddubucks.readygreen.BuildConfig
import com.ddubucks.readygreen.core.service.LocationService
import com.ddubucks.readygreen.presentation.screen.BookmarkScreen
import com.ddubucks.readygreen.presentation.screen.InitialScreen
import com.ddubucks.readygreen.presentation.screen.MainScreen
import com.ddubucks.readygreen.presentation.screen.MapScreen
import com.ddubucks.readygreen.presentation.screen.NavigationScreen
import com.ddubucks.readygreen.presentation.screen.SearchResultScreen
import com.ddubucks.readygreen.presentation.screen.SearchScreen
import com.ddubucks.readygreen.presentation.theme.ReadyGreenTheme
import com.ddubucks.readygreen.presentation.viewmodel.SearchViewModel
import com.google.android.gms.location.LocationServices

// MainActivity.kt

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        setContent {
            ReadyGreenTheme {
                val navController = rememberNavController()
                val searchViewModel: SearchViewModel = viewModel()
                val fusedLocationClient = LocationServices.getFusedLocationProviderClient(this)

                NavHost(navController = navController, startDestination = "mainScreen") {
                    // MainScreen 설정
                    composable("mainScreen") { MainScreen(navController) }
                    // BookmarkScreen
                    composable("bookmarkScreen") { BookmarkScreen() }
                    // SearchScreen
                    composable("searchScreen") {
                        SearchScreen(
                            navController = navController,
                            fusedLocationClient = fusedLocationClient,
                            viewModel = searchViewModel,
                            apiKey = BuildConfig.MAPS_API_KEY
                        )
                    }

                    // 검색 결과를 넘겨주는 SearchResultScreen
                    composable("searchResultScreen") {
                        SearchResultScreen(navController = navController)
                    }

                    // MapScreen
                    composable("mapScreen") {
                        MapScreen(
                            locationService = LocationService(),
                            fusedLocationClient = fusedLocationClient
                        )
                    }
                    // NavigationScreen
                    composable(
                        "navigationScreen/{name}/{lat}/{lng}",
                        arguments = listOf(
                            navArgument("name") { type = NavType.StringType },
                            navArgument("lat") { type = NavType.FloatType },
                            navArgument("lng") { type = NavType.FloatType }
                        )
                    ) { backStackEntry ->
                        val name = backStackEntry.arguments?.getString("name")
                        val lat = backStackEntry.arguments?.getFloat("lat")
                        val lng = backStackEntry.arguments?.getFloat("lng")
                        NavigationScreen(name = name, lat = lat, lng = lng)
                    }
                    // Authentication
                    composable("initialScreen") { InitialScreen() }
                }
            }
        }
    }
}

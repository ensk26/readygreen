package com.ddubucks.readygreen.presentation.viewmodel

import android.util.Log
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.ddubucks.readygreen.presentation.retrofit.GoogleRestClient
import com.ddubucks.readygreen.presentation.retrofit.search.SearchApi
import com.ddubucks.readygreen.presentation.retrofit.search.SearchCandidate
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.launch

class SearchViewModel : ViewModel() {

    private val searchService: SearchApi = GoogleRestClient.create(SearchApi::class.java)

    private val _searchResults = MutableStateFlow<List<SearchCandidate>>(emptyList())
    val searchResults: StateFlow<List<SearchCandidate>> = _searchResults

    private val _searchStatus = MutableStateFlow<String>("")
    val searchStatus: StateFlow<String> = _searchStatus

    fun clearSearchResults() {
        _searchResults.value = emptyList()
        _searchStatus.value = ""
        Log.d("SearchViewModel", "검색 결과 초기화됨")
    }

    fun searchPlaces(
        latitude: Double,
        longitude: Double,
        keyword: String,
        apiKey: String
    ) {
        viewModelScope.launch {
            try {
                val location = "$latitude,$longitude"
                val response = searchService.searchPlaces(
                    location = location,
                    keyword = keyword,
                    apiKey = apiKey
                )
                if (response.results?.isNotEmpty() == true) {
                    _searchResults.value = response.results.take(5)
                    _searchStatus.value = "RESULTS_FOUND"
                    Log.d("SearchViewModel", "검색 결과: ${response.results.map { it.name }}")
                } else {
                    _searchResults.value = emptyList()
                    _searchStatus.value = "ZERO_RESULTS"
                    Log.d("SearchViewModel", "검색 결과 없음")
                }
                Log.d("SearchViewModel", "API 응답: $response")
            } catch (e: Exception) {
                Log.e("SearchViewModel", "API 호출 실패", e)
            }
        }
    }
}

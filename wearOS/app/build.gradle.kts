import java.util.Properties

val properties = Properties()
properties.load(project.rootProject.file("local.properties").inputStream())

plugins {
    alias(libs.plugins.android.application)
    alias(libs.plugins.jetbrains.kotlin.android)
    id("com.google.gms.google-services")
    id("kotlin-parcelize")
}

android {
    namespace = "com.ddubucks.readygreen"
    compileSdk = 34

    defaultConfig {
        applicationId = "com.ddubucks.readygreen"
        minSdk = 30
        targetSdk = 34
        versionCode = 1
        versionName = "1.0"
        vectorDrawables {
            useSupportLibrary = true
        }

        // Google Maps API
        manifestPlaceholders["MAPS_API_KEY"] = properties.getProperty("MAPS_API_KEY")
        buildConfigField("String", "MAPS_API_KEY", "\"${properties.getProperty("MAPS_API_KEY")}\"")
    }

    applicationVariants.configureEach {
        val appName = "readygreen"
        this.outputs.configureEach {
            buildOutputs.forEach {
                val archivesBaseName = "${appName}.apk"
                val variantOutputImpl = this as com.android.build.gradle.internal.api.BaseVariantOutputImpl
                variantOutputImpl.outputFileName =  archivesBaseName
            }
        }
    }

    buildTypes {
        release {
            isMinifyEnabled = false
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
    }
    kotlinOptions {
        jvmTarget = "1.8"
    }
    buildFeatures {
        compose = true
        buildConfig = true
    }
    composeOptions {
        kotlinCompilerExtensionVersion = "1.5.1"
    }
    packaging {
        resources {
            excludes += "/META-INF/{AL2.0,LGPL2.1}"
        }
    }
}

dependencies {
    // Wearable
    implementation(libs.play.services.wearable)
    implementation(platform(libs.compose.bom))
    implementation(libs.ui)
    implementation(libs.ui.tooling.preview)
    implementation(libs.compose.material)
    implementation(libs.compose.foundation)
    implementation(libs.activity.compose)
    implementation(libs.core.splashscreen)
    implementation(libs.tiles)
    implementation(libs.tiles.material)
    implementation(libs.horologist.compose.tools)
    implementation(libs.horologist.tiles)
    implementation(libs.watchface.complications.data.source.ktx)
    implementation(libs.navigation.compose)
    implementation(libs.material3.android)
    implementation(libs.firebase.messaging.ktx)
    implementation(libs.runtime.livedata)

    // Compose BOM
    val composeBom = platform("androidx.compose:compose-bom:2024.06.00")
    implementation(composeBom)

    debugImplementation("androidx.compose.ui:ui-tooling")
    implementation("androidx.compose.ui:ui-tooling-preview")
    implementation("androidx.compose.material:material:<latest_version>")


    // Wear OS에서 데이터 레이어 (모바일 연결)
    implementation("com.google.android.gms:play-services-wearable:18.0.0")
    implementation("org.jetbrains.kotlinx:kotlinx-coroutines-play-services:1.6.0")

    // Wear OS 관련 Jetpack Compose
    implementation("androidx.wear.compose:compose-material:1.1.0")
    implementation("androidx.wear.compose:compose-foundation:1.1.0")
    implementation("androidx.wear.compose:compose-navigation:1.1.0")

    // Firebase
    implementation(platform("com.google.firebase:firebase-bom:33.3.0"))
    implementation("com.google.firebase:firebase-analytics")
    implementation("com.google.firebase:firebase-auth")
    implementation("com.google.firebase:firebase-firestore")
    implementation("com.google.firebase:firebase-messaging-ktx")

    // 네트워크 통신 (Retrofit 사용)
    implementation("com.squareup.retrofit2:retrofit:2.9.0")
    implementation("com.squareup.retrofit2:converter-gson:2.9.0")
    implementation("com.squareup.okhttp3:logging-interceptor:4.9.0")

    // Lottie
    implementation("com.airbnb.android:lottie-compose:6.0.0")

    // Google Maps API
    implementation("com.google.maps.android:maps-compose:4.4.1")
    implementation("com.google.maps.android:maps-compose-utils:4.3.3")
    implementation("com.google.maps.android:maps-compose-widgets:4.3.3")
    implementation("com.google.android.gms:play-services-location:21.0.1")

    // Android 테스트
    androidTestImplementation(platform(libs.compose.bom))
    androidTestImplementation(libs.ui.test.junit4)
    debugImplementation(libs.ui.tooling)
    debugImplementation(libs.ui.test.manifest)
}

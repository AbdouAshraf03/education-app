package com.example.mr_samy_elmalah

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.os.Bundle
import android.view.WindowManager
import java.io.File
import android.provider.Settings

class MainActivity: FlutterActivity() {
    private val CHANNEL = "security_channel"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "isRooted" -> result.success(isRooted())
                "isDeveloperMode" -> result.success(isDeveloperModeEnabled())
                else -> result.notImplemented()
            }
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // Prevent screenshots/screen recording
        window.setFlags(WindowManager.LayoutParams.FLAG_SECURE, WindowManager.LayoutParams.FLAG_SECURE)
    }

    private fun isRooted(): Boolean {
        // Check common root indicators
        val buildTags = android.os.Build.TAGS
        if (buildTags != null && buildTags.contains("test-keys")) {
            return true
        }

        // Check for Superuser.apk
        val paths = arrayOf(
            "/system/app/Superuser.apk",
            "/sbin/su",
            "/system/bin/su",
            "/system/xbin/su",
            "/data/local/xbin/su",
            "/data/local/bin/su",
            "/system/sd/xbin/su",
            "/system/bin/failsafe/su",
            "/data/local/su"
        )

        for (path in paths) {
            if (File(path).exists()) return true
        }

        // Check if 'su' command exists
        try {
            Runtime.getRuntime().exec("su")
            return true
        } catch (e: Exception) {
            return false
        }
    }

    private fun isDeveloperModeEnabled(): Boolean {
        return try {
            Settings.Global.getInt(
                applicationContext.contentResolver,
                Settings.Global.DEVELOPMENT_SETTINGS_ENABLED, 
                0
            ) != 0
        } catch (e: Exception) {
            false
        }
    }
}
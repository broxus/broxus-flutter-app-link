package com.broxus.app.links.broxus_app_links

import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.Handler
import android.os.Looper
import android.util.Log
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterPluginBinding
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.NewIntentListener

/** BroxusAppLinksPlugin */
open class BroxusAppLinksPlugin : FlutterPlugin, MethodCallHandler, ActivityAware,
    NewIntentListener {

    companion object {
        private const val METHOD_CHANNEL = "broxus_app_links/methods"

        private var currentMethodChannel: MethodChannel? = null
    }

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        currentMethodChannel = MethodChannel(flutterPluginBinding.binaryMessenger, METHOD_CHANNEL)
        currentMethodChannel?.setMethodCallHandler(this)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        binding.addOnNewIntentListener(this)
        val mainActivity = binding.activity
        val intent = mainActivity.intent
        dispatchUri(intent)
    }

    override fun onDetachedFromActivityForConfigChanges() {}

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        binding.addOnNewIntentListener(this)
    }

    override fun onDetachedFromActivity() {}


    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        currentMethodChannel?.setMethodCallHandler(null)
        currentMethodChannel = null
    }

    override fun onNewIntent(intent: Intent): Boolean {
        dispatchUri(intent)
        return true
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            else -> result.notImplemented()
        }
    }

    private fun parseLinkIntent(intent: Intent): Uri? {

        if (Intent.ACTION_VIEW != intent.action) {
            return null
        }

        // Получаем данные из Intent
        val dataUri: Uri? = intent.data

        if (dataUri?.scheme == null) {
            return null
        }

        if (dataUri.scheme == "http" || dataUri.scheme == "https") {
            return dataUri
        }

        return null
    }

    private fun dispatchUri(intent: Intent) {
        val uri: Uri? = parseLinkIntent(intent)

        if (uri != null) {
            try {
                Handler(Looper.getMainLooper()).post {
                    currentMethodChannel?.invokeMethod(
                        "newUri", hashMapOf(
                            "uriStr" to uri.toString()
                        )
                    )
                }
            } catch (t: Throwable) {
                Log.w("BroxusAppLinksPalugin", "BroxusAppLinksPlugin Error: ${t.message}")
            }
        }
    }
}

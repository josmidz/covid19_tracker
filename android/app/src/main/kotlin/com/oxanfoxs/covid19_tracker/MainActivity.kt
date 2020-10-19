package com.oxanfoxs.covid19_tracker

import io.flutter.embedding.android.FlutterActivity
import com.tekartik.sqflite.SqflitePlugin

class MainActivity: FlutterActivity() {
    SqflitePlugin.registerWith(registrarFor("com.tekartik.sqflite.SqflitePlugin")
}

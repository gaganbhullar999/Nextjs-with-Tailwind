package com.testn.meds
import android.widget.Toast

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    val METHOD_CHANNCEL = "PAYUMONEY"
    lateinit var channel: MethodChannel


    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, METHOD_CHANNCEL)

        channel.setMethodCallHandler { call, result ->

            if(call.method=="callPayu"){
                val data = callPayu(this@MainActivity)

                result.success(data)
            }

        }

    }


    fun printToast():String {
       return "testtttttt"

    }

    fun printReal(){
        Toast.makeText(this@MainActivity,"hiiiiiiii",Toast.LENGTH_SHORT).show()
    }


    fun callPayu(activity: MainActivity){






    }

}

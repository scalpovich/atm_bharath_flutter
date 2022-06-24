package com.kun.moneytransfer

import android.annotation.TargetApi
import android.os.Build
import android.provider.Settings
import android.util.Base64
import android.util.Log
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.UnsupportedEncodingException
import java.security.Key
import java.security.spec.KeySpec
import javax.crypto.Cipher
import javax.crypto.SecretKeyFactory
import javax.crypto.spec.IvParameterSpec
import javax.crypto.spec.PBEKeySpec
import javax.crypto.spec.SecretKeySpec

class MainActivity : FlutterActivity() {

    var responseBody: String = ""
    var requestBody: String = ""
    var key: String = ""
    private val IV = "T3CH10G!C@MNYTRF"
//    var deviceId: String ="";

    //    private static String PASSWORD = "V222201B01844CUS001";
    val SALT = "InOknmq1C+NCZSi0a9NjIQ=="

    private val CHANNEL = "flutter.native/PlatformHelper"//Name as per your convenience…!!!

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            key = call.argument<String>("key").toString()
            if (call.hasArgument("response")){
                responseBody = call.argument<String>("response").toString()
                if (call.method == "DecryptResponse") {
                    val response = decodeAndDecrypt(responseBody, key)
                    result.success(response)
                }
            }
            if (call.hasArgument("request")){
                requestBody = call.argument<String>("request").toString()
                if (call.method == "EncryptRequest") {
                    val request = encryptAndEncode(requestBody, key)
                    result.success(request)
                }
            }
            if (call.method == "SerialNumber"){
                val deviceId = getDeviceId()
                result.success(deviceId)
            }
// Note: this method is invoked on the main thread.
// TODO

        }
    }

    @JvmName("getDeviceId1")
    fun getDeviceId(): String? {
        var deviceId: String?
        if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.Q)
        {
            if (Settings.Secure.getString(
                            this.contentResolver,
                            Settings.Secure.ANDROID_ID) == "") {
                deviceId = ""
            } else {
                deviceId = Settings.Secure.getString(
                        this.contentResolver,
                        Settings.Secure.ANDROID_ID)
//                deviceId  == Settings.Secure.getString(this.contentResolver, Settings.Secure.ANDROID_ID))
            }
        } else
        {
            if (getSerialNumber().equals("")) {
               deviceId = ""
            } else {
                deviceId = getSerialNumber().toString()
//                textInputEditTextEmail.setEnabled(Device.getSerialNumber().equals(Device.getSerialNumber()))
            }
        }
        return deviceId
    }

    fun getSerialNumber(): String? {
        var serialNumber: String?
        try {
            val c = Class.forName("android.os.SystemProperties")
            val get = c.getMethod("get", String::class.java)

            // (?) Lenovo Tab (https://stackoverflow.com/a/34819027/1276306)
            serialNumber = get.invoke(c, "gsm.sn1") as String
            if (serialNumber == "") // Samsung Galaxy S5 (SM-G900F) : 6.0.1
            // Samsung Galaxy S6 (SM-G920F) : 7.0
            // Samsung Galaxy Tab 4 (SM-T530) : 5.0.2
            // (?) Samsung Galaxy Tab 2 (https://gist.github.com/jgold6/f46b1c049a1ee94fdb52)
                serialNumber = get.invoke(c, "ril.serialnumber") as String
            if (serialNumber == "") // Archos 133 Oxygen : 6.0.1
            // Google Nexus 5 : 6.0.1
            // Hannspree HANNSPAD 13.3" TITAN 2 (HSG1351) : 5.1.1
            // Honor 5C (NEM-L51) : 7.0
            // Honor 5X (KIW-L21) : 6.0.1
            // Huawei M2 (M2-801w) : 5.1.1
            // (?) HTC Nexus One : 2.3.4 (https://gist.github.com/tetsu-koba/992373)
                serialNumber = get.invoke(c, "ro.serialno") as String
            if (serialNumber == "") // (?) Samsung Galaxy Tab 3 (https://stackoverflow.com/a/27274950/1276306)
                serialNumber = get.invoke(c, "sys.serialnumber") as String
            if (serialNumber == "") // Archos 133 Oxygen : 6.0.1
            // Hannspree HANNSPAD 13.3" TITAN 2 (HSG1351) : 5.1.1
            // Honor 9 Lite (LLD-L31) : 8.0
            // Xiaomi Mi 8 (M1803E1A) : 8.1.0
                serialNumber = Build.SERIAL

            // If none of the methods above worked
            if (serialNumber == Build.UNKNOWN) serialNumber = null
        } catch (e: Exception) {
            e.printStackTrace()
            serialNumber = null
        }
        return serialNumber
    }

    @TargetApi(Build.VERSION_CODES.FROYO)
    fun encryptAndEncode(raw: String, pwd: String): String {
        try {
            val c = getCipher(Cipher.ENCRYPT_MODE, pwd)
            val encryptedVal = c.doFinal(getBytes(raw))
            val s = Base64.encodeToString(encryptedVal, Base64.NO_WRAP)
            return s
            Log.d(":::","s")
        } catch (t: Throwable) {
            throw RuntimeException(t)
        }

    }

    @TargetApi(Build.VERSION_CODES.FROYO)
    @Throws(Exception::class)
    fun decodeAndDecrypt(encrypted: String, pwd: String): String {
        try {
            val decodedValue = Base64.decode(encrypted.toByteArray(), Base64.NO_WRAP)
            val c = getCipher(Cipher.DECRYPT_MODE, pwd)
            val decValue = c.doFinal(decodedValue)
            return String(decValue)
            Log.d(":::", "decValue.toString()")
        }catch (t: Throwable) {
            throw RuntimeException(t)
        }
    }

//    @Throws(UnsupportedEncodingException::class)
//    private fun getString(bytes: ByteArray): String {
//        return String(bytes, "UTF-8")
//    }

    @Throws(UnsupportedEncodingException::class)
    private fun getBytes(str: String): ByteArray {
        return str.toByteArray(charset("UTF-8"))
    }

    @Throws(Exception::class)
    private fun getCipher(mode: Int, pwd: String): Cipher {
        val c = Cipher.getInstance("AES/CBC/PKCS5Padding")
        val iv = getBytes(IV)
        c.init(mode, generateKey(pwd), IvParameterSpec(iv))
        return c
    }

    @Throws(Exception::class)
    private fun generateKey(pwd: String): Key {
        val factory = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA1")
        val password = pwd.toCharArray()
        Log.e("pwd", "-----$pwd")
        val salt = getBytes(SALT)
        val spec: KeySpec = PBEKeySpec(password, salt, 65536, 128)
        val tmp = factory.generateSecret(spec)
        val encoded = tmp.encoded
        return SecretKeySpec(encoded, "AES")
    }

    companion object
}

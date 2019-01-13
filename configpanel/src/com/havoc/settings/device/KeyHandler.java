/*
* Copyright (C) 2018 Syberia Project
* Copyright (C) 2019 ksrt12
*
* This program is free software: you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation, either version 2 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with this program. If not, see <http://www.gnu.org/licenses/>.
*
*/
package com.havoc.settings.device;

import android.content.Context;
import android.content.Intent;
import android.content.res.Resources;
import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.hardware.SensorManager;
import android.os.Handler;
import android.os.PowerManager;
import android.os.PowerManager.WakeLock;
import android.util.Log;
import android.provider.Settings;
import android.view.KeyEvent;
import android.os.UserHandle;

import com.android.internal.os.DeviceKeyHandler;
import com.android.internal.util.ArrayUtils;

public class KeyHandler implements DeviceKeyHandler {

    private static final String TAG = KeyHandler.class.getSimpleName();
    private static final boolean DEBUG = false;

    private static final int KEY_HOME = 102;
    private static final int KEY_HOME_VIRTUAL = 96;
    private static final int KEY_BACK = 158;
    private static final int KEY_RECENTS = 139;

    private static final int[] sDisabledKeys = new int[]{
        KEY_HOME,
        KEY_HOME_VIRTUAL,
        KEY_BACK,
        KEY_RECENTS
    };

    protected final Context mContext;
    private final PowerManager mPowerManager;
    private static boolean mButtonDisabled;
    private Handler mHandler = new Handler();
    private SensorManager mSensorManager;
    private Sensor mProximitySensor;
    WakeLock mProximityWakeLock;
    private int mProximityTimeOut;
    private boolean mProximityWakeSupported;

    public KeyHandler(Context context) {
        if (DEBUG) Log.i(TAG, "KeyHandler called");
        mContext = context;
        mPowerManager = context.getSystemService(PowerManager.class);

        final Resources resources = mContext.getResources();
        mProximityTimeOut = resources.getInteger(
                com.android.internal.R.integer.config_proximityCheckTimeout);
        mProximityWakeSupported = resources.getBoolean(
                com.android.internal.R.bool.config_proximityCheckOnWake);

        if (mProximityWakeSupported) {
            mSensorManager = context.getSystemService(SensorManager.class);
            mProximitySensor = mSensorManager.getDefaultSensor(Sensor.TYPE_PROXIMITY);
            mProximityWakeLock = mPowerManager.newWakeLock(PowerManager.PARTIAL_WAKE_LOCK,
                    "ProximityWakeLock");
        }
    }

    public KeyEvent handleKeyEvent(KeyEvent event) {
        if (DEBUG) Log.i(TAG, "handleKeyEvent called - scancode=" + event.getScanCode() + " - keyevent=" + event.getAction());
        return event;
    }

    public static void setButtonSetting(Context context) {
        if (DEBUG) Log.i(TAG, "SetButtonDisable called" );
        mButtonDisabled = Settings.Secure.getIntForUser(
                context.getContentResolver(), Settings.Secure.HARDWARE_KEYS_DISABLE, 0,
                UserHandle.USER_CURRENT) == 1;
        if (DEBUG) Log.i(TAG, "setButtonDisable=" + mButtonDisabled);
    }

}

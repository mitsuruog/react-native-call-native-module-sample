package com.reactnativecallnativemodule;

import android.content.Intent;
import android.util.Log;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;

import java.util.Calendar;

public class CalendarManagerModule extends ReactContextBaseJavaModule {

    public CalendarManagerModule(ReactApplicationContext reactApplicationContext) {
        super(reactApplicationContext);
    }

    @Override
    public String getName() {
        return "CalendarManager";
    }

    @ReactMethod
    public void addEvent(
            String name,
            String location,
            Integer date
    ) {
        Log.d("DEBUG", String.format("--------- Pretending to create an event %s at %s from %s", name, location, date));

        Calendar calendar = Calendar.getInstance();
        Intent intent = new Intent(Intent.ACTION_EDIT);
        intent.setType("vnd.android.cursor.item/event");
        intent.putExtra("beginTime", calendar.getTimeInMillis());
        intent.putExtra("endTime", calendar.getTimeInMillis() + 60 * 60 * 1000);
        intent.putExtra("title", name);
        intent.putExtra("eventLocation", location);

        // TODO やり方すぐわからないので一旦保留
        // startActivity(intent);
    }
}

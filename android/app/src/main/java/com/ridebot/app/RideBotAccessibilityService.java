package com.ridebot.app;

import android.accessibilityservice.AccessibilityService;
import android.accessibilityservice.AccessibilityServiceInfo;
import android.view.accessibility.AccessibilityEvent;
import android.view.accessibility.AccessibilityNodeInfo;
import android.os.Handler;
import android.util.Log;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;


public class RideBotAccessibilityService extends AccessibilityService {


    private static final String TAG = "RideBot";

    private Handler handler = new Handler();

    private boolean autoAccept = true;


    private final List<String> rideApps = Arrays.asList(
            "rapido",
            "olacabs",
            "uber"
    );


    private final List<String> acceptWords = Arrays.asList(
            "accept",
            "accept ride",
            "accept now",
            "confirm",
            "book"
    );



    @Override
    public void onServiceConnected() {

        super.onServiceConnected();


        AccessibilityServiceInfo info =
                new AccessibilityServiceInfo();


        info.eventTypes =
                AccessibilityEvent.TYPE_WINDOW_STATE_CHANGED |
                AccessibilityEvent.TYPE_WINDOW_CONTENT_CHANGED;


        info.feedbackType =
                AccessibilityServiceInfo.FEEDBACK_GENERIC;


        info.flags =
                AccessibilityServiceInfo.FLAG_REPORT_VIEW_IDS |
                AccessibilityServiceInfo.FLAG_RETRIEVE_INTERACTIVE_WINDOWS;


        setServiceInfo(info);


        Log.d(TAG,"RideBot Accessibility Started");

    }



    @Override
    public void onAccessibilityEvent(AccessibilityEvent event) {


        if(!autoAccept)
            return;



        String packageName =
                event.getPackageName()!=null ?
                event.getPackageName().toString()
                :"";


        if(!isRideApp(packageName))
            return;



        AccessibilityNodeInfo root =
                getRootInActiveWindow();


        if(root==null)
            return;



        String screenText =
                readScreen(root);



        Log.d(TAG,
                "Screen Data : "+screenText);



        if(checkRide(screenText))
        {

            handler.postDelayed(
                    new Runnable() {

                @Override
                public void run() {

                    boolean decision =
checkWithFilter(
screenText
);


if(decision){

clickAccept(root);

}

                }

            },1500);

        }

    }




    private boolean isRideApp(String pkg)
    {

        pkg=pkg.toLowerCase();


        for(String app:rideApps)
        {

            if(pkg.contains(app))
                return true;

        }


        return false;

    }





    private String readScreen(
            AccessibilityNodeInfo node)
    {


        StringBuilder builder =
                new StringBuilder();



        if(node.getText()!=null)
        {

            builder.append(
                    node.getText()
            );

        }



        for(int i=0;i<node.getChildCount();i++)
        {

            AccessibilityNodeInfo child =
                    node.getChild(i);


            if(child!=null)
            {

                builder.append(
                        readScreen(child)
                );

            }

        }


        return builder.toString()
                .toLowerCase();

    }






    private boolean checkRide(
            String text)
    {


        boolean hasPrice =
                text.contains("₹")
                ||
                text.contains("rs");


        boolean hasDistance =
                text.contains("km");


        return hasPrice && hasDistance;


    }






    private void clickAccept(
            AccessibilityNodeInfo node)
    {


        if(node==null)
            return;



        if(node.getText()!=null)
        {

            String value =
                    node.getText()
                    .toString()
                    .toLowerCase();



            for(String word:acceptWords)
            {

                if(value.contains(word))
                {

                    node.performAction(
                       AccessibilityNodeInfo.ACTION_CLICK
                    );


                    Log.d(TAG,
                    "Ride Accepted");

                    return;

                }

            }

        }





        for(int i=0;i<node.getChildCount();i++)
        {

            clickAccept(
                node.getChild(i)
            );

        }


    }





    @Override
    public void onInterrupt()
    {

        Log.d(TAG,
        "Service Interrupted");

    }



            }

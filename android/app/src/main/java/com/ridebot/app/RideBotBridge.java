package com.ridebot.app;

import io.flutter.plugin.common.MethodChannel;
import io.flutter.embedding.engine.FlutterEngine;


public class RideBotBridge {


    public static MethodChannel channel;



    public static void setup(
            FlutterEngine engine
    ){

        channel =
        new MethodChannel(
            engine.getDartExecutor()
            .getBinaryMessenger(),
            "ridebot_channel"
        );

    }



    public static void sendRideData(
            double fare,
            double distance,
            String pickup
    ){

        if(channel!=null){

            channel.invokeMethod(
                "ride_detected",
                new Object[]{
                    fare,
                    distance,
                    pickup
                }
            );

        }

    }


}

package com.ridebot.app;

import java.util.regex.Matcher;
import java.util.regex.Pattern;


public class RideExtractor {



    public static double extractFare(
            String text
    ){

        double fare = 0;


        Pattern pattern =
        Pattern.compile(
        "(₹|rs|inr)?\\s?([0-9]+)"
        );


        Matcher matcher =
        pattern.matcher(
            text.toLowerCase()
        );


        while(matcher.find()){


            String value =
            matcher.group(2);



            try{

                double amount =
                Double.parseDouble(value);



                if(amount >= 20 &&
                   amount <= 5000)
                {

                    fare = amount;
                    break;

                }


            }
            catch(Exception e){

            }


        }


        return fare;

    }







    public static double extractDistance(
            String text
    ){

        double km = 0;



        Pattern pattern =
        Pattern.compile(
        "([0-9]+(\\.[0-9]+)?)\\s?(km|kms|kilometer)"
        );



        Matcher matcher =
        pattern.matcher(
            text.toLowerCase()
        );



        if(matcher.find()){


            try{


                km =
                Double.parseDouble(
                    matcher.group(1)
                );


            }
            catch(Exception e){


            }


        }



        return km;

    }








    public static String extractPickup(
            String text
    ){

        String lower =
        text.toLowerCase();



        if(lower.contains("pickup"))
        {

            int index =
            lower.indexOf(
                "pickup"
            );


            return text.substring(
                index
            );

        }



        return "Unknown";


    }



}

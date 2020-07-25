//Libraries
#include <Wire.h>
#include <RTClibExtended.h>
#include <LowPower.h>
#include <SPI.h>
#include <SD.h>
//----------------------

//Pins
File dataFile;
RTC_DS3231 rtc;

int SDPin = 4;
int T1Pin = 0;
int T2Pin = 1;
int V1, V2;
float R1 = 10000;
float R2 = 10000;
float logR2_T1, R2_T1, T1, Tc1;
float logR2_T2, R2_T2, T2, Tc2;
float c1 = 1.009249522e-03;
float c2 = 2.378405444e-04;
float c3 = 2.019202697e-07;
//---------------------

//Variables
int NowHour;                  //Interrupt
int NowMinute;                //Interrupt
String dataString = "";       //SdCard
//------------

void setup() {
  SD.begin(4);
  Wire.begin();
  rtc.begin();
  rtc.armAlarm(1, false);
  rtc.clearAlarm(1);
  rtc.alarmInterrupt(1, false);
  rtc.armAlarm(2, false);
  rtc.clearAlarm(2);
  rtc.alarmInterrupt(2, false);
  rtc.writeSqwPinMode(DS3231_OFF);
  Interrupt();
}

void TimeHandler() {}

void TimeFunction(){
  DataLog();
  Interrupt();
}

void DataLog() {
    //Reading Thermistor 1
    V1 = analogRead(T1Pin);
    R2_T1 = R1 * (1023.0 / (float)V1 - 1.0);
    logR2_T1 = log(R2_T1);
    T1 = (1.0 / (c1 + c2*logR2_T1 + c3*logR2_T1*logR2_T1*logR2_T1));
    Tc1 = T1 - 273.15;

    //Reading Thermistor 2
    V2 = analogRead(T2Pin);
    R2_T2 = R2 * (1023.0 / (float)V2 - 1.0);
    logR2_T2 = log(R2_T2);
    T2 = (1.0 / (c1 + c2*logR2_T2 + c3*logR2_T2*logR2_T2*logR2_T2));
    Tc2 = T2 - 273.15;

    DateTime now = rtc.now();
    dataString += String(now.year(), DEC);
    dataString += ",";
    dataString += String(now.month(), DEC);
    dataString += ",";
    dataString += String(now.day(), DEC);
    dataString += ",";
    dataString += String(now.hour(), DEC);
    dataString += ",";
    dataString += String(now.minute(), DEC);
    dataString += ",";
    dataString += String(-Tc1);
    dataString += ",";
    dataString += String(-Tc2);
    
    File dataFile = SD.open("datalog.txt", FILE_WRITE);
    if (dataFile) {
      dataFile.println(dataString);
      dataFile.close();
      dataFile.println();
    }
    dataString = "";
}

void Interrupt() {
  rtc.clearAlarm(1);
  rtc.clearAlarm(2);
  DateTime now = rtc.now();
  NowHour = String(now.hour(), DEC).toInt();
  NowMinute = String(now.minute(), DEC).toInt();
  if (NowMinute <= 10) {
    rtc.setAlarm(ALM1_MATCH_HOURS, 10, NowHour, 0);
    rtc.alarmInterrupt(1, true);
    rtc.setAlarm(ALM2_MATCH_HOURS, 20, NowHour, 0);
    rtc.alarmInterrupt(2, true);
  }
    
  else if (NowMinute > 10 && NowMinute <= 20) {
    rtc.setAlarm(ALM1_MATCH_HOURS, 20, NowHour, 0);
    rtc.alarmInterrupt(1, true);
    rtc.setAlarm(ALM2_MATCH_HOURS, 30, NowHour, 0);
    rtc.alarmInterrupt(2, true);
  }
   
  else if (NowMinute > 20 && NowMinute <= 30) {
    rtc.setAlarm(ALM1_MATCH_HOURS, 30, NowHour, 0);
    rtc.alarmInterrupt(1, true);
    rtc.setAlarm(ALM2_MATCH_HOURS, 40, NowHour, 0);
    rtc.alarmInterrupt(2, true);
  }
    
  else if (NowMinute > 30 && NowMinute <= 40) {
    rtc.setAlarm(ALM1_MATCH_HOURS, 40, NowHour, 0);
    rtc.alarmInterrupt(1, true);
    rtc.setAlarm(ALM2_MATCH_HOURS, 50, NowHour, 0);
    rtc.alarmInterrupt(2, true);
  }
    
  else if (NowMinute > 40 && NowMinute <= 50) {
    if(NowHour < 23){
      rtc.setAlarm(ALM1_MATCH_HOURS, 50, NowHour, 0);
      rtc.alarmInterrupt(1, true);
      rtc.setAlarm(ALM2_MATCH_HOURS, 0, NowHour+1, 0);
      rtc.alarmInterrupt(2, true);
    }
    else if(NowHour >= 23){
      rtc.setAlarm(ALM1_MATCH_HOURS, 50, NowHour, 0);
      rtc.alarmInterrupt(1, true);
      rtc.setAlarm(ALM2_MATCH_HOURS, 0, 0, 0);
      rtc.alarmInterrupt(2, true);
    }
  }
    
  else {
    if(NowHour < 23){
      rtc.setAlarm(ALM1_MATCH_HOURS, 0, NowHour+1, 0);
      rtc.alarmInterrupt(1, true);
      rtc.setAlarm(ALM2_MATCH_HOURS, 10, NowHour+1, 0);
      rtc.alarmInterrupt(2, true);
    }
    else if(NowHour >= 23){
      rtc.setAlarm(ALM1_MATCH_HOURS, 0, 0, 0);
      rtc.alarmInterrupt(1, true);
      rtc.setAlarm(ALM2_MATCH_HOURS, 10, 0, 0);
      rtc.alarmInterrupt(2, true);
    }
  }
}

void loop() {
  attachInterrupt(digitalPinToInterrupt(2), TimeHandler, LOW);
  LowPower.powerDown(SLEEP_FOREVER, ADC_OFF, BOD_OFF);
  detachInterrupt(digitalPinToInterrupt(2));
  TimeFunction();
}

#include <DS1307.h>

DS1307 rtc(A4, A5);
int T1Pin = 0;
int T2Pin = 0;
int V1, V2;
float R1 = 10000;
float R2 = 10000;
float logR2_T1, R2_T1, T1, Tc1;
float logR2_T2, R2_T2, T2, Tc2;
float c1 = 1.009249522e-03, c2 = 2.378405444e-04, c3 = 2.019202697e-07;
 
void setup()
{
  rtc.halt(false);
   
  //As linhas abaixo setam a data e hora do modulo
  //e podem ser comentada apos a primeira utilizacao
  //rtc.setDOW(WEDNESDAY);      //Define o dia da semana
  //rtc.setTime(18, 9, 0);     //Define o horario
  //rtc.setDate(26, 12, 2018);   //Define o dia, mes e ano
   
  //Definicoes do pino SQW/Out
  rtc.setSQWRate(SQW_RATE_1);
  rtc.enableSQW(true);
   
  Serial.begin(9600);
}
 
void loop()
{
  //Mostra as informações no Serial Monitor
  Serial.print("Hora : ");
  Serial.print(rtc.getTimeStr());
  Serial.print(" ");
  Serial.print("Data : ");
  Serial.print(rtc.getDateStr(FORMAT_SHORT));
  Serial.print(" ");
  Serial.println(rtc.getDOWStr(FORMAT_SHORT));
   
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

  Serial.print("T1: "); 
  Serial.print(Tc1);
  Serial.println(" C");   

  Serial.print("T2: "); 
  Serial.print(Tc2);
  Serial.println(" C"); 

  delay(1000);

}

const int    SAMPLE_NUMBER      = 10;
const double BALANCE_RESISTOR   = 9710.0;
const double MAX_ADC            = 1023.0;
const double BETA               = 3974.0;
const double ROOM_TEMP          = 298.15;   // room temperature in Kelvin
const double RESISTOR_ROOM_TEMP = 10000.0;
double currentTemperature = 0;
int thermistorPin = 0;  // Where the ADC samples the resistor divider's output
void setup() 
{ 
  // Set the port speed for serial window messages
  Serial.begin(9600);
}

//===============================================================================
//  Main
//===============================================================================
void loop() 
{
  /* The main loop is pretty simple, it prints what the temperature is in the
     serial window. The heart of the program is within the readThermistor
     function. */
  currentTemperature = readThermistor();
  delay(3000);
  
  /* Here is how you can act upon a temperature that is too hot,
  too cold or just right. */
  if (currentTemperature > 21.0 && currentTemperature < 24.0)
  {
    Serial.print("It is ");
    Serial.print(currentTemperature);
    Serial.println("C. Ahhh, very nice temperature.");
  } 
  else if (currentTemperature >= 24.0)
  {
    Serial.print("It is ");
    Serial.print(currentTemperature);
    Serial.println("C. I feel like a hot tamale!");
  } 
  else
  {
    Serial.print("It is ");
    Serial.print(currentTemperature);
    Serial.println("C. Brrrrrr, it's COLD!");
  }
}

double readThermistor() 
{
  // variables that live in this function
  double rThermistor = 0;            // Holds thermistor resistance value
  double tKelvin     = 0;            // Holds calculated temperature
  double tCelsius    = 0;            // Hold temperature in celsius
  double adcAverage  = 0;            // Holds the average voltage measurement
  int    adcSamples[SAMPLE_NUMBER];  // Array to hold each voltage measurement
  for (int i = 0; i < SAMPLE_NUMBER; i++) 
  {
    adcSamples = analogRead(thermistorPin);  // read from pin and store
    delay(10);        // wait 10 milliseconds
  }
  for (int i = 0; i < SAMPLE_NUMBER; i++) 
  {
    adcAverage += adcSamples;      // add all samples up . . .
  }
  adcAverage /= SAMPLE_NUMBER;        // . . . average it w/ divide
  rThermistor = BALANCE_RESISTOR * ( (MAX_ADC / adcAverage) - 1);
  tKelvin = (BETA * ROOM_TEMP) / 
            (BETA + (ROOM_TEMP * log(rThermistor / RESISTOR_ROOM_TEMP)));
  tCelsius = tKelvin - 273.15;  // convert kelvin to celsius 

  return tCelsius;    // Return the temperature in Celsius
}

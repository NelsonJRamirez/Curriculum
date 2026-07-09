#include "max6675.h"
#include <WiFi.h>
#include <NTPClient.h>
#include <WiFiUdp.h>
#include <Wire.h>
#include "RTClib.h"
#include <HTTPClient.h>

#define TANK1 4//33
#define TANK2 5//34
#define TANK3 6//35
#define I2C_SDA 8
#define I2C_SCL 9

String URL = "http://192.168.74.192/ideonella/php/board_be.php";
const long utcOffsetInSeconds = -4 * 3600; 
WiFiUDP ntpUDP;
NTPClient timeClient(ntpUDP, "do.pool.ntp.org", utcOffsetInSeconds);
char daysOfTheWeek[7][12] = {"Domingo", "Lunes", "Martes", "Miércoles", "Jueves", "Viernes", "Sábado"};
RTC_DS1307 rtc;

const char* ssid = "Campus_ITLA";
const char* password = "";

int ktcSO = 0;//2 
int ktcCS = 20; //3
int ktcCLK = 1; //4

int ktc1SO = 0; //2
int ktc1CS = 21; //5
int ktc1CLK = 1; //4

int tankTwo = 0;
int nSensor = 10; //15

int tankThree = 0;
int nSensor1 = 18; //14

int tankOne = 0;
int nSensor2 = 19; //16

int estadoPumpW = 0; 
int pumpW = 7; //17

bool fTank1 = false; 
bool fTank2 = false; 
bool fTank3 = false; 
 

MAX6675 ktc(ktcCLK, ktcCS, ktcSO);
MAX6675 ktc1(ktc1CLK, ktc1CS, ktc1SO);

void setup(){
  Serial.begin(115200);

  WiFi.begin(ssid, password);
  delay(3000);

  Wire.begin(I2C_SDA, I2C_SCL);

  if (!rtc.begin()) {
    Serial.println("Couldn't find RTC");
    Serial.flush();
  }

  timeClient.begin();
  timeClient.update();

  /*while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.println("WiFi not connected...");
  }
  
  if (WiFi.status() == WL_CONNECTED) {
  Serial.println("WiFi connected");
  DateTime now = timeClient.getEpochTime();
  
  rtc.adjust(DateTime(now.year(), now.month(), now.day(), now.hour(), now.minute(), now.second()));
  }*/

  Serial.print("IP address: ");
  Serial.println(WiFi.localIP());

  pinMode(nSensor, INPUT_PULLUP);
  pinMode(nSensor1, INPUT_PULLUP);
  pinMode(nSensor2, INPUT_PULLUP);
  pinMode(pumpW, OUTPUT);
  pinMode(TANK1, OUTPUT);
  pinMode(TANK2, OUTPUT);
  pinMode(TANK3, OUTPUT); 

  delay(500);
}

// Funciones del programa 

float leerTermocupla(MAX6675 &termocupla) {
  return termocupla.readCelsius();
}

void imprimirTemperaturas() {

  float Temp_exterior_C = leerTermocupla(ktc); 
  float Temp_exterior_F = ktc.readFahrenheit();
  float Temp_interior_C = leerTermocupla(ktc1); 
  float Temp_interior_F = ktc1.readFahrenheit();
  
  Serial.print("Exterior Grados °C = ");
  Serial.print(Temp_exterior_C);
  Serial.print("\t Exterior Grados °F = ");
  Serial.println(Temp_exterior_F);

  Serial.print("Interior Grados °C = ");
  Serial.print(Temp_interior_C);
  Serial.print("\t Interior Grados °F = ");
  Serial.println(Temp_interior_F);
  Serial.println("\n");
}

void mensajeEncendido(){
  
  if (tankOne == HIGH) {
    Serial.println(F("TANK1 State: Vacio"));
    digitalWrite(TANK1, LOW);
    fTank1 = false;
  } else {
    Serial.println(F("TANK1 State: Lleno"));
    digitalWrite(TANK1, HIGH);
    fTank1 = true;
  }

  if (tankTwo == HIGH) {
    Serial.println(F("TANK2 State: Vacio"));
    digitalWrite(TANK2, LOW);
    fTank2 = false;
  } else {
    Serial.println(F("TANK2 State: Lleno"));
    digitalWrite(TANK2, HIGH);
    fTank2 = true;
  }

  if (tankThree == HIGH) {
    Serial.println(F("TANK3 State: Vacio"));
    digitalWrite(TANK3, LOW);
    fTank3 = false;
  } else {
    Serial.println(F("TANK3 State: Lleno"));
    digitalWrite(TANK3, HIGH);
    fTank3 = true;
  }
}

void leerNSensor(){
  tankOne = digitalRead(nSensor2);
  tankTwo = digitalRead(nSensor);
  tankThree = digitalRead(nSensor1);
}

void tiempoHorario(){
 DateTime now = rtc.now();
  Serial.print(" (");
  Serial.print(daysOfTheWeek[now.dayOfTheWeek()]);
  Serial.print(") ");
  Serial.print(now.day(), DEC);
  Serial.print('/');
  Serial.print(now.month(), DEC);
  Serial.print('/');
  Serial.print(now.year(), DEC);
  Serial.print(" ");
  Serial.print(now.hour(), DEC);
  Serial.print(':');
  Serial.print(now.minute(), DEC);
  Serial.print(':');
  Serial.print(now.second(), DEC);
  Serial.println();
}

void estadoPump() {
  digitalWrite(pumpW, estadoPumpW == HIGH ? HIGH : LOW);
}

//Bucle de ejecución
void loop() {
  // Verificar la conexión WiFi
  if (WiFi.status() != WL_CONNECTED) {
    Serial.println("WiFi not connected...");
    delay(10);
    return;
  }

  HTTPClient http;
  http.begin(URL);
  http.addHeader("Content-Type", "application/x-www-form-urlencoded");
  DateTime now = rtc.now();
  tiempoHorario(); 

  //if (now.hour() >= 8 && now.hour() < 16){
    leerNSensor(); 

    if (tankOne == LOW && tankTwo == HIGH && tankThree == HIGH) {
      estadoPumpW = HIGH; 
      estadoPump();
      mensajeEncendido();
      Serial.println(F("Bomba encendida"));
      imprimirTemperaturas();

      // Obtener la fecha y hora actual del RTC
      DateTime now = rtc.now();

      // Envía los datos al servidor
      String postData = "temperatura_EC=" + String(leerTermocupla(ktc)) + "&temperatura_EF=" + String(ktc.readFahrenheit()) + "&temperatura_IC=" + String(leerTermocupla(ktc1)) + "&temperatura_IF=" + String(ktc1.readFahrenheit()) + "&tank1=" + String(fTank1 ? 1:0) + "&tank2=" + String(fTank2 ? 1:0) + "&tank3=" + String(fTank3 ? 1:0) + "&estadoPumpW=" + String(estadoPumpW);

      int httpCode = http.POST(postData);
      String payload = "";
     
  if(httpCode > 0) {
    // file found at server
    if(httpCode == HTTP_CODE_OK) {
      String payload = http.getString();
      Serial.println(payload);
    } else {
      // HTTP header has been send and Server response header has been handled
      Serial.printf("[HTTP] GET... code: %d\n", httpCode);
    }
  } else {
    Serial.printf("[HTTP] GET... failed, error: %s\n", http.errorToString(httpCode).c_str());
  }
  
  http.end();  //Close connection

  Serial.print("URL : "); Serial.println(URL); 
  Serial.print("Data: "); Serial.println(postData);
  Serial.print("httpCode: "); Serial.println(httpCode);
  Serial.print("payload : "); Serial.println(payload);
  Serial.println("--------------------------------------------------");

  } else {
      estadoPumpW = LOW; 
      estadoPump();
      mensajeEncendido();
      Serial.println(F("Bomba apagada"));
      imprimirTemperaturas();

      // Envía los datos al servidor
      String postData = "temperatura_EC=" + String(leerTermocupla(ktc)) + "&temperatura_EF=" + String(ktc.readFahrenheit()) + "&temperatura_IC=" + String(leerTermocupla(ktc1)) + "&temperatura_IF=" + String(ktc1.readFahrenheit()) + "&tank1=" + String(fTank1) + "&tank2=" + String(fTank2) + "&tank3=" + String(fTank3) + "&estadoPumpW=" + String(estadoPumpW);

     int httpCode = http.POST(postData);
      String payload = "";
     
  if(httpCode > 0) {
    // file found at server
    if(httpCode == HTTP_CODE_OK) {
      String payload = http.getString();
      Serial.println(payload);
    } else {
      // HTTP header has been send and Server response header has been handled
      Serial.printf("[HTTP] GET... code: %d\n", httpCode);
    }
  } else {
    Serial.printf("[HTTP] GET... failed, error: %s\n", http.errorToString(httpCode).c_str());
  }
  
  http.end();  //Close connection

  Serial.print("URL : "); Serial.println(URL); 
  Serial.print("Data: "); Serial.println(postData);
  Serial.print("httpCode: "); Serial.println(httpCode);
  Serial.print("payload : "); Serial.println(payload);
  Serial.println("--------------------------------------------------");
    }
  //} 
  //else {
    //estadoPumpW = LOW; 
    //estadoPump();
    //Serial.println(F("Sistema fuera de horario\n"));
    //delay(10000);
  //}

  // Esperar antes de volver a realizar la solicitud HTTP
  delay(500);
}

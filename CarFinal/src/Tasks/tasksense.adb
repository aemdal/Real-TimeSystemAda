With Ada.Real_Time; use Ada.Real_Time;
With Ultrasonic; -- use Ultrasonic;
with WirelessRadio;
with MicroBit.Radio; use MicroBit.Radio;
package body TaskSense is

    task body sense is
      myClock : Time;
      -- making an instance for each distance sensor
      package Ultrasonic1 is new Ultrasonic;
      package Ultrasonic2 is new Ultrasonic;
      package Ultrasonic3 is new Ultrasonic;
      
   begin
      Ultrasonic1.Setup(10,11);
      Ultrasonic2.Setup(5,19);
      Ultrasonic3.Setup(9,8);
      
      WirelessRadio.SetupRadio;
      WirelessRadio.EnableReceiving;
      
      loop
         myClock := Clock; 
         Brain.SetMeasurementSensor1(Integer(Ultrasonic1.Read));
         Brain.SetMeasurementSensor2(Integer(Ultrasonic2.Read));
         Brain.SetMeasurementSensor3(Integer(Ultrasonic3.Read));
         
         while DataReady loop
            Brain.SetRadioSensor(Receive);
         end loop;
            
         delay until myClock + Milliseconds(150);
      end loop;
      
   end sense;

end TaskSense;

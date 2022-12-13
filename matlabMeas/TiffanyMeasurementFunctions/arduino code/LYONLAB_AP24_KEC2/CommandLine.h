
#include <string.h>
#include <stdlib.h>

//this following macro is good for debugging, e.g.  print2("myVar= ", myVar);
#define print2(x,y) (Serial.print(x), Serial.println(y))


#define CR '\r'
#define LF '\n'
#define BS '\b'
#define NULLCHAR '\0'
#define SPACE ' '

#ifndef FUNCTIONS_H_INCLUDED
#define FUNCTIONS_H_INCLUDED
  int setDACvoltage(int channel, double voltage);  // Function prototype, its declaration
  double getDACvoltage(int channel);  // Function prototype, its declaration
#endif



#define COMMAND_BUFFER_LENGTH        25                        //length of serial buffer for incoming commands
char   CommandLine[COMMAND_BUFFER_LENGTH + 1];                 //Read commands into this buffer from Serial.  +1 in length for a termination char

int currentchannel;
double newvoltage;

const char *delimiters = ", \n:";                    //commands can be separated by return, space or comma, or :


/*****************************************************************************

  How to Use CommandLine:
    Create a sketch.  Look below for a sample setup and main loop code and copy and paste it in into the new sketch.

   Create a new tab.  (Use the drop down menu (little triangle) on the far right of the Arduino Editor.
   Name the tab CommandLine.h
   Paste this file into it.

  Test:
     Download the sketch you just created to your Arduino as usual and open the Serial Window.  Typey these commands followed by return:
      add 5, 10
      subtract 10, 5

    Look at the add and subtract commands included and then write your own!


*****************************************************************************
  Here's what's going on under the covers
*****************************************************************************
  Simple and Clear Command Line Interpreter

     This file will allow you to type commands into the Serial Window like,
        add 23,599
        blink 5
        playSong Yesterday

     to your sketch running on the Arduino and execute them.

     Implementation note:  This will use C strings as opposed to String Objects based on the assumption that if you need a commandLine interpreter,
     you are probably short on space too and the String object tends to be space inefficient.

   1)  Simple Protocol
         Commands are words and numbers either space or comma spearated
         The first word is the command, each additional word is an argument
         "\n" terminates each command

   2)  Using the C library routine strtok:
       A command is a word separated by spaces or commas.  A word separated by certain characters (like space or comma) is called a token.
       To get tokens one by one, I use the C lib routing strtok (part of C stdlib.h see below how to include it).
           It's part of C language library <string.h> which you can look up online.  Basically you:
              1) pass it a string (and the delimeters you use, i.e. space and comman) and it will return the first token from the string
              2) on subsequent calls, pass it NULL (instead of the string ptr) and it will continue where it left off with the initial string.
        I've written a couple of basic helper routines:
            readNumber: uses strtok and atoi (atoi: ascii to int, again part of C stdlib.h) to return an integer.
              Note that atoi returns an int and if you are using 1 byte ints like uint8_t you'll have to get the lowByte().
            readWord: returns a ptr to a text word

   4)  DoMyCommand: A list of if-then-elses for each command.  You could make this a case statement if all commands were a single char.
      Using a word is more readable.
          For the purposes of this example we have:
              Add
              Subtract
              nullCommand
*/
/******************sample main loop code ************************************

  #include "CommandLine.h"

  void
  setup() {
  Serial.begin(115200);
  }

  void
  loop() {
  bool received = getCommandLineFromSerialPort(CommandLine);      //global CommandLine is defined in CommandLine.h
  if (received) DoMyCommand(CommandLine);
  }

**********************************************************************************/

/*************************************************************************************************************
     your Command Names Here
*/
const char *addCommandToken       = "add";                     //Modify here
const char *subtractCommandToken  = "sub";                     //Modify here
const char *channelCommandToken = "CH";                        //Used to set channel 
const char *chanreadCommandToken = "CH?";                       //Used to get channel 
const char *voltageCommandToken = "VOLT";                      //Used to set voltage
const char *voltreadCommandToken = "VOLT?";                    //Used to get voltage
const char *testCommandToken = "TEST";
const char *idCommandToken = "*IDN?";                          //Used to identify device

/*************************************************************************************************************
    getCommandLineFromSerialPort()
      Return the string of the next command. Commands are delimited by return"
      Handle BackSpace character
      Make all chars lowercase
*************************************************************************************************************/

bool
getCommandLineFromSerialPort(char * commandLine)
{
  static uint8_t charsRead = 0;                      //note: COMAND_BUFFER_LENGTH must be less than 255 chars long
  //read asynchronously until full command input
  while (Serial.available()) {
    char c = Serial.read();
    switch (c) {
      case CR:      //likely have full command in buffer now, commands are terminated by CR and/or LS
      case LF:
        commandLine[charsRead] = NULLCHAR;       //null terminate our command char array
        if (charsRead > 0)  {
          charsRead = 0;                           //charsRead is static, so have to reset
          //Serial.println(commandLine);
          return true;
        }
        break;
      default:
        // c = tolower(c);
        if (charsRead < COMMAND_BUFFER_LENGTH) {
          commandLine[charsRead++] = c;
        }
        commandLine[charsRead] = NULLCHAR;     //just in case
        break;
    }
  }
  return false;
}


/* ****************************
   readNumber: return a 16bit (for Arduino Uno) signed integer from the command line
   readWord: get a text word from the command line

*/
int readNumber () {
  char * numTextPtr = strtok(NULL, delimiters);         //K&R string.h  pg. 250
  return atoi(numTextPtr);                              //K&R string.h  pg. 251
}

double readFloat () {
  char * numTextPtr = strtok(NULL, delimiters);         //K&R string.h  pg. 250
  return atof(numTextPtr);                              //K&R string.h  pg. 251
}

char * readWord() {
  char * word = strtok(NULL, delimiters);               //K&R string.h  pg. 250
  return word;
}

void
nullCommand(char * ptrToCommandName) {
  print2("Command not found: ", ptrToCommandName);      //see above for macro print2
}


/****************************************************
   Add your commands here
*/

int addCommand() {                                      //Modify here
  int firstOperand = readNumber();
  int secondOperand = readNumber();
  return firstOperand + secondOperand;
}

int subtractCommand() {                                //Modify here
  int firstOperand = readNumber();
  int secondOperand = readNumber();
  return firstOperand - secondOperand;
}

int setchannel() {
  currentchannel = readNumber(); // sets the current channel
  return currentchannel;
}

int getchannel() {
  return currentchannel;
}

int setvoltagecmd() {
  newvoltage = readFloat(); // sets the current channel
  setDACvoltage(currentchannel, newvoltage);
  return newvoltage;
}
double getvoltagecmd() {
  double voltage = getDACvoltage(currentchannel);
  return voltage;
}

int identvoltagecmd() {
  setDACvoltage(1, 1.1);
  setDACvoltage(2, 1.2);
  setDACvoltage(3, 1.3);
  setDACvoltage(4, 1.4);
  setDACvoltage(5, 1.5);
  setDACvoltage(6, 1.6);
  setDACvoltage(7, 1.7);
  setDACvoltage(8, 1.8);
  setDACvoltage(9, 2.1);
  setDACvoltage(10, 2.2);
  setDACvoltage(11, 2.3);
  setDACvoltage(12, 2.4);
  setDACvoltage(13, 2.5);
  setDACvoltage(14, 2.6);
  setDACvoltage(15, 2.7);
  setDACvoltage(16, 2.8);
  setDACvoltage(17, 3.1);
  setDACvoltage(18, 3.2);
  setDACvoltage(19, 3.3);
  setDACvoltage(20, 3.4);
  setDACvoltage(21, 3.5);
  setDACvoltage(22, 3.6);
  setDACvoltage(23, 3.7);
  setDACvoltage(24, 3.8);
  return 1;
}


/****************************************************
   DoMyCommand
*/
bool
DoMyCommand(char * commandLine) {
  //  print2("\nCommand: ", commandLine);
  int result;
  double resultd;

  char * ptrToCommandName = strtok(commandLine, delimiters);
  //  print2("commandName= ", ptrToCommandName);


    // add command
  if (strcmp(ptrToCommandName, addCommandToken) == 0) 
    {                   //Modify here
    result = addCommand();
    print2(">    The sum is = ", result);
    // subtract command
    } 
  else if (strcmp(ptrToCommandName, subtractCommandToken) == 0) 
    {           //Modify here
      result = subtractCommand();                                       //K&R string.h  pg. 251
      print2(">    The difference is = ", result);
    // change channel command
    } 
  else if (strcmp(ptrToCommandName, channelCommandToken) == 0) {           //Modify here
      result = setchannel();                                       //K&R string.h  pg. 251
      //print2(">   The channel has been set to ", result);
    } 
  else if (strcmp(ptrToCommandName, chanreadCommandToken) == 0) {           //Modify here
      result = getchannel();    
      Serial.println(result);
      //print2(">   The channel has been set to ", result);
    } 
  else if (strcmp(ptrToCommandName, voltageCommandToken) == 0) {           //Modify here
      result = setvoltagecmd();                                  //K&R string.h  pg. 251
      //print2(">   The voltage has been set to ", result);
    }
  else if (strcmp(ptrToCommandName, voltreadCommandToken) == 0) {           //Modify here
      resultd = getvoltagecmd();                                
      Serial.println(resultd);
    } 
  else if (strcmp(ptrToCommandName, testCommandToken) == 0) {           //Modify here
      result = identvoltagecmd();                                  //K&R string.h  pg. 251
      //print2(">   The voltage has been set to ", result);
    }
  else if (strcmp(ptrToCommandName, idCommandToken) == 0) {           //Modify here
      Serial.println("AP24");
    }
  
  else {
      nullCommand(ptrToCommandName);
    }
}

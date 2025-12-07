# Arduino Assembly LED Control

This project demonstrates how to mix C++ and Assembly in the Arduino IDE to control LEDs using a button.

## Hardware Setup

1.  **LEDs**:
    *   Connect an LED positive (with a resistor) to **Digital Pin 12 and 13**.
    *   Connect an LED negetive to **GND**
2.  **Button**:
    *   Connect a push button to **Digital Pin 2**.

## Software Steps

1.  **Open the Project**:
    *   Launch the Arduino IDE.
    *   Open the `led.ino` file. The IDE should automatically detect the `led.S` file in the same tab/folder.

2.  **Select Board**:
    *   Go to **Tools** > **Board** and select your Arduino board (e.g., Arduino Uno).
    *   Go to **Tools** > **Port** and select the COM port your board is connected to.

3.  **Compile and Upload**:
    *   Go to **Sketch** > Click the **Verify/Compile** button to compile the code.
    *   Go to **Sketch** > Click the **Upload** (Arrow) button to flash the code to the board.

4.  **Test**:
    *   When the button is **released** (Pin 2 connected to GND), the LEDs on Pin 12 and 13 should turn **ON**.
    *   When the button is **pressed** (Pin 2 pulled High), the LEDs should turn **OFF**.

## File Structure
*   `led.ino`: Main C++ entry point, handles setup loop.
*   `led.S`: Assembly routines for I/O control and delay logic.

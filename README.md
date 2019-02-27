# PN_Receiver
HF Receiver for RedPitaya board


This is a HF receiver for RedPitaya board.

RF input is on ADC 1 (via a transformer and proper filter).

BF output is a PWM signal on Port Ext1 pin 3, i use a D amplifier PAM8403, with a RC filter (1.5k and 22nf) and a potentimeter.

The Tcl file came from Vivado 2017.4

Configuration is made via SSH and via many program one for DDS receive frequencies one for side band, one for gain ...
Those code are in server dir.
Compile on redpitaya with gcc -o ProgNme ProgNme.c
use with ProgNme Param

If one want a fast test load system.bit in RedPitaya and execute cat system.bit > /dev/xdevcfg
No sound heard until you set gain via TestGain and TestGShift.

A more convivial program is to come.

PSE Give report to FM4PN@laposte.net


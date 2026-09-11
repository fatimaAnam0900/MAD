CS442 Mobile Application Development - Lab 1

Name:Fatima Anam  
Roll Number: 04072313046  
Calling setState(() {...}) notifies the Flutter framework that the widget's internal state
has changed and requires a visual refresh. This notification causes Flutter to re-run the build()
method, which recalculates the widget layout and redraws the screen with the updated counter 
values. Without wrapping state modifications in setState(), the variable values change in the
background memory, but Flutter has no signal to re-render the user interface, leaving the 
display frozen on old data.


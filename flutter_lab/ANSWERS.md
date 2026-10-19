# Flutter Lab Answers

Name: fatima anam
Roll no: 040723134046

A1: 19
A2: 10
A3: 9
A4: 32

## B1: Stateless and Stateful classes

Stateless: LabApp, HomePage, StudentCard, GoalBanner. Their output depends only on the data given to them (or is a fixed layout), and they never change by themselves.

Stateful: Tally, Countdown, BuggyCounter. Each one has a value that changes while the app runs (_count, _left and _builds, _clicks), so the screen must be rebuilt with setState.

## B2: Why the Timer must be cancelled in dispose()

A Timer keeps running even after its widget is removed from the screen. On every tick it would call setState on a State object that no longer exists, which causes the error "setState() called after dispose()" and wastes memory. Cancelling it in dispose() stops the timer when the widget is removed.

## B3: What can be const, and what it buys

Widgets whose values never change can be const: for example const SizedBox, const Text('Reset'), const Tally(), const Countdown(), const BuggyCounter() and const MaterialApp in LabApp. A const widget is created once at compile time and reused, so Flutter does less work when it rebuilds and the app performs better.

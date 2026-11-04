# CS442 Week 7 – Team Board Lab

**Name:** Fatima Anam  
**Roll Number:** 04072313046

## Part A – Numeric Answers

A1: 31

A2: 7

A3: 4

A4: 66

## Part B – Short Answers

### B1. Which classes are Stateless and which are Stateful? Why?

Stateless widgets are used when a widget does not need to manage changing data of its own. In this lab, LabApp, HomePage, SettingsCard, SummaryRow, ShareRow, InfoBox, StampStack, Probe, Welcome and InfoPanel are StatelessWidgets.

Stateful widgets are used when a widget needs to manage data that can change during the app's execution. In this lab, Clock is Stateful because its time changes. Tile and SwapBoard are also Stateful because their values or arrangement can change.

### B2. Widget, Element and RenderObject: Which rebuilt on every setState, and what did Probe show?

When setState is called, Flutter runs the build method again for the affected widget. The framework updates the corresponding Element and updates the RenderObject when needed. It does not mean that everything is destroyed and recreated every time.

The Probe helps us observe widget rebuilding through its widget hash code. The Clock rebuilds when its state changes, while Flutter can reuse the existing Element and update the RenderObject only when needed.

### B3. Explain “Constraints go down, sizes go up” using the lab.

This means that the parent widget gives constraints to its child, telling it how much space it can use. The child then decides its size and reports it back to the parent.

For example, in SummaryRow, Expanded divides the available Row width between its children. Each Text gets limited space and wraps its content according to that space. This demonstrates that constraints go down from parent to child, while sizes go up from child to parent.
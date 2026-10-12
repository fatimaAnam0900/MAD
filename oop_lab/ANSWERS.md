# OOP Lab — Answers

**Name:** Fatima Anam  
**Roll Number:** 04072313046

### Q1
A subclass using `extends` inherits the parent class's implemented methods, fields, and behaviour. A class using `implements` must provide its own implementations for the required methods and getters.

### Q2
I would use a mixin when different classes need to share behaviour, such as renewal functionality in Book and Dvd. I would use an abstract parent class when related classes share common fields and behaviour, such as LibraryItem.

### Q3
When two objects are equal according to `==`, they must return the same `hashCode`. Otherwise, collections such as Set and Map may handle equal objects incorrectly.

### Q4
Dart allows extension methods to add functionality to existing types without modifying their original code. However, String is a final class in Dart, so it cannot be subclassed to add new behaviour.
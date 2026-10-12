// library_lab.dart  -  Campus Library System
// Name: ____________________   Roll no: ____________

const String rollNo = '04072313046';   // e.g. '21F-0347'

// ===== Seeded settings (generated from YOUR roll number). Do not edit. =====
final int seed = int.parse(rollNo.substring(rollNo.length - 2));
final int t = seed ~/ 10;   // tens digit
final int u = seed % 10;    // units digit

const List<String> titles = [
  'Dart Basics', 'Flutter In Action', 'Data Structures', 'Operating Systems',
  'Mobile Design', 'Clean Code', 'Algorithms Unlocked', 'Computer Networks',
  'Database Systems', 'Software Testing',
];

int yearOf(int i) => 1995 + 2 * i + t;      // publication year of titles[i]
final int feePerDay = 5 + t;                // late fee per day, in rupees
final int daysLate = 3 + (t + u) % 6;       // normal number of days late
final int daysBig = 10 + u;                 // a long overdue period
final int feeCap = 150 + 10 * t;            // no single fee may exceed this
final int renewLimit = 1 + t % 3;           // renewals allowed per item
final int renewAttempts = 2 + u;            // renewal attempts made in Step 5
final int shelfSize = 3 + u % 4;            // items on the shelf in Steps 9-10
// ===========================================================================

abstract class LibraryItem {
  final String title;
  final int year;

  LibraryItem(this.title, this.year);

String describe() {
  return '$title ($year)';

}
int lateFee(int days);
}
abstract class Borrowable {
  bool get isAvailable;
  void borrow();
  void giveBack();
}

mixin Renewable {
  int renewals = 0;

  bool renew(int limit) {
    if (renewals >= limit) {
      return false;
    }

    renewals++;
    return true;
  }
}


class Book extends LibraryItem with Renewable implements Borrowable {
  final int pages;
  bool _out = false;
  Book(super.title, super.year, this.pages);

  @override
String describe() {
  return '${super.describe()}, $pages pages';
}
@override
int lateFee(int days) {
  return days * feePerDay;
}
@override
bool get isAvailable => !_out;

@override
void borrow() {
  _out = true;
}

@override
void giveBack() {
  _out = false;
}
}

class Magazine extends LibraryItem {
  final int issue;

  Magazine(String title, int year, this.issue)
      : super(title, year);

  @override
  String describe() {
    return '${super.describe()}, issue $issue';
  }
  @override
int lateFee(int days) {
  return days * (feePerDay ~/ 2);
}
}
class Dvd extends LibraryItem with Renewable {
  final int minutes;

  Dvd(super.title, super.year, this.minutes);

  @override
  String describe() {
    return '${super.describe()}, $minutes min';
  }

  @override
  int lateFee(int days) {
    return days * feePerDay * 2;
  }
}

Book mainBook() {
  return Book(titles[u], yearOf(u), 100 + 3 * seed);
}

Magazine mainMagazine() {
  int i = (u + 1) % 10;
  return Magazine(titles[i], yearOf(i), 1 + (t + u) % 12);
}
Dvd mainDvd() {
  int i = (u + 2) % 10;
  return Dvd(titles[i], yearOf(i), 90 + seed % 40);
}



void main() {
  print('Seed: $seed (t=$t, u=$u)');
  step1();
  step2();
  step3();
  step4();
  step5();
  step6();
  step7();
  step8();
  step9();
  step10();
}


void step1() {
  print('--- Step 1 ---');

  Book b = mainBook();
  LibraryItem item = b;

  print('Step 1: ${b.title} (${b.year}), ${b.pages} pages');
  print('Step 1: stored as LibraryItem: ${item.title}');
  print('Step 1: runtimeType = ${item.runtimeType}');

  // item.pages gives a compile-time error because
  // pages is not declared in LibraryItem.
}

void step2() {
  print('--- Step 2 ---');

  print('Step 2: ${mainBook().describe()}');
  print('Step 2: ${mainMagazine().describe()}');

  // If @override is omitted and describe() is misspelled as descibe(),
  // the method will not override the parent's describe() method.
  // Calls to describe() will use the inherited method instead.
}
void step3() {
  print('--- Step 3 ---');

  Book book = mainBook();
  Magazine magazine = mainMagazine();
  Dvd dvd = mainDvd();

  print('Step 3: Book late fee for $daysLate days = ${book.lateFee(daysLate)}');
  print('Step 3: Magazine late fee for $daysLate days = ${magazine.lateFee(daysLate)}');
  print('Step 3: Dvd late fee for $daysLate days = ${dvd.lateFee(daysLate)}');

  // An abstract class cannot be instantiated directly because
  // its abstract methods have no implementation.
  // A concrete subclass must implement all abstract methods.
}

void step4() {
  print('--- Step 4 ---');

  Book book = mainBook();

  print('Step 4: available? ${book.isAvailable}');

  book.borrow();
  print('Step 4: after borrow? ${book.isAvailable}');

  book.giveBack();
  print('Step 4: after return? ${book.isAvailable}');

  List<LibraryItem> items = [
    book,
    mainMagazine(),
    mainDvd(),
  ];

  for (LibraryItem item in items) {
    print(
      'Step 4: ${item.runtimeType} borrowable? ${item is Borrowable}',
    );
  }

  // If Book extended Borrowable, it would inherit its
  // implementations. But Borrowable defines only a contract,
  // so implements requires Book to provide its own behaviour.
}


void step5() {
  print('--- Step 5 ---');

  Book book = mainBook();
  int ok = 0;

  for (int i = 0; i < renewAttempts; i++) {
    if (book.renew(renewLimit)) {
      ok++;
    }
  }

  print(
    'Step 5: renewed $ok of $renewAttempts attempts (limit $renewLimit)',
  );

  print('Step 5: renew once more? ${book.renew(renewLimit)}');

  print('Step 5: dvd can renew too? ${mainDvd().renew(1)}');

  // Renewable is a mixin because Book and Dvd share renewal behaviour,
  // but Magazine should not have that feature.
  // Putting renew() in LibraryItem would give every library item
  // renewal behaviour, including Magazine.
}

void step6() { print('--- Step 6 ---'); }
void step7() { print('--- Step 7 ---'); }
void step8() { print('--- Step 8 ---'); }
void step9() { print('--- Step 9 ---'); }
void step10() { print('--- Step 10 ---'); }

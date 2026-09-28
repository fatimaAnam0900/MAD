// Week3.dart
// Name: Fatima Anam
// Roll no: 04072313046
final List<Map<String, dynamic>> books = [
  {
    'title': 'Dart in Action',
    'author': 'Ada',
    'year': 2021,
    'copies': 3,
    'tags': ['dart', 'programming'],
  },
  {
    'title': 'Flutter Basics',
    'author': 'Sam',
    'year': 2023,
    'copies': 0,
    'tags': ['flutter', 'mobile'],
  },
  {
    'title': 'Clean Code',
    'author': 'Martin',
    'year': 2008,
    'copies': 2,
    'tags': ['programming', 'design'],
  },
  {
    'title': 'Algorithms',
    'author': 'Knuth',
    'year': 1968,
    'copies': 1,
    'tags': ['programming', 'math'],
  },
  {
    'title': 'UI Design',
    'author': 'Nora',
    'year': 2019,
    'copies': 4,
    'tags': ['design', 'mobile'],
  },
];

//part1
double lateFee(int daysLate, double ratePerDay) => daysLate * ratePerDay;

String formatTitle(String title, [String? author]) {
  if (author == null) {
    return title;
  }

  return '$title by $author';
}

Map<String, dynamic> makeBook({
  required String title,
  required String author,
  int year = 2024,
  int copies = 1,
}) {
  return {'title': title, 'author': author, 'year': year, 'copies': copies};
}

bool isClassic(int year) => year < 2000;

//part2

List<String> transformAll(List<String> items, String Function(String) fn) {
  return items.map(fn).toList();
}

int Function() makeCounter() {
  int count = 0;
  return () {
    count++;
    return count;
  };
}

double Function(int) makeFeeCalculator(double rate) {
  return (int days) => days * rate;
}

int sumDigits(int n) {
  if (n < 10) return n;
  return (n % 10) + sumDigits(n ~/ 10);
}

//part 3
Map<String, int> buildStock() {
  return {for (var b in books) b['title'] as String: b['copies'] as int};
}

class Box<T> {
  T value;
  Box(this.value);
}

T firstOr<T>(List<T> items, T fallback) {
  if (items.isEmpty) {
    return fallback;
  }
  return items.first;
}

class Pair<A, B> {
  final A first;
  final B second;

  Pair(this.first, this.second);

  @override
  String toString() => '($first, $second)';
}

//part 5
class BookNotFoundException implements Exception {
  final String title;
  BookNotFoundException(this.title);
}

class BookNotAvailableException implements Exception {
  final String title;
  BookNotAvailableException(this.title);
}

void checkOut(Map<String, int> stock, String title) {
  if (!stock.containsKey(title)) {
    throw BookNotFoundException(title);
  }
  if (stock[title]! <= 0) {
    throw BookNotAvailableException(title);
  }
  stock[title] = stock[title]! - 1;
}

Map<String, dynamic> findBook(String title) {
  return books.firstWhere((b) => b['title'] == title);
}

//part 6
Future<String> fetchBookOfTheDay() async {
  await Future.delayed(Duration(seconds: 1));
  return 'Dart in Action';
}

Future<String> fetchBroken() async {
  await Future.delayed(Duration(milliseconds: 500));
  throw Exception('Server down');
}

void main() async {
  part1();
  part2();
  part3();
  part4();
  part5();
  await part6();
}

void part1() {
  print('--- Part 1 ---');

  //task 1.1
  print('Late fee: ${lateFee(5, 0.5)}');
  //task 1.2
  print(formatTitle('Dart in Action'));

  print(formatTitle('Dart in Action', 'Ada'));
  //task 1.3
  print(makeBook(title: 'Clean Code', author: 'Martin'));

  print(makeBook(title: 'Algorithms', author: 'Knuth', year: 1968));
  //task 1.4
  print(isClassic(1968));

  print(isClassic(2021));
}

void part2() {
  print('--- Part 2 ---');
  //task 2.1
  var titles = ['Dart in Action', 'Clean Code'];
  print(
    transformAll(titles, (item) {
      return item.toUpperCase();
    }),
  );
  print(transformAll(titles, (item) => '$item!'));

  //task 2.2
  var desk1 = makeCounter();
  var desk2 = makeCounter();
  print(desk1());
  print(desk1());
  print(desk1());
  print(desk2());
  //task 2.3
  var studentFee = makeFeeCalculator(0.25);
  var staffFee = makeFeeCalculator(0.10);
  print('Student fee: ${studentFee(4)}');
  print('Staff fee: ${staffFee(4)}');
  //task 2.4
  print('Sum of digits: ${sumDigits(35)}');
}

void part3() {
  print('--- Part 3 ---');
  //task 3.1
  var titles = books.map((b) => b['title'] as String).toList();
  print('Titles: $titles');

  var available = books
      .where((b) => (b['copies'] as int) > 0)
      .map((b) => b['title'] as String)
      .toList();
  print('Available: $available');

  //task 3.2
  var totalCopies = books.fold<int>(0, (sum, b) => sum + (b['copies'] as int));
  print('Total copies: $totalCopies');

  var oldestYear = books
      .map((b) => b['year'] as int)
      .reduce((min, year) => year < min ? year : min);
  print('Oldest year: $oldestYear');

  //task 3.3
  var sortedBooks = List<Map<String, dynamic>>.from(books);
  sortedBooks.sort((a, b) => (a['year'] as int).compareTo(b['year'] as int));
  var sortedTitles = sortedBooks.map((b) => b['title'] as String).toList();
  print('By year: $sortedTitles');

  //task 3.4
  var stock = buildStock();
  print('Stock: $stock');

  stock.forEach((title, copies) {
    if (copies == 0) {
      print('Out of stock: $title');
    }
  });

  print('Copies of Unknown: ${stock['Unknown'] ?? 0}');

  //task 3.5:
  Set<String> allTags = {for (var b in books) ...List<String>.from(b['tags'])};
  print('All tags: $allTags');

  var a = {'Dart in Action', 'Clean Code', 'Flutter Basics'};
  var b = {'Clean Code', 'Flutter Basics', 'Algorithms'};

  print('Union: ${a.union(b)}');
  print('Common: ${a.intersection(b)}');
  print('Only in A: ${a.difference(b)}');
}

void part4() {
  print('--- Part 4 ---');
  var intBox = Box<int>(5);
  var stringBox = Box<String>('dart');
  print('Box<int>: ${intBox.value}');
  print('Box<String>: ${stringBox.value}');

  //task 4.2
  print(firstOr(['Dart in Action', 'Clean Code'], 'none'));
  print(firstOr<String>([], 'Z'));

  //task 4.3
  print(Pair('Dart in Action', 3));
}

void part5() {
  print('--- Part 5 ---');
  //task 5.3
  var stock = buildStock();
  var checkOutList = ['Dart in Action', 'Flutter Basics', 'Unknown Book'];

  for (var title in checkOutList) {
    try {
      checkOut(stock, title);
      print('Checked out: $title');
    } on BookNotAvailableException catch (e) {
      print('Sorry: "${e.title}" has no copies left');
    } on BookNotFoundException catch (e) {
      print('Not found: "${e.title}"');
    } finally {
      print('Transaction logged.');
    }
  }

  print('Copies left of Dart in Action: ${stock['Dart in Action']}');

  //task 5.4
  try {
    findBook('Missing');
  } on StateError {
    print('Search failed: no such book');
  }
}

Future<void> part6() async {
  print('--- Part 6 ---');
  //task 6.1
  print('Fetching...');
  var book = await fetchBookOfTheDay();
  print('Book of the day: $book');

  //task 6.3
  try {
    await fetchBroken();
  } catch (e) {
    print('Fetch failed: $e');
  }
}

// --- Reflection Questions Answers ---

/*
1. When would you choose fold over reduce?
   - I'd use fold when the list might be empty (since reduce throws an error on empty lists) 
     or when I need the final answer to be a different data type than the items in the list.

2. What does it mean that a closure "captures" a variable? Which variable was captured in makeCounter?
   - It means the inner function remembers and can keep using a variable from its outer function, 
     even after the outer function finishes. In makeCounter, the 'count' variable was captured.

3. Why must on BookNotAvailableException come before a general catch (e)?
   - Dart checks exception handlers from top to bottom. If a general catch(e) comes first, 
     it will catch every error, and the specific BookNotAvailableException block will never get executed.

4. Why does forgetting await still compile, but give the wrong result?
   - Because a Future is a valid Dart object, so the syntax is fine. But without await, 
     Dart doesn't wait for the task to complete and just returns the Future instance itself instead of the actual data.
*/

// Student: Amro Ali Abdallah
// Reg no: 26187
const String regNo = '26187';
final int d = int.parse(regNo[regNo.length - 1]);
final int t = int.parse(regNo.substring(regNo.length - 2));

// ---------- B2 ----------
int countVowels(String text) {
  // by AAA
  int count = 0;
  String lower = text.toLowerCase(); // makes capital letters count
  for (int i = 0; i < lower.length; i++) {
    if ('aeiou'.contains(lower[i])) count++;
  }
  return count;
}

// ---------- B3 ----------
String initials(String fullName) {
  // by AAA
  // First draft (kept as a comment, it crashes on extra spaces):
  //   String result = '';
  //   for (String part in fullName.split(' ')) {
  //     result += part[0].toUpperCase() + '.';
  //   }
  //   return result;
  String trimmed = fullName.trim();
  if (trimmed.isEmpty) return '';
  List<String> parts = trimmed.split(RegExp(r'\s+'));
  String result = '';
  int i = 0;
  while (i < parts.length) {
    result += parts[i][0].toUpperCase() + '.';
    i++;
  }
  return result;
}

// ---------- C5 ----------
void drawTriangle(int height) {
  // by AAA
  int row = 1;
  while (row <= height) {
    String symbol = row % 2 == 1 ? '*' : '#';
    print(' ' * (height - row) + symbol * row);
    row++;
  }
}

// ---------- D2 ----------
int momoFee(int amount) {
  // by AAA
  if (amount <= 0) return -1;
  if (amount <= 1000) return 20;
  if (amount <= 10000) return 100;
  if (amount <= 150000) return 250;
  return 1500;
}

String maskPhone(String phone) {
  // by AAA
  if (phone.length != 10) return 'INVALID';
  return phone.substring(0, 3) +
      '*' * (phone.length - 5) +
      phone.substring(phone.length - 2);
}

void main() {
  // by AAA
  print('Reg no: $regNo | D = $d | T = $t');

  // B2
  String name = 'Amro Ali Abdallah';
  print('$name has ${countVowels(name)} vowels');

  // B3
  print('Initials of "$name": "${initials(name)}"');
  print('Initials of " ana uwase ": "${initials(' ana uwase ')}"');
  print('Initials of " ": "${initials(' ')}"');

  // C5
  print('--- triangle, height ${d + 3} ---');
  drawTriangle(d + 3);
  print('--- triangle, height 0 ---');
  drawTriangle(0);
  print('--- triangle, height -2 ---');
  drawTriangle(-2);

  // D2
  print('--- receipts ---');
  String masked = maskPhone('0788123456');
  int i = 1;
  int total = 0;
  while (i <= d + 3) {
    int amount = i * 4000 + t * 100;
    int fee = momoFee(amount);
    if (fee != -1) {
      total += fee;
    }
    print('Receipt $i | $amount RWF | fee $fee RWF | to $masked');
    i++;
  }
  print('Total fees: $total RWF');
}
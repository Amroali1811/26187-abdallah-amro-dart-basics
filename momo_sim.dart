// Student: Amro Ali Abdallah
// Reg no: 26187
const String regNo = '26187';
final int d = int.parse(regNo[regNo.length - 1]);
final int t = int.parse(regNo.substring(regNo.length - 2));

// copied from D2
int momoFee(int amount) {
  // by AAA
  if (amount <= 0) return -1;
  if (amount <= 1000) return 20;
  if (amount <= 10000) return 100;
  if (amount <= 150000) return 250;
  return 1500;
}

String formatRwf(int amount) {
  // by AAA
  bool negative = amount < 0;
  String digits = (negative ? -amount : amount).toString();
  String result = '';
  int count = 0;
  int i = digits.length - 1;
  while (i >= 0) {
    if (count > 0 && count % 3 == 0) result = ',' + result;
    result = digits[i] + result;
    count++;
    i--;
  }
  String sign = negative ? '-' : '';
  return '$sign$result RWF';
}

bool isValidPin(String pin) {
  // by AAA
  if (pin.length != 5) return false;
  int i = 0;
  while (i < pin.length) {
    int code = pin.codeUnitAt(i);
    if (code < 48 || code > 57) return false; // not an ASCII digit
    i++;
  }
  if (pin == '12345') return false;
  bool allSame = true;
  i = 1;
  while (i < pin.length) {
    if (pin[i] != pin[0]) allSame = false;
    i++;
  }
  if (allSame) return false;
  return true;
}

int sendMoney(int balance, int amount) {
  // by AAA
  int fee = momoFee(amount);
  if (fee == -1) {
    print('Failed: invalid amount');
    return balance;
  }
  if (amount + fee > balance) {
    print('Failed: insufficient balance');
    return balance;
  }
  int newBalance = balance - amount - fee;
  print('Sent ${formatRwf(amount)} (fee ${formatRwf(fee)}). '
      'New balance: ${formatRwf(newBalance)}');
  return newBalance;
}

int buyAirtime(int balance, int amount) {
  // by AAA
  if (amount < 100 || amount > 50000) {
    print('Failed: airtime must be from ${formatRwf(100)} to ${formatRwf(50000)}');
    return balance;
  }
  if (amount > balance) {
    print('Failed: insufficient balance');
    return balance;
  }
  int newBalance = balance - amount;
  print('Bought airtime ${formatRwf(amount)}. New balance: ${formatRwf(newBalance)}');
  return newBalance;
}

void main() {
  // by AAA
  print('Reg no: $regNo | D = $d | T = $t');

  print('--- PIN checks ---');
  List<String> pins = ['12345', '77777', '4821', '48a21', '4821$d'];
  int p = 0;
  while (p < pins.length) {
    print('isValidPin(${pins[p]}): ${isValidPin(pins[p])}');
    p++;
  }

  print('--- transactions ---');
  int balance = 20000 + t * 500;
  print('Starting balance: ${formatRwf(balance)}');
  int k = 0;
  while (k < 3) {
    balance = sendMoney(balance, (d + 1) * 3000);
    k++;
  }
  balance = buyAirtime(balance, 1000);
  balance = sendMoney(balance, 0);
  balance = sendMoney(balance, 200000);
  print('Final balance: ${formatRwf(balance)}');

  print('--- my own tests ---');
  print(formatRwf(100000)); // expected: 100,000 RWF
  print(formatRwf(1000000)); // expected: 1,000,000 RWF
  print(formatRwf(12)); // expected: 12 RWF
  // Might break: negative number whose digits are a multiple of 3.
  // A naive version would print -,100,000 RWF.
  print(formatRwf(-100000)); // expected: -100,000 RWF
  print(isValidPin('00000')); // expected: false (same digit five times)
  print(isValidPin('01234')); // expected: true (leading zero is fine)
  print(isValidPin('1234 ')); // expected: false (space is not a digit)
}

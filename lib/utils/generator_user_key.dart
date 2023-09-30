class GeneratorUserId {

  String generateIdByEmail(String email) {
    StringBuffer buffer = StringBuffer();
    List<String> chars = email.split('');
    for (int i = 0; i < chars.length; i++) {
      buffer.write(_alphabet[chars[i]]);
    }
    print(buffer.toString());
    return buffer.toString();
  }

  int generateIdByPhone(String phone) {
    StringBuffer buffer = StringBuffer();
    List<String> phoneChars = phone.split('');
    for (int i = 0; i < phoneChars.length; i++) {
      buffer.write(_phone[phoneChars[i]]);
    }

    print(buffer.toString());
    return int.parse(buffer.toString());
  }

  final _phone = {
    " ": "11",
    "+": "10",
    "1": "1",
    "2": "2",
    "3": "3",
    "4": "4",
    "5": "5",
    "6": "6",
    "7": "7",
    "8": "8",
    "9": "9",
    "0": "12",
    "-": "13",
  };

  final _alphabet = {
    "A": "1",
    "a": "2",
    "B": "3",
    "b": "4",
    "C": "5",
    "c": "6",
    "D": "7",
    "d": "8",
    "E": "9",
    "e": "10",
    "F": "11",
    "f": "12",
    "G": "13",
    "g": "14",
    "H": "15",
    "h": "16",
    "I": "17",
    "i": "18",
    "J": "19",
    "j": "20",
    "K": "21",
    "k": "22",
    "L": "23",
    "l": "24",
    "M": "25",
    "m": "26",
    "N": "27",
    "n": "28",
    "O": "29",
    "o": "30",
    "P": "31",
    "p": "32",
    "Q": "33",
    "q": "34",
    "R": "35",
    "r": "36",
    "S": "37",
    "s": "38",
    "T": "39",
    "t": "40",
    "U": "41",
    "u": "42",
    "V": "43",
    "v": "44",
    "W": "45",
    "w": "46",
    "X": "47",
    "x": "48",
    "Y": "49",
    "y": "50",
    "Z": "51",
    "z": "52",
    "@": "53",
    ".": "54",
    "1": "55",
    "2": "56",
    "3": "57",
    "4": "58",
    "5": "59",
    "6": "60",
    "7": "61",
    "8": "62",
    "9": "63",
    "0": "64",
  };
}

import "package:ramadan_taskminder/extensions/int.dart";

const totalAyahCount = 6236;
const totalJuzCount = 30;

const surahs = [
  {"name": "Al-Fatihah", "ayahs": 7},
  {"name": "Al-Baqarah", "ayahs": 286},
  {"name": "Al-Imran", "ayahs": 200},
  {"name": "An-Nisaa'", "ayahs": 176},
  {"name": "Al-Ma'ida", "ayahs": 120},
  {"name": "Al-An'am", "ayahs": 165},
  {"name": "Al-A'raf", "ayahs": 206},
  {"name": "Al-Anfal", "ayahs": 75},
  {"name": "Al-Tawba", "ayahs": 129},
  {"name": "Yunus", "ayahs": 109},
  {"name": "Hud", "ayahs": 123},
  {"name": "Yusuf", "ayahs": 111},
  {"name": "Ar-Ra'd", "ayahs": 43},
  {"name": "Ibrahim", "ayahs": 52},
  {"name": "Al-Hijr", "ayahs": 99},
  {"name": "An-Nahl", "ayahs": 128},
  {"name": "Al-Israa", "ayahs": 111},
  {"name": "Al-Kahf", "ayahs": 110},
  {"name": "Maryam", "ayahs": 98},
  {"name": "Ta-Ha", "ayahs": 135},
  {"name": "Al-Anbiya", "ayahs": 112},
  {"name": "Al-Hajj", "ayahs": 78},
  {"name": "Al-Muminun", "ayahs": 118},
  {"name": "An-Nur", "ayahs": 64},
  {"name": "Al-Furqan", "ayahs": 77},
  {"name": "Ash-Shuara", "ayahs": 227},
  {"name": "An-Naml", "ayahs": 93},
  {"name": "Al-Qasas", "ayahs": 88},
  {"name": "Al-Ankabut", "ayahs": 69},
  {"name": "Ar-Rum", "ayahs": 60},
  {"name": "Luqman", "ayahs": 34},
  {"name": "As-Sajdah", "ayahs": 30},
  {"name": "Al-Ahzab", "ayahs": 73},
  {"name": "Saba", "ayahs": 54},
  {"name": "Fatir", "ayahs": 45},
  {"name": "Yasin", "ayahs": 83},
  {"name": "As-Saffat", "ayahs": 182},
  {"name": "Sad", "ayahs": 88},
  {"name": "Az-Zumar", "ayahs": 75},
  {"name": "Ghafir", "ayahs": 85},
  {"name": "Fussilat", "ayahs": 54},
  {"name": "Ash-Shura", "ayahs": 53},
  {"name": "Az-Zukhruf", "ayahs": 89},
  {"name": "Ad-Dukhan", "ayahs": 59},
  {"name": "Al-Jathiya", "ayahs": 37},
  {"name": "Al-Ahqaf", "ayahs": 35},
  {"name": "Muhammad", "ayahs": 38},
  {"name": "Al-Fath", "ayahs": 29},
  {"name": "Al-Hujurat", "ayahs": 18},
  {"name": "Qaf", "ayahs": 45},
  {"name": "Az-Zariyat", "ayahs": 60},
  {"name": "At-Tur", "ayahs": 49},
  {"name": "An-Najm", "ayahs": 62},
  {"name": "Al-Qamar", "ayahs": 55},
  {"name": "Ar-Rahman", "ayahs": 78},
  {"name": "Al-Waqia", "ayahs": 96},
  {"name": "Al-Hadid", "ayahs": 29},
  {"name": "Al-Mujadilah", "ayahs": 22},
  {"name": "Al-Hashr", "ayahs": 24},
  {"name": "Al-Mumtahinah", "ayahs": 13},
  {"name": "As-Saff", "ayahs": 14},
  {"name": "Al-Jumu'ah", "ayahs": 11},
  {"name": "Al-Munafiqun", "ayahs": 11},
  {"name": "At-Taghabun", "ayahs": 18},
  {"name": "At-Talaq", "ayahs": 12},
  {"name": "At-Tahrim", "ayahs": 12},
  {"name": "Al-Mulk", "ayahs": 30},
  {"name": "Al-Qalam", "ayahs": 52},
  {"name": "Al-Haqqah", "ayahs": 52},
  {"name": "Al-Ma'arij", "ayahs": 44},
  {"name": "Nuh", "ayahs": 28},
  {"name": "Al-Jinn", "ayahs": 28},
  {"name": "Al-Muzzammil", "ayahs": 20},
  {"name": "Al-Muddaththir", "ayahs": 56},
  {"name": "Al-Qiyamah", "ayahs": 40},
  {"name": "Al-Insan", "ayahs": 31},
  {"name": "Al-Mursalat", "ayahs": 50},
  {"name": "An-Naba", "ayahs": 40},
  {"name": "An-Naziat", "ayahs": 46},
  {"name": "Abasa", "ayahs": 42},
  {"name": "At-Takwir", "ayahs": 29},
  {"name": "Al-Infitar", "ayahs": 19},
  {"name": "Al-Mutaffifin", "ayahs": 36},
  {"name": "Al-Inshiqaq", "ayahs": 25},
  {"name": "Al-Buruj", "ayahs": 22},
  {"name": "At-Tariq", "ayahs": 17},
  {"name": "Al-Ala", "ayahs": 19},
  {"name": "Al-Ghashiyah", "ayahs": 26},
  {"name": "Al-Fajr", "ayahs": 30},
  {"name": "Al-Balad", "ayahs": 20},
  {"name": "Ash-Shams", "ayahs": 15},
  {"name": "Al-Lail", "ayahs": 21},
  {"name": "Ad-Duha", "ayahs": 11},
  {"name": "Ash-Sharh", "ayahs": 8},
  {"name": "At-Tin", "ayahs": 8},
  {"name": "Al-Alaq", "ayahs": 19},
  {"name": "Al-Qadr", "ayahs": 5},
  {"name": "Al-Bayinah", "ayahs": 8},
  {"name": "Az-Zalzalah", "ayahs": 8},
  {"name": "Al-Adiyat", "ayahs": 11},
  {"name": "Al-Qariah", "ayahs": 11},
  {"name": "Al-Takathur", "ayahs": 8},
  {"name": "Al-Asr", "ayahs": 3},
  {"name": "Al-Humazah", "ayahs": 9},
  {"name": "Al-Fil", "ayahs": 5},
  {"name": "Quraish", "ayahs": 4},
  {"name": "Al-Ma'un", "ayahs": 7},
  {"name": "Al-Kauthar", "ayahs": 3},
  {"name": "Al-Kafirun", "ayahs": 6},
  {"name": "An-Nasr", "ayahs": 3},
  {"name": "Al-Masad", "ayahs": 5},
  {"name": "Al-Ikhlas", "ayahs": 4},
  {"name": "Al-Falaq", "ayahs": 5},
  {"name": "An-Nas", "ayahs": 6}
];

const juz = [
  {
    "start": {"surah": 1, "ayah": 1},
    "end": {"surah": 2, "ayah": 141}
  },
  {
    "start": {"surah": 2, "ayah": 142},
    "end": {"surah": 2, "ayah": 252}
  },
  {
    "start": {"surah": 2, "ayah": 253},
    "end": {"surah": 3, "ayah": 92}
  },
  {
    "start": {"surah": 3, "ayah": 93},
    "end": {"surah": 4, "ayah": 23}
  },
  {
    "start": {"surah": 4, "ayah": 24},
    "end": {"surah": 4, "ayah": 147}
  },
  {
    "start": {"surah": 4, "ayah": 148},
    "end": {"surah": 5, "ayah": 81}
  },
  {
    "start": {"surah": 5, "ayah": 82},
    "end": {"surah": 6, "ayah": 110}
  },
  {
    "start": {"surah": 6, "ayah": 111},
    "end": {"surah": 7, "ayah": 87}
  },
  {
    "start": {"surah": 7, "ayah": 88},
    "end": {"surah": 8, "ayah": 40}
  },
  {
    "start": {"surah": 8, "ayah": 41},
    "end": {"surah": 9, "ayah": 92}
  },
  {
    "start": {"surah": 9, "ayah": 93},
    "end": {"surah": 11, "ayah": 5}
  },
  {
    "start": {"surah": 11, "ayah": 6},
    "end": {"surah": 12, "ayah": 52}
  },
  {
    "start": {"surah": 12, "ayah": 53},
    "end": {"surah": 14, "ayah": 52}
  },
  {
    "start": {"surah": 15, "ayah": 1},
    "end": {"surah": 16, "ayah": 128}
  },
  {
    "start": {"surah": 17, "ayah": 1},
    "end": {"surah": 18, "ayah": 74}
  },
  {
    "start": {"surah": 18, "ayah": 75},
    "end": {"surah": 20, "ayah": 135}
  },
  {
    "start": {"surah": 21, "ayah": 1},
    "end": {"surah": 22, "ayah": 78}
  },
  {
    "start": {"surah": 23, "ayah": 1},
    "end": {"surah": 25, "ayah": 20}
  },
  {
    "start": {"surah": 25, "ayah": 21},
    "end": {"surah": 27, "ayah": 55}
  },
  {
    "start": {"surah": 27, "ayah": 56},
    "end": {"surah": 29, "ayah": 45}
  },
  {
    "start": {"surah": 29, "ayah": 46},
    "end": {"surah": 33, "ayah": 30}
  },
  {
    "start": {"surah": 33, "ayah": 31},
    "end": {"surah": 36, "ayah": 27}
  },
  {
    "start": {"surah": 36, "ayah": 28},
    "end": {"surah": 39, "ayah": 31}
  },
  {
    "start": {"surah": 39, "ayah": 32},
    "end": {"surah": 41, "ayah": 46}
  },
  {
    "start": {"surah": 41, "ayah": 47},
    "end": {"surah": 45, "ayah": 37}
  },
  {
    "start": {"surah": 46, "ayah": 1},
    "end": {"surah": 51, "ayah": 30}
  },
  {
    "start": {"surah": 51, "ayah": 31},
    "end": {"surah": 57, "ayah": 29}
  },
  {
    "start": {"surah": 58, "ayah": 1},
    "end": {"surah": 66, "ayah": 12}
  },
  {
    "start": {"surah": 67, "ayah": 1},
    "end": {"surah": 77, "ayah": 50}
  },
  {
    "start": {"surah": 78, "ayah": 1},
    "end": {"surah": 114, "ayah": 6}
  }
];

final List<List<int>> juzSurahs = juz
    .map((juzEntry) =>
        juzEntry["start"]!["surah"]!.upTo(juzEntry["end"]!["surah"]!))
    .toList();

int calculateAyahsRead(List history) {
  int ayahs = 0;

  Iterable entries = history.map((entry) => entry[1]);
  for (var entry in entries) {
    ayahs += calculateEntryAyahs(entry as List<String>);
  }

  return ayahs;
}

int calculateEntryAyahs(List<String> entry) {
  final start = entry[0].split("-").map(int.parse).toList();
  final end = entry[1].split("-").map(int.parse).toList();

  final startSurah = start[0],
      startAyah = start[1],
      endSurah = end[0],
      endAyah = end[1];

  if (startSurah == endSurah) {
    return endAyah - startAyah;
  }

  if (startSurah < endSurah) {
    int ayahs = 0;

    final surahIndexes = startSurah.upTo(endSurah);
    for (var index = 0; index < surahIndexes.length; index++) {
      if (index == 0) {
        // First surah
        ayahs += int.parse(surahs[startSurah]["ayahs"].toString()) - startAyah;
      } else if (index == surahIndexes.length - 1) {
        // Last surah
        ayahs += endAyah;
      } else {
        // Other surahs
        ayahs += int.parse(surahs[surahIndexes[index]]["ayahs"].toString());
      }
    }

    return ayahs;
  }

  return 0;
}

class TextCaps {
 static String toTitleCase(String text) {
    if (text.isEmpty) return '';

    return text
        .split(' ')
        .map((word) {
          if (word.isEmpty) return word;
          return word[0].toUpperCase() + word.substring(1).toLowerCase();
        })
        .join(' ');
  }

}
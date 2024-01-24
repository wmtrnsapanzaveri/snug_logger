class LogDetail {
  const LogDetail(this.emoji, this.color, {this.contentColor = '\u001b[93m'});

  final String emoji;
  final String color;
  final String contentColor;
}
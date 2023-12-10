enum WinnerFilter {
  indicated,
  winner,
  all,
}

extension WinnerFilterPath on WinnerFilter {
  String get path {
    switch (this) {
      case WinnerFilter.indicated:
        return '&winner=false';
      case WinnerFilter.winner:
        return '&winner=true';
      default:
        return '';
    }
  }
}

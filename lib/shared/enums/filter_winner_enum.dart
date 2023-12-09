enum FilterWinner {
  indicated,
  winner,
  all,
}

extension FilterWinnerPath on FilterWinner {
  String get path {
    switch (this) {
      case FilterWinner.indicated:
        return '&winner=false';
      case FilterWinner.winner:
        return '&winner=true';
      default:
        return '';
    }
  }
}

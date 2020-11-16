class SearchFilters
{
  List<String> payeList = [];
  List<String> bookList = [];
  List<String> chapterList = [];
  List<String> kindList = [];
  List<String> difficultyList = [];

  SearchFilters SearchFilterForServer()
  {
    SearchFilters SF = new SearchFilters();

    for (int i=0;i<this.payeList.length;i++)
    {
      if (this.payeList[i] == "دهم")
      {
        SF.payeList.add("10");
      }
      else if (this.payeList[i] == "یازدهم")
      {
        SF.payeList.add("11");
      }
      else if (this.payeList[i] == "دوازدهم")
      {
        SF.payeList.add("12");
      }
    }

    for (int i=0;i<this.bookList.length;i++)
    {
      if (this.bookList[i] == "ریاضی")
      {
        SF.bookList.add("MATH");
      }
      else if (this.bookList[i] == "فیزیک")
      {
        SF.bookList.add("PHYSIC");
      }
      else if (this.bookList[i] == "شیمی")
      {
        SF.bookList.add("CHEMISTRY");
      }
      else if (this.bookList[i] == "زیست")
      {
        SF.bookList.add("BIOLOGY");
      }
    }

    for (int i=0;i<this.chapterList.length;i++)
    {
      if (this.chapterList[i] == "اول")
      {
        SF.chapterList.add("1");
      }
      else if (this.chapterList[i] == "دوم")
      {
        SF.chapterList.add("2");
      }
      else if (this.chapterList[i] == "سوم")
      {
        SF.chapterList.add("3");
      }
      else if (this.chapterList[i] == "چهارم")
      {
        SF.chapterList.add("4");
      }
      else if (this.chapterList[i] == "پنجم")
      {
        SF.chapterList.add("5");
      }
      else if (this.chapterList[i] == "ششم")
      {
        SF.chapterList.add("6");
      }
      else if (this.chapterList[i] == "هفتم")
      {
        SF.chapterList.add("7");
      }
      else if (this.chapterList[i] == "هشتم")
      {
        SF.chapterList.add("8");
      }
      else if (this.chapterList[i] == "نهم")
      {
        SF.chapterList.add("9");
      }
      else if (this.chapterList[i] == "دهم")
      {
        SF.chapterList.add("10");
      }
    }
    for (int i=0;i<this.kindList.length;i++)
    {
      if (this.kindList[i] == "تستی")
      {
        SF.kindList.add("TEST");
      }
      else if (this.kindList[i] == "جایخالی")
      {
        SF.kindList.add("SHORTANSWER");
      }
      else if (this.kindList[i] == "چند گزینه ای")
      {
        SF.kindList.add("MULTICHOISE");
      }
      else if (this.kindList[i] == "تشریحی")
      {
        SF.kindList.add("LONGANSWER");
      }
    }
    for (int i=0;i<this.difficultyList.length;i++)
    {
      if (this.difficultyList[i] == "آسان")
      {
        SF.difficultyList.add("LOW");
      }
      else if (this.difficultyList[i] == "متوسط")
      {
        SF.difficultyList.add("MEDIUM");
      }
      else if (this.difficultyList[i] == "سخت")
      {
        SF.difficultyList.add("HARD");
      }
    }
    return SF;
  }
}
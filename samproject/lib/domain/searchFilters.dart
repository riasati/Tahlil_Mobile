import 'package:samproject/pages/homePage.dart';

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
      SF.payeList.add(HomePage.maps.RSPayeMap[this.payeList[i]]);
    }

    for (int i=0;i<this.bookList.length;i++)
    {
      SF.bookList.add(HomePage.maps.RSBookMap[this.bookList[i]]);
    }

    for (int i=0;i<this.chapterList.length;i++)
    {
      SF.chapterList.add(HomePage.maps.RSChapterMap[this.chapterList[i]]);
    }
    for (int i=0;i<this.kindList.length;i++)
    {
      SF.kindList.add(HomePage.maps.RSKindMap[this.kindList[i]]);
    }
    for (int i=0;i<this.difficultyList.length;i++)
    {
      SF.difficultyList.add(HomePage.maps.RSDifficultyMap[this.difficultyList[i]]);
    }
    return SF;
  }
}
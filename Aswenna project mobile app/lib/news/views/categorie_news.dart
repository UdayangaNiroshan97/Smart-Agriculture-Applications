import 'package:aswenna/news/helper/news.dart';
import 'package:aswenna/news/helper/widgets.dart';
import 'package:flutter/material.dart';

class CategoryNews extends StatefulWidget {

  final String newsCategory;

  CategoryNews({this.newsCategory});

  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  var newslist;
  bool _loading = true;

  @override
  void initState() {
    getNews();
    // TODO: implement initState
    super.initState();
  }

  void getNews() async {
    NewsForCategorie news = NewsForCategorie();
    await news.getNewsForCategory(widget.newsCategory);
    newslist = news.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Color(0xFF00695C),
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: Text("Agriculture News", style: TextStyle(color: Colors.white,),),
        centerTitle: true,
      ),
      body: _loading ? Center(
        child: CircularProgressIndicator(),
      ) : SingleChildScrollView(
        child: Container(
            child: Container(
              margin: EdgeInsets.only(top: 16),
              child: ListView.builder(
                  itemCount: newslist.length,
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return NewsTile(
                      imgUrl: newslist[index].urlToImage ?? "",
                      title: newslist[index].title ?? "",
                      desc: newslist[index].description ?? "",
                      content: newslist[index].content ?? "",
                      posturl: newslist[index].articleUrl ?? "",
                    );
                  }),
            ),
        ),
      ),
    );
  }
}

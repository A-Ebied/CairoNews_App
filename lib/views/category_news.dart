import 'package:finalproject/helper/news.dart';
import 'package:flutter/material.dart';
import 'package:finalproject/models/artical.dart';
import '../helper/news.dart';
import '../models/artical.dart';
import 'artical_view.dart';

class CategoryNews extends StatefulWidget {

  final String category;
  CategoryNews({required this.category});


  @override
  State<CategoryNews> createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  List<ArticalModel> articles  = [];
  var newslist;
  bool _loading=true;
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoryNews();
    //getNews();

  }
  getCategoryNews() async {

    NewsForCategorie news = NewsForCategorie();
    await news.getNews(widget.category);
    articles = news.datatobesavedin;

    //newslist = news.news;
    setState(() {
      _loading = false;
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center, // this is to bring the row text in center
          children: <Widget>[
            Text("Cairo ",
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600,fontSize: 30),),
            Text(" News",
              style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.w600,fontSize: 18),),
          ],
        ),
      ),
      body: _loading?Center(child: Container(child: CircularProgressIndicator(),)):SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              //Blogs
              Container(
                margin: EdgeInsets.only(top: 16),
                child: ListView.builder(
                    itemCount: articles.length,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return BlogTile(
                       imageUrl: articles[index].urlToImage ,
                        title: articles[index].title,
                        desc: articles[index].description,
                        url: articles[index].url,

                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class BlogTile extends StatelessWidget {
  final  imageUrl,title,desc,url;

  BlogTile({@required this.imageUrl, @required this.title, @required this.desc,@required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context)=>ArticalView(
              blogUrl:url,
            )
        ));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        child: Column(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(imageUrl)),
            SizedBox(height: 8,),
            Text(title,style: TextStyle(fontSize: 18,color: Colors.black87,
                fontWeight: FontWeight.w500),),
            SizedBox(height: 8,),
            Text(desc,style: TextStyle(color: Colors.black54,
                fontWeight: FontWeight.w500),),
          ],
        ),
      ),
    );
  }
}


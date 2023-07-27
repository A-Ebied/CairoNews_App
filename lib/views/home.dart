import 'package:cached_network_image/cached_network_image.dart';
import 'package:finalproject/models/category_model.dart';
import 'package:finalproject/views/artical_view.dart';
import 'package:finalproject/views/category_news.dart';
import 'package:flutter/material.dart';
import '../helper/data.dart';
import '../helper/news.dart';
import '../models/artical.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home> {
  List<CategoryModel> categories=<CategoryModel>[];
  List<ArticalModel>articles=<ArticalModel>[];
  bool _loading=true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categories = getCategories();
    getNews();
  }

  void getNews() async {
    News news = News();
    await news.getNews();
    articles = news.datatobesavedin;
    setState(() {
      _loading = false;
    });

  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
        Text("Cairo",
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600,fontSize: 30),),
    Text(" News",
    style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.w600,fontSize: 18),),
    ],
    ),
    ),
      body: _loading?Center(child: Container(child: CircularProgressIndicator(),)): SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          //Category
          child: Column(
            children: [
              Container(
               //padding: EdgeInsets.symmetric(horizontal: 16),
                height: 70,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return CategoryTitle(
                        imageAssetUrl: categories[index].imageAssetUrl,
                        categoryName: categories[index].categorieName,
                      );
                    }),
              ),
              //Blogs
              Container(
                margin: EdgeInsets.only(top: 16),
                child: ListView.builder(
                    itemCount: articles.length,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return BlogTile(
                        imageUrl: articles[index].urlToImage??"" ,
                        title: articles[index].title??"",
                        desc: articles[index].description??"",
                        url: articles[index].url??"",
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

class CategoryTitle extends StatelessWidget {
  final String imageAssetUrl, categoryName;
  CategoryTitle({ required this.imageAssetUrl, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: ( context) =>CategoryNews(
                category: categoryName.toLowerCase())
        ));
      },
      child: Container(
        margin: EdgeInsets.only(right: 16),
        child: Stack(
          children:<Widget> [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
               child: CachedNetworkImage(
                 imageUrl: imageAssetUrl,
                 height: 60,
                 width: 120,
                 fit: BoxFit.cover,
               ),),
               //Image.network( imageAssetUrl,width: 120,height: 60,fit:BoxFit.cover,)),
            Container(
              alignment: Alignment.center,
              width: 120,height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.black26,
              ),
              child: Text(categoryName,
                style: TextStyle(color: Colors.white,fontSize: 14,
              fontWeight:FontWeight.w500),),
            )
          ],
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
            fontWeight: FontWeight.w600),),
            SizedBox(height: 8,),
            Text(desc,style: TextStyle(color: Colors.black,
                fontWeight: FontWeight.w500),),
          ],
        ),
      ),
    );
  }
}



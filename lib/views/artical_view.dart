import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class ArticalView extends StatefulWidget {
  final String blogUrl;

  ArticalView({required this.blogUrl});
  @override
  State<ArticalView> createState() => _ArticalViewState();
}

class _ArticalViewState extends State<ArticalView> {
  final Completer<WebViewController> _controller =
  Completer<WebViewController>();


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
        title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
        Text("Cairo",
        style:
        TextStyle(color: Colors.black87, fontWeight: FontWeight.w600,fontSize: 30),
    ),
    Text(" News",
    style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600,fontSize: 18),
    )
    ],
    ),
    actions: <Widget>[
    Opacity(
      opacity: 0,
      child: Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Icon(Icons.share,)),
    ),
    ],
    backgroundColor: Colors.transparent,
    centerTitle: true,
    elevation: 0.0,
    ),
    body:Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: WebView(
        initialUrl:widget.blogUrl,
        onWebViewCreated: (WebViewController webViewController){
          _controller.complete(webViewController);
        },
      ),
    ),);
  }
}


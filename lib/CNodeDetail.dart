import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
class CNodeDetail extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return CNodeDetailState();
  }
  
}
class CNodeDetailState extends State<CNodeDetail>{
  @override
  Widget build(BuildContext context) {
    final Map detail = ModalRoute.of(context).settings.arguments;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(detail['title']),

      ),
      body: Scrollbar(
        child:SingleChildScrollView(
          padding:EdgeInsets.all(8.0),
          child:Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(detail["author"]["avatar_url"]),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 60,
                      // color: Colors.red,
                      padding:EdgeInsets.only(left: 10.0,right: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(detail["author"]["loginname"],style: TextStyle(fontSize: 14)),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(detail["create_at"]),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    // padding: EdgeInsets.only(left: 5,right: 5),
                    // color: Colors.blue,
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          iconSize :18,
                          icon: Icon(Icons.favorite_border),
                          // hoverColor:Colors.transparent,
                          // highlightColor:Colors.transparent,
                          splashColor:Colors.transparent,
                          onPressed: (){},
                        ),
                        IconButton(
                          iconSize :18,
                          padding: EdgeInsets.all(0.0),
                          icon: Icon(Icons.reply),
                          splashColor:Colors.transparent,
                          onPressed: (){},
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Html(
                data: detail['content'],
              ),
            ],
          ),
        )
      )
    );
  }

}
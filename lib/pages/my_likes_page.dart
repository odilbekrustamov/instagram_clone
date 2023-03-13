import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/model/member_model.dart';
import 'package:instagram_clone/service/db_service.dart';

import '../model/post_model.dart';

class MyLikesPage extends StatefulWidget {
  static final String id = "mylikes_page";

  @override
  State<MyLikesPage> createState() => _MyLikesPageState();
}

class _MyLikesPageState extends State<MyLikesPage> {
  bool isLoading = false;
  List<Post> items = [];

  void apiLoadLikes() {
    setState(() {
      isLoading = true;
    });
    DBService.loadLikes().then((value) => {
          _resLoadPost(value),
        });
  }

  void _resLoadPost(List<Post> posts) {
    setState(() {
      items = posts;
      isLoading = false;
    });
  }

  _apiPostUnLike(Post post) async {
    setState(() {
      post.liked = false;
    });
    await DBService.likePost(post, false).then((value) => {
          apiLoadLikes(),
        });
  }

  @override
  void initState() {
    super.initState();
    apiLoadLikes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            "Instagram",
            style: TextStyle(
                color: Colors.black, fontFamily: 'Billabong', fontSize: 30),
          ),
        ),
        body: Stack(
          children: [
            ListView.builder(
              itemCount: items.length,
              itemBuilder: (ctx, index) {
                return _itemOfPost(items[index]);
              },
            ),

            //#loading
            isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SizedBox.shrink()
          ],
        ));
  }

  Widget _itemOfPost(Post post) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Divider(),

          //  #user info
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: post.img_user.isEmpty
                          ? Image(
                              image: AssetImage("assets/images/ic_person.png"),
                              width: 40,
                              height: 40,
                            )
                          : Image.network(
                              post.img_user,
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                            ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post.fullname,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          post.date,
                          style: TextStyle(fontWeight: FontWeight.normal),
                        )
                      ],
                    )
                  ],
                ),
                IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz))
              ],
            ),
          ),

          // #post image
          SizedBox(
            height: 8,
          ),

          CachedNetworkImage(
            imageUrl: post.img_post,
            placeholder: (context, url) => Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
            errorWidget: (context, url, error) => Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
              child: Center(
                  child: Icon(
                Icons.error,
                color: Colors.red,
              )),
            ),
            fit: BoxFit.cover,
          ),

          // #like share
          Row(
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        _apiPostUnLike(post);
                      },
                      icon: post.liked
                          ? Icon(
                              EvaIcons.heart,
                              color: Colors.red,
                            )
                          : Icon(
                              EvaIcons.heartOutline,
                              color: Colors.black,
                            )),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        EvaIcons.messageCircleOutline,
                        color: Colors.black,
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        EvaIcons.paperPlaneOutline,
                        color: Colors.black,
                      ))
                ],
              )
            ],
          ),

          // #caption
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: RichText(
              softWrap: true,
              overflow: TextOverflow.visible,
              text: TextSpan(
                  text: "${post.caption}",
                  style: TextStyle(color: Colors.black)),
            ),
          )
        ],
      ),
    );
  }
}

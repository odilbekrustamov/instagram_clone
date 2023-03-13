import 'package:flutter/material.dart';
import 'package:instagram_clone/model/member_model.dart';

class MySearchPage extends StatefulWidget {
  static final String id = "mysearch_page";

  @override
  State<MySearchPage> createState() => _MySearchPageState();
}

class _MySearchPageState extends State<MySearchPage> {
  var isLoading = false;
  var searchController = TextEditingController();
  List<Member> items = [];

  @override
  void initState() {
    super.initState();
    items.add(Member("Odilbek","odilbekrustamov1215@gmail.com"));
    items.add(Member("Alijon","alijon@gmail.com"));
    items.add(Member("Sirojiddin","shukurov@gmail.com"));
    items.add(Member("Davron","davron@gmail.com"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title:  Text(
            "Search",
            style: TextStyle(
                color: Colors.black, fontFamily: "Billabong", fontSize: 25
            ),
          ),
        ),
        body:Stack(
          children: [
            Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  // #search member
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    padding: EdgeInsets.only(left: 10, right: 10),
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(7)
                    ),
                    child: TextField(
                      controller: searchController,
                      style: TextStyle(
                        color: Colors.black87,
                      ),
                      decoration: InputDecoration(
                        hintText: "Search",
                        border: InputBorder.none,
                        hintStyle: TextStyle(fontSize: 15, color: Colors.grey),
                        icon: Icon(Icons.search, color: Colors.grey,)
                      ),
                    ),
                  ),

                  // #member list
                  Expanded(
                    child: ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (ctx, index){
                        return _itemOfMember(items[index]);
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        )
    );
  }
  Widget _itemOfMember(Member member){
    return Container(
      height: 90,
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(70),
              border: Border.all(
                width: 1.5,
                color: Color.fromRGBO(193, 53, 132, 1),
              )
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(22.5),
              child: Image(
                image: AssetImage("assets/images/ic_person.png"),
                width: 45,
                height: 45,
                fit: BoxFit.cover,
              ),
            ),
          ),
          
          SizedBox(width: 15,),
          
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(member.fullname, style: TextStyle(fontWeight: FontWeight.bold),),
              SizedBox(height: 3,),
              Text(member.email, style: TextStyle(color: Colors.black54),),
            ],
          ),

          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
               GestureDetector(
                 onTap: (){

                 },
                 child:  Container(
                   width: 100,
                   height: 30,
                   decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(3),
                       border: Border.all(
                           width: 1,
                           color: Colors.grey
                       )
                   ),
                   child: Center(
                     child: Text(
                         "Follow"
                     ),
                   ),
                 ),
               )
              ],
            ),
          )
        ],
      ),
    );
  }
}

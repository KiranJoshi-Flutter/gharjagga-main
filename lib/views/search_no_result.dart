import 'package:flutter/material.dart';
import 'package:gharjagga/utlis/constant.dart';

class SearchNoResult extends StatefulWidget {
  const SearchNoResult({Key? key}) : super(key: key);

  @override
  _SearchNoResultState createState() => _SearchNoResultState();
}

class _SearchNoResultState extends State<SearchNoResult> {

  String ?searchFor;

  final searchForController= TextEditingController();



  int flag= 0;


  searchForItemFunct()
 {

  print("---------->> SearhForItemFunct called");
//--------------------------------------->> list <<-----------------------------------------------------

    List<CategoryModel> myCategories = <CategoryModel>[];
    CategoryModel categorieModel= new CategoryModel();

    categorieModel.categoryName = "Business";
    categorieModel.imageUrl = "https://images.unsplash.com/photo-1507679799987-c73779587ccf?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1502&q=80";
    myCategories.add(categorieModel);

    //2
    categorieModel = new CategoryModel();
    categorieModel.categoryName = "Entertainment";
    categorieModel.imageUrl = "https://images.unsplash.com/photo-1522869635100-9f4c5e86aa37?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80";
    myCategories.add(categorieModel);

    //3
    categorieModel = new CategoryModel();
    categorieModel.categoryName = "General";
    categorieModel.imageUrl = "https://images.unsplash.com/photo-1495020689067-958852a7765e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60";
    myCategories.add(categorieModel);

    //4
    categorieModel = new CategoryModel();
    categorieModel.categoryName = "Health";
    categorieModel.imageUrl = "https://images.unsplash.com/photo-1494390248081-4e521a5940db?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1595&q=80";
    myCategories.add(categorieModel);

    //5
    categorieModel = new CategoryModel();
    categorieModel.categoryName = "Science";
    categorieModel.imageUrl = "https://images.unsplash.com/photo-1554475901-4538ddfbccc2?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1504&q=80";
    myCategories.add(categorieModel);

    //5
    categorieModel = new CategoryModel();
    categorieModel.categoryName = "Sports";
    categorieModel.imageUrl = "https://images.unsplash.com/photo-1495563923587-bdc4282494d0?ixlib=rb-1.2.1&auto=format&fit=crop&w=1500&q=80";
    myCategories.add(categorieModel);

    //5
    categorieModel = new CategoryModel();
    categorieModel.categoryName = "Technology";
    categorieModel.imageUrl = "https://images.unsplash.com/photo-1519389950473-47ba0277781c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80";
    myCategories.add(categorieModel);

    //------------------------------------------------------------------------------------------


    myCategories.forEach((value) {
      //print("----------->> The value of value= $value");
      if(value.categoryName== searchFor)
        {
          flag= 1;
          Text("--->> Helllo1!");
        }
    }

   );

    if(flag== 1)
      {
        print("---------->> $searchFor Item found");
        flag= 0;
      }
    else

      print("---------->> Not Found");
    searchForController.clear();

 }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/bg-2.png"),
          fit: BoxFit.cover,
        ),

        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(255, 255, 255, 0.97),
            Color.fromRGBO(255, 255, 255, 0.97),
            Color.fromRGBO(255, 255, 255, 0.98),
          ],
          // begin: Alignment.topCenter,
          // end: Alignment.bottomCenter,
        ),
      ),

      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: <Widget>[
            SizedBox(height: 60.0),

            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                      top: 60.0, left: 26, bottom: 30, right: 20.0),
                  width: 50.0,
                  height: 50.0,
                  //color: Colors.green,

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: Color(0xffEC5A22),
                  ),
                  child: GestureDetector(
                    onTap: () {Navigator.of(context).pop();},
                    child: Image(
                      image: AssetImage(
                          "assets/icons/search_screen/Arrow - Left 2.png"),
                    ),
                  ),

                ),

                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 30.0, right: 26.0),
                    child: Container(
                      height: 50.0,
                      child: TextFormField(
                        style: appTextStyle(
                          FontWeight.normal,
                          16,
                          kTextColor,
                        ),

                        controller: searchForController,
                        validator: (value) {
                          if(value == null || value.isEmpty )
                            print("Enter search keyword.");
                        },
                        decoration: InputDecoration(

                          contentPadding: EdgeInsets.only(left: 20.0,),
                          suffixIcon: Container(
                            margin: EdgeInsets.only(right: 20.0),
                            //color: Colors.green,
                            padding: const EdgeInsets.symmetric(vertical: 0.0),
                            child: GestureDetector(
                              onTap: () {


                                  searchFor= searchForController.text;


                                searchForItemFunct();

                              },
                              child: Container(

                               //color: Colors.green,

                                child: Image(
                                    height: 17.98,
                                    width: 17.98,
                                    image: AssetImage(
                                        "assets/icons/search_screen/Search.png"),
                                    color: Colors.grey,
                                    fit: BoxFit.contain
                                ),
                              ),
                            ),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: 'Search Your Property',


                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          // focusedBorder: InputBorder.none,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          hintStyle: appTextStyle(
                            FontWeight.normal,
                            16,
                            kTextHintColor,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

              ],
            ),

            Expanded(
              child: Container(
                width: 411.4,
                height: double.infinity,

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20.0),
                    topLeft: Radius.circular(20.0),
                  ),

                  color: Colors.white,
                ),

                child: Container(
                  //color: Colors.yellow,
                  margin: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            width: 77.0,
                            height: 26.0,
                            //color: Colors.grey,
                            child: Text("3 Result",
                              style: appTextStyle(
                                  FontWeight.bold,
                                  20.0,
                                  kTextColor
                              ),

                            ),
                          ),
                          Expanded(
                            child: Container(

                            ),
                          ),
                          Expanded(
                            child: Container(),
                          ),
                          Container(
                            width: 98.0,
                            height: 38.0,
                            //color: Colors.black,

                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              gradient: LinearGradient(
                                colors: [

                                  Color(0xff1B1839),
                                  Color(0xff383A4A),
                                ],
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 20),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: 18.0,
                                    height: 18.0,
                                    //color: Colors.red,


                                    child: Image(
                                      image: AssetImage(
                                          "assets/icons/search_screen/Filter 2.png"),
                                    ),

                                  ),

                                  SizedBox(width: 6.0,),
                                  Text("Filter",
                                      style: appTextStyle(
                                          FontWeight.w500, 14.0, Colors.white)
                                  ),
                                ],
                              ),
                            ),

                          ),


                        ],
                      ),

                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(top: 20.0),
                         // color: Colors.green,
                         // height: double.infinity,

                          width: double.infinity,
                          // height: double.infinity,
                          //color: Colors.grey,

                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget> [
                              
                              Center(
                                child: Image(
                                  image: AssetImage("assets/images/Page-Not-Found.png"),
                                ),
                              ),

                              Text("Page Not Found", style: appTextStyleWLS(
                                FontWeight.w500,
                                18.0,
                                Colors.black54,
                              ),),
                            ],
                          ),

                        ),
                      ),
                    ],

                  ),
                ),
              ),
            ),


          ],
        ),

      ),
    );





  }
}




class CategoryModel
{
  String? categoryName;
  String? imageUrl;
}
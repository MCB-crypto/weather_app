import 'package:flutter/material.dart';
import 'package:weather_app/utilities/app_colors.dart';
import 'package:weather_app/utilities/app_text_style.dart';
import 'package:weather_app/widgets/favorite.dart';

class ScrollableList extends StatelessWidget {
  const ScrollableList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        initialChildSize: 0.1,
        minChildSize: 0.1,
        maxChildSize: 1,
        builder: (context, scrollController) => Container(
          decoration: BoxDecoration(
            color: const AppColors().backgroundGrey,
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20)),
          ),
          child: ListView(
            padding:  const EdgeInsets.only(top:15,left: 10, right: 10),
            controller: scrollController,
            children:  [
              Wrap(
                runSpacing: 15,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Row(
                        children: [
                          Icon(Icons.star,
                            color: const AppColors().weatherAppGrey,
                            size: 30,),
                          Text("Favorites",style: AppTextStyle().subMenu,),
                        ]
                    ),
                  ),
                  MaterialButton(onPressed: (){

                  },
                  child: const Favorite(location: 'Klagenfurt')
                  ),
                  MaterialButton(onPressed: (){

                  },
                      child: const Favorite(location: 'Villach')
                  ),
                  MaterialButton(onPressed: (){

                  },
                      child: const Favorite(location: 'Berlin')
                  ),
                  MaterialButton(onPressed: (){

                  },
                      child: const Favorite(location: 'Salzburg')
                  ),
                ],
              ),
            ],
          ),
        )
    );
  }
}



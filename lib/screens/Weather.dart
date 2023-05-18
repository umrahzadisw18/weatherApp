
import 'package:flutter/material.dart';
import 'package:transformer_page_view/transformer_page_view.dart';
import 'package:weather_app/widgets/buildin_transform.dart';
import 'package:weather_app/widgets/single_weather.dart';
import 'package:weather_app/widgets/slider.dart';

import '../models/weather_location.dart';

class WeatherApp extends StatefulWidget {
  const WeatherApp({Key? key}) : super(key: key);

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  int _currentPage=0;
  late String bgImg;

  _onPageChanged(int index){
    setState(() {
       _currentPage=index;
    });
     
  }
  @override
  Widget build(BuildContext context) {
if(locationList[_currentPage].weatherType=='Sunny'){
  bgImg='assets/sunny.jpg';
}else if(locationList[_currentPage].weatherType=='Night'){
    bgImg='assets/night.jpg';
}else if(locationList[_currentPage].weatherType=='Cloudy'){
    bgImg='assets/cloudy.jpeg';
}else{
  bgImg='assets/rainy.jpg';
}

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Center(child: Text('Weather App',
        style:  TextStyle(
          color: Colors.white,
          fontSize: 22,
        ),)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.search,
          size: 30,
           color: Colors.white,),
          onPressed: () { },
          ),
          actions: [
            Container(
              child: IconButton(icon: Icon(Icons.menu_open_outlined,
              size: 30,
               color: Colors.white,) ,
              onPressed: () { },
              ),
            )
          ],
      ),
   body: Container(
    child: Stack(
      children: [
        Image.asset(bgImg,
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.black38,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 100, left: 18),
          child: Row(
            children: [
              for(int i=0; i < locationList.length; i++)
              if(i== _currentPage)
               SliderDot(isActive: true)
           else
              SliderDot(isActive:false)
            ],
          ),
        ),
        TransformerPageView(
          itemCount: locationList.length,
          scrollDirection: Axis.horizontal,
          transformer: ScaleAndFadeTransformer(),
          viewportFraction: 0.8,
          onPageChanged:_onPageChanged,
          itemBuilder: (context,i)=> SingleWeather(index: i,)),
      ],
    ),
   ),
    );
  }
}

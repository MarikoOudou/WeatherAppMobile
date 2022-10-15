import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/logic/cubit/weather_cubit.dart';
import 'package:flutter_application_1/data/models/weather_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _locationInput = TextEditingController();
  List<SystemUiOverlay> overlays = [SystemUiOverlay.bottom];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Color(0xFFFF3F6FB9)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Center(
              child: Text(
                "App Weather",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              padding: EdgeInsets.all(20),
              // decoration: ,
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.transparent),
                child: TextFormField(
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.only(
                          left: 15,
                        ),
                        suffixIcon: Container(
                          child: ElevatedButton.icon(
                              style: ButtonStyle(
                                  side: MaterialStateProperty.all(BorderSide(
                                      width: 0,
                                      color: Colors.transparent,
                                      style: BorderStyle.none)),
                                  backgroundColor: MaterialStateProperty.all(
                                      Color(0xFFFEA6F50))),
                              onPressed: (() {
                                BlocProvider.of<WeatherCubit>(context)
                                    .fetchWeather(_locationInput.text);
                              }),
                              icon: Icon(Icons.search),
                              label: Text("")),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 0,
                              color: Colors.transparent), //<-- SEE HERE
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        filled: true,
                        // hintStyle: TextStyle(color: Colors.grey[800]),
                        hintText: "Entre le nom de la ville",
                        fillColor: Colors.white),
                    controller: _locationInput,
                    onFieldSubmitted: ((value) {
                      // print(value.toString());
                      BlocProvider.of<WeatherCubit>(context)
                          .fetchWeather(value);
                    })),
              ),
            ),
            BlocBuilder<WeatherCubit, WeatherState>(
                builder: ((weatherContext, state) {
              if (state is WeatherLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is WeatherErrorData) {
                return Container(
                  child: Center(
                    child: Text(
                        "''" +
                            _locationInput.text +
                            "'' le nom de la ville n'existe pas",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15)),
                  ),
                );
              } else if (state is WeatherLoaded) {
                print((state as WeatherLoaded).weatherModel.toString());
                WeatherModel weatherModel =
                    (state as WeatherLoaded).weatherModel;
                return Container(
                  padding: EdgeInsets.all(25),
                  child: Center(
                    child: Column(
                      children: [
                        // Text(
                        //   weatherModel.location!["localtime"].toString(),
                        //   style: TextStyle(
                        //       color: Colors.white,
                        //       fontWeight: FontWeight.bold,
                        //       fontSize: 30),
                        // ),
                        // SizedBox(
                        //   height: 25,
                        // ),
                        Text(
                          weatherModel.location!["name"].toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 30),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        if (weatherModel.current!["condition"] != null)
                          Image(
                            loadingBuilder: ((context, child, loadingProgress) {
                              return Container(
                                  child: Center(
                                child: child,
                              ));
                            }),
                            image: NetworkImage("https:" +
                                weatherModel.current!["condition"]["icon"]),
                          ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          weatherModel.current!["temp_c"].toString() + "°",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 45),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Lon : " +
                                  weatherModel.location!["lon"].toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25),
                            ),
                            Text(
                              "Lat : " +
                                  weatherModel.location!["lat"].toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              }

              return Container(
                padding: EdgeInsets.only(top: 40),
                child: Center(
                  child: Text(
                    "",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                ),
              );
            })),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

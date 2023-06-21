import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:news/models/NewsResponse.dart';
import 'package:news/models/SourceResponse.dart';
import 'package:news/screens/home/cubit/states.dart';
import 'package:news/screens/news_details.dart';
import 'package:news/shared/components/constants.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitState());

  static HomeCubit get(context) => BlocProvider.of(context);
  List<Sources> sources = [];
  List<Articles> articles = [];
  int selectedItem = 0;

  void getSources(String cat) {
    Uri URL = Uri.https(
        BASE, "/v2/top-headlines/sources", {"apiKey": APIKEY, "category": cat});
    emit(HomeGetSourcesLoadingState());
    http.get(URL).then((value) {
      var responseJson = jsonDecode(value.body);
      SourceResponse sourceResponse = SourceResponse.fromJson(responseJson);
      if (sourceResponse.status != "ok") {
        emit(HomeConnectionErrorState());
        return;
      }
      sources = sourceResponse.sources ?? [];
      emit(HomeGetSourcesSuccessState());
    }).catchError((error) {
      emit(HomeGetSourcesErrorState(error));
    });
  }

  void getNewsData() {
    Uri URL = Uri.https(BASE, "/v2/everything", {
      "apiKey": APIKEY,
      "sources": sources[selectedItem].id,
    });
    emit(HomeGetNewsLoadingState());
    http.get(URL).then((value) {
      var jsonResponse = jsonDecode(value.body);
      NewsResponse newsResponse = NewsResponse.fromJson(jsonResponse);

      if (newsResponse.status != "ok") {
        emit(HomeConnectionErrorState());
        return;
      }
      articles = newsResponse.articles ?? [];
      emit(HomeGetNewsSuccessState());
    }).catchError((error) {
      emit(HomeGetNewsErrorState(error));
    });
  }

  void changeSource(int index) {
    selectedItem = index;
    emit(HomeChangeSource());
  }
  void NavigateToDetails(context){
    emit(HomeGetNewsDetailsLoadState());
    Navigator.pushNamed(context, NewsDetails.routeName,
        arguments: HomeCubit.get(context).articles[selectedItem]);
    emit(HomeGetNewsDetailsSuccessState());
  }
}

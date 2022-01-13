import 'package:aswenna/news/models/categorie_model.dart';

List<CategorieModel> getCategories(){

  List<CategorieModel> myCategories = List<CategorieModel>();
  CategorieModel categorieModel;

  //1
  categorieModel = new CategorieModel();
  categorieModel.categorieName = "Agricultural Innovations";
  categorieModel.imageAssetUrl = "https://images.unsplash.com/photo-1627920769842-6887c6df05ca?ixid=MnwxMjA3fDB8MHxzZWFyY2h8OTN8fGFncmljdWx0dXJlJTIwcm9ib3R8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1500&q=80";
  myCategories.add(categorieModel);

  //2
  categorieModel = new CategorieModel();
  categorieModel.categorieName = "Agricultural Market";
  categorieModel.imageAssetUrl = "https://images.unsplash.com/photo-1599997842102-744084270ad2?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTJ8fGFncmljdWx0dXJlJTIwZm9vZHxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1500&q=80";
  myCategories.add(categorieModel);

  //3
  categorieModel = new CategorieModel();
  categorieModel.categorieName = "Agricultural Research";
  categorieModel.imageAssetUrl = "https://images.unsplash.com/photo-1605313667521-09554dbfe9ec?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTR8fGFncmljdWx0dXJlJTIwcmVzZWFyY2h8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1500&q=80";
  myCategories.add(categorieModel);

  //4
  categorieModel = new CategorieModel();
  categorieModel.categorieName = "Agricultural Machinery";
  categorieModel.imageAssetUrl = "https://images.unsplash.com/photo-1565647952915-9644fcd446a4?ixid=MnwxMjA3fDB8MHxzZWFyY2h8ODl8fGFncmljdWx0dXJlJTIwbWFyY2tldHxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1500&q=80";
  myCategories.add(categorieModel);

  //5
  categorieModel = new CategorieModel();
  categorieModel.categorieName = "Greenhouse Cultivation";
  categorieModel.imageAssetUrl = "https://images.unsplash.com/photo-1524486361537-8ad15938e1a3?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjZ8fGFncmljdWx0dXJlJTIwbWFyY2tldHxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1500&q=80";
  myCategories.add(categorieModel);

  //5
  categorieModel = new CategorieModel();
  categorieModel.categorieName = "Novel Pesticides";
  categorieModel.imageAssetUrl = "https://images.unsplash.com/photo-1506947411487-a56738267384?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTF8fGRyb25lJTIwcGVzdGljaWRlc3xlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1500&q=80";
  myCategories.add(categorieModel);

  //5
  categorieModel = new CategorieModel();
  categorieModel.categorieName = "Harvesting Methods";
  categorieModel.imageAssetUrl = "https://images.unsplash.com/9/fields.jpg?ixid=MnwxMjA3fDB8MHxzZWFyY2h8NzV8fGFncmljdWx0dXJlJTIwbWFyY2tldHxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1500&q=80";
  myCategories.add(categorieModel);

  return myCategories;

}
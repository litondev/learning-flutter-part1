import './models/category.dart';
import './models/places.dart';

List PLACES_DUMMY_DATA = [
  Places(
    id : 'P1',
    name : 'P1 Title',
    description : 'P1 Des',
    author : 'P1 AUTHOR',
    category : 'C1',
    image : 'https://www.wikihow.com/images_en/thumb/d/da/769114-1.jpg/v4-460px-769114-1.jpg',
    price : 5000
  ),
  Places(
    id : 'P2',
    name : 'P2 Title',
    description : 'P2 Des',
    author : 'P2 AUTHOR',
    category : 'C2',
    image : 'https://www.wikihow.com/images_en/thumb/d/da/769114-1.jpg/v4-460px-769114-1.jpg',
    price : 5000
  ),
  Places(
    id : 'P3',
    name : 'P3 Title',
    description : 'P3 Des',
    author : 'P2 AUTHOR',
    category : 'C3',
    image : 'https://www.wikihow.com/images_en/thumb/d/da/769114-1.jpg/v4-460px-769114-1.jpg',
    price : 5000
  ),
];

List CATEGORIES_DUMMY_DATA = [
  Category(
    id : 'C1',
    title : 'Category1',
    description : '',
    image : 'https://www.wikihow.com/images_en/thumb/d/da/769114-1.jpg/v4-460px-769114-1.jpg',
  ),
  Category (
    id : 'C2',
    title : 'Category2',
    description : '',
    image : 'https://www.wikihow.com/images_en/thumb/d/da/769114-1.jpg/v4-460px-769114-1.jpg',
  ),
  Category (
    id : 'C3',
    title : 'Category3',
    description : '',
    image : 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fshopee.co.id%2FEs-teh-i.87878399.4407154170&psig=AOvVaw0XGXUCiFGFdaA-EaDMTOjF&ust=1644820554255000&source=images&cd=vfe&ved=0CAsQjRxqFwoTCPCpgpmI_PUCFQAAAAAdAAAAABAD'
  )
];
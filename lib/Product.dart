
//With Respect To The Cart Screen
//I'd need to add more items to this list class

class Product {
  String image;
  String title;
  String condition;
  String capacity;
  String color;
  String description;
  int amount;
  int quantity;
  int id;

  Product({required this.id, required this.quantity, required this.amount, required this.image, required this.title, required this.condition, required this.capacity, required this.color, required this.description});

  static List <Product> items = [    //list name is 'items'....
    Product(  ////
      quantity: 1,
      id: 1,  
      amount: 55000,
      image: 'asset/images/games 1.jpg',
      title:'DualSense 5 Controller',
      condition:'Brand New',
      capacity: '',
      color: 'Color: Mixed(White & Black)',
      description: 'Despite the storms, beauty arrives like it was always going to regardless of the darkness.'
    ),
    Product(
      quantity: 1,
      id: 2,
      amount: 55000,
      image: 'asset/images/games 2.jpg',
      title:'DualSense 5 Controller',
      condition: 'Brand New',
      capacity: '',
      color: 'Color: Black',
      description: 'Despite the storms, beauty arrives like it was always going to regardless of the darkness.'
    ),
    Product(
      quantity: 1,
      id: 3,
      amount: 290000,
      image: 'asset/images/series7.jpeg',
      title: 'iWatch Series 7',
      condition: 'Brand New',
      capacity: '',
      color: 'Color: Mixed(White & Black)',
      description: 'Despite the storms, beauty arrives like it was always going to regardless of the darkness.'
    ),
    Product(
      quantity: 1,
      id: 4,
      amount: 1000000,
      image: 'asset/images/dell_alienware_m15_r7.jpg',
      title: 'Alienware 2022 PC',
      condition: 'Brand New',
      capacity: 'Capacity: 1TB SSD',
      color: 'Color: Black',
      description: 'Despite the storms, beauty arrives like it was always going to regardless of the darkness.'
    ),
    Product(
      quantity: 1,
      id: 5,
      amount: 950000,
      image: 'asset/images/laptop.jpg',
      title: 'Razer Blade 2022 PC',
      condition: 'Brand New',
      capacity: 'Capacity: 500GB SSD',
      color: 'Color: Black',
      description: 'Despite the storms, beauty arrives like it was always going to regardless of the darkness.'
    ),
    Product(
      quantity: 1,
      id: 6,
      amount: 700000,
      image: 'asset/images/phones.jpg',
      title: 'iPhone 13 Pro ',
      condition: 'Brand New',
      capacity: 'Capacity: 128GB',
      color: 'Color: White',
      description: 'Despite the storms, beauty arrives like it was always going to regardless of the darkness.'
    ),
    Product(  
      quantity: 1,
      id: 7,
      amount: 820000,
      image: 'asset/images/hp_x360.jpg',
      title: "Hp Envy x360 Convertible",
      condition: 'Brand New',
      capacity: '512GB SSD',
      color: 'Color: Natural Silver',
      description: 'Year: 2021 \nModel: HP ENVY x360 2-in-1 \nScreen size: 15.6 inches touch screen \nRAM: 16GB, Processor: Intel Core i7, OS: Windows 11'
    ),
    Product(   
      quantity: 1,
      id: 8,
      amount: 160000,
      image: 'asset/images/hp_folio_9470m.jpg',
      title: "Hp Folio 9470m",
      condition: 'Brand New',
      capacity: '500GB HDD',
      color: 'Color: Silver',
      description: 'Despite the storms, beauty arrives like it was always going to regardless of the darkness.'
    ),
    Product(  
      quantity: 1,
      id: 9,
      amount: 650000,
      image: 'asset/images/hp_pavilion_15.jpg',
      title: "Hp Pavilion 15",
      condition: 'Brand New',
      capacity: '512GB  SSD',
      color: 'Color: Silver',
      description: 'RAM: 16GB \nDespite the storms, beauty arrives like it was always going to regardless of the darkness.'
    ),
    Product(
      quantity: 1,
      id: 10,
      amount: 890000,
      image: 'asset/images/samsung_s22_ultra.jpg',
      title: "Samsung S22 Ultra",
      condition: 'Brand New',
      capacity: 'Capacity: 256GB',
      color: 'Color: White',
      description: 'Despite the storms, beauty arrives like it was always going to regardless of the darkness.'
    ),
    Product(
      quantity: 1,
      id: 11,
      amount: 800000,
      image: 'asset/images/samsung_s22.jpg',
      title: "Samsung S22",
      condition: 'Brand New',
      capacity: 'Capacity: 256GB',
      color: 'Color: Baby Pink',
      description: 'Despite the storms, beauty arrives like it was always going to regardless of the darkness.'
    ),
    Product(
      quantity: 1,
      id: 12,
      amount: 720000,
      image: 'asset/images/pixel_6_pro.jpg',
      title: "Google Pixel 6 Pro",
      condition: 'Brand New',
      capacity: 'Capacity: 256GB',
      color: 'Color: Black',
      description: 'Despite the storms, beauty arrives like it was always going to regardless of the darkness.'
    ),
    Product(
      quantity: 1,
      id: 13,
      amount: 500000,
      image: 'asset/images/pixel_6.jpg',
      title: "Google Pixel 6 ",
      condition: 'Brand New',
      capacity: 'Capacity: 256GB',
      color: 'Color: Black',
      description: 'Despite the storms, beauty arrives like it was always going to regardless of the darkness.'
    ),
    Product(
      quantity: 1,
      id: 14,
      amount: 1200000,
      image: 'asset/images/lenovo_legion_5pro.jpg',
      title: "Lenovo Legion 5 Pro",
      condition: 'Brand New',
      capacity: 'Capacity: 1TB SSD',
      color: 'Color: Black',
      description: 'Despite the storms, beauty arrives like it was always going to regardless of the darkness.'
    ),
    Product(
      quantity: 1,
      id: 15,
      amount: 1000000,
      image: 'asset/images/lenovo_legion_5.jpg',
      title: "Lenovo Legion 5",
      condition: 'Brand New',
      capacity: 'Capacity: 512GB SSD',
      color: 'Color: Black',
      description: 'Despite the storms, beauty arrives like it was always going to regardless of the darkness.'
    ),
    Product(
      quantity: 1,
      id: 16,
      amount: 810000,
      image: 'asset/images/hp_envy_x360_15.jpg',
      title: "Hp Envy x360 15",
      condition: 'Brand New',
      capacity: 'Capacity: 512GB SSD',
      color: 'Color: Silver',
      description: 'Despite the storms, beauty arrives like it was always going to regardless of the darkness.'
    ),
  ];

}
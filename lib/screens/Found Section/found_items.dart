class FoundItems{
  int id;
  String userName;
  int contactNumber;
  String itemName;
  String description;
  DateTime modifiedTime;
  String imagePath;

  FoundItems({
    required this.id ,
    required this.itemName ,
    required this.userName ,
    required this.description ,
    required this.modifiedTime ,
    required this.contactNumber ,
    required this.imagePath
  });
}

List<FoundItems> sampleFoundItemsList = [
  FoundItems(
    id: 0,
    itemName: 'Laptop',
    userName: 'Abhinav',
    contactNumber: 98765432,
    imagePath: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT-1t0F7YjEWJA86AWRnVECsWNZP-7L7_FY9A&usqp=CAU",
    description: 'Laptop of brand Asus, color white',
    modifiedTime: DateTime(2023, 9, 10, 10, 15, 30), // Replace with a random time
  ),

  FoundItems(
    id: 1,
    itemName: 'Backpack',
    userName: 'Emma',
    contactNumber: 98765432,
    imagePath: "https://wandernity.com/wp-content/uploads/2022/04/20220414_120822-scaled.jpg",
    description: 'Red backpack with books and a water bottle',
    modifiedTime: DateTime(2023, 9, 7, 14, 45, 10), // Replace with a random time
  ),

  FoundItems(
    id: 2,
    itemName: 'Wallet',
    userName: 'Chris',
    contactNumber: 98765432,
    imagePath: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSY6pmYZFwSyEfiCilkmzP7hklL5FydUJjPhg&usqp=CAU",
    description: 'Black leather wallet with ID and credit cards',
    modifiedTime: DateTime(2023, 9, 6, 18, 30, 5), // Replace with a random time
  ),

  FoundItems(
    id: 3,
    itemName: 'Phone',
    userName: 'Sophia',
    contactNumber: 98765432,
    imagePath: "https://media.istockphoto.com/id/1286466147/photo/a-mobile-phone-on-the-table.jpg?s=612x612&w=0&k=20&c=cFnPLODER2tkOQaUIuj1wp3CeumFs4JZUF1yEum7gNI=",
    description: 'Smartphone by Samsung, color blue',
    modifiedTime: DateTime(2023, 9, 8, 12, 0, 0), // Replace with a random time
  ),

  FoundItems(
    id: 4,
    itemName: 'Headphones',
    userName: 'Daniel',
    contactNumber: 98765432,
    imagePath: "https://img.freepik.com/premium-photo/photo-black-wireless-headphones-wooden-table-high-quality-expensive-headphone_549949-487.jpg?w=2000",
    description: 'Wireless headphones with noise cancellation',
    modifiedTime: DateTime(2023, 8, 31, 16, 20, 45), // Replace with a random time
  ),

  FoundItems(
    id: 5,
    itemName: 'Textbook',
    userName: 'Olivia',
    contactNumber: 98765432,
    imagePath: "https://media.karousell.com/media/photos/products/2015/10/19/engineering_mathematics_1445261283_b8218458.jpg",
    description: 'Math textbook for college course',
    modifiedTime: DateTime(2023, 9, 5, 9, 5, 15), // Replace with a random time
  ),
];
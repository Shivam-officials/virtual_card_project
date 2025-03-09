
abstract final class DbContactConstants {
  static const String tableContact = 'tbl_contact';
  static const String tableContactColId = 'id';
  static const String tableContactColName = 'name';
  static const String tableContactColMobile = 'mobile';
  static const String tableContactColEmail = 'email';
  static const String tableContactColAddress = 'address';
  static const String tableContactColDesignation = 'designation';
  static const String tableContactColCompany = 'company';
  static const String tableContactColWebsite = 'website';
  static const String tableContactColFavorite = 'favourite';
}

class ContactModel {
  int id;
  String? name;
  String? mobile;
  String? email;
  String? address;
  String? company;
  String? designation;
  String? website;
  String? image;
  bool favourite;

  ContactModel({
    this.id = -1,
    this.name,
    this.mobile,
    this.email,
    this.address,
    this.company,
    this.designation,
    this.website,
    this.image,
    this.favourite = false,
  });

  ContactModel copyWith({
    int? id,
    String? name,
    String? mobile,
    String? email,
    String? address,
    String? company,
    String? designation,
    String? website,
    String? image,
    bool? favourite,
  }) {
    return ContactModel(
      id: id ?? this.id,
      name: name ?? this.name,
      mobile: mobile ?? this.mobile,
      email: email ?? this.email,
      address: address ?? this.address,
      company: company ?? this.company,
      designation: designation ?? this.designation,
      website: website ?? this.website,
      image: image ?? this.image,
      favourite: favourite ?? this.favourite,
    );
  }

  //todo modify the code to have the empty string when the value is null
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> contactMap = {
      DbContactConstants.tableContactColName: name,
      DbContactConstants.tableContactColMobile: mobile,
      DbContactConstants.tableContactColEmail: email,
      DbContactConstants.tableContactColAddress: address,
      DbContactConstants.tableContactColCompany: company,
      DbContactConstants.tableContactColDesignation: designation,
      DbContactConstants.tableContactColWebsite: website,
      DbContactConstants.tableContactColFavorite: favourite ? 1 : 0,
      if(id>0) DbContactConstants.tableContactColId:id,
      // id will be automatically inserted/incremented through sqfLite
      // plugin so if it more 0 then we have to provide the id bcz its updating
    };
    return contactMap;
  }

  // why is the constants above used to avoid = multiple hardcoded string

  factory ContactModel.fromMap(Map<String, dynamic> tableContactRow)=>ContactModel(
    id:tableContactRow[DbContactConstants.tableContactColId],
    name:tableContactRow[DbContactConstants.tableContactColName],
    mobile:tableContactRow[DbContactConstants.tableContactColMobile],
    email:tableContactRow[DbContactConstants.tableContactColEmail],
    address:tableContactRow[DbContactConstants.tableContactColAddress],
    designation:tableContactRow[DbContactConstants.tableContactColDesignation],
    company:tableContactRow[DbContactConstants.tableContactColCompany],
    website:tableContactRow[DbContactConstants.tableContactColWebsite],
    favourite:tableContactRow[DbContactConstants.tableContactColFavorite]==1?true:false,
  );

  @override
  String toString() {
    return '''
            ContactModel Properties:
            id: $id
            name: $name
            mobile: $mobile
            email: $email
            address: $address
            company: $company
            designation: $designation
            website: $website
            image: $image
            ''';
  }
}

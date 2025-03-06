class ContactModel {
    int? id = -1;
    String? name;
    String? mobile = '';
    String? email = '';
    String? address = '';
    String? company = '';
    String? designation = '';
    String? website = '';
    String? image = '';

    ContactModel({
        this.id,
        this.name,
        this.mobile,
        this.email,
        this.address,
        this.company,
        this.designation,
        this.website,
        this.image,
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
    }) {
        return ContactModel(
            id: id ?? this.id,
            name: name ?? this.name,
            mobile: mobile ?? this.name,
            email: email ?? this.email,
            address: address ?? this.address,
            company: company ?? this.company,
            designation: designation ?? this.designation,
            website: website ?? this.website,
            image: image ?? this.image,
        );
    }

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

///
/// Copyright (C) 2018 Andrious Solutions
///
/// This program is free software; you can redistribute it and/or
/// modify it under the terms of the GNU General Public License
/// as published by the Free Software Foundation; either version 3
/// of the License, or any later version.
///
/// You may obtain a copy of the License at
///
///  http://www.apache.org/licenses/LICENSE-2.0
///
///
/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.
///
///          Created  16 Dec 2018
///
///

class PostalAddress {
  PostalAddress({
    this.label,
  }) {
    if (label == null) label = "";
  }

  PostalAddress.fromMap(Map m) {
    label = m["label"];
    _street = m["street"];
    _city = m["city"];
    _postcode = m["postcode"];
    _region = m["region"];
    _country = m["country"];
  }

  String label, _street, _city, _postcode, _region, _country;

  String get street => _street;
  set street(String street) {
    if (street == null) street = "";
    _street = street;
  }

  String get city => _city;
  set city(String city) {
    if (city == null) city = "";
    _city = city;
  }

  String get postcode => _postcode;
  set postcode(String code) {
    if (code == null) code = "";
    _postcode = code;
  }

  String get region => _region;
  set region(String region) {
    if (region == null) region = "";
    _region = region;
  }

  String get country => _country;
  set country(String country) {
    if (country == null) country = "";
    _country = country;
  }

  Map<String, dynamic> get toMap => {
        "label": label,
        "street": _street,
        "city": _city,
        "postcode": _postcode,
        "region": _region,
        "country": _country
      };
}

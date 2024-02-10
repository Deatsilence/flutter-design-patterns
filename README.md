<h1 align="center"><a id="head">Design Patterns with Flutter</h1>

- <h2 align="left">Kısaca Design Patterns nedir ?</h2>
  Tasarım desenleri, yazılım geliştirmede yaygın olarak kullanılan önemli araçlardır. Bu desenler, nesnelerin oluşturulmasını, bir araya getirilmesini ve iletişim kurmasını kontrol ederek kod kalitesini, tutarlılığını ve yeniden kullanılabilirliğini artırabilir

- Creational Patterns

  - [Factory Method](#factory-method)
  - [Abstract Factory](#abstract-factory)
  - [Singleton](#singleton)
  - [Builder](#builder)
  - [Prototype](#prototype)

- Structural Patterns

  - [Adapter](#adapter)
  - [Bridge](#bridge)
  - [Composite](#composite)
  - [Decorator](#decorator)
  - [Facade](#fecade)
  - [Flyweight](#flyweight)
  - [Proxy](#proxy)

- Behavioral Patterns

  - [Chain of Responsibility](#chainofresponsibility)
  - [Iterator](#iterator)
  - [Interpreter](#interpreter)
  - [Observer](#observer)
  - Command
  - Mediator
  - State
  - Strategy
  - Template Method
  - Visitor
  - Memento

- <h2 align="left"><a id="factory-method">Factory Method (Creational Patterns)</h2>
  Factory design pattern(Fabrika tasarım deseni) bir nesnenin nasıl oluşturulacağını soyutlaştırmaya yardımcı olan bir yaratımsal tasarım modelidir. Bu, kodunuzun daha esnek ve genişletilebilir olmasını sağlar.

Fabrika tasarım deseninin temel fikri, nesne oluşturma işlemini bir fabrika sınıfına devretmektir. Bu fabrika sınıfı, hangi nesnenin oluşturulacağını belirler.

<h4 align="left">Fabrika tasarım deseninin iki ana bileşeni vardır:</h4>

- **Ürün:** Oluşturulacak nesnedir.
- **Fabrika:** Ürün nesnesini oluşturan sınıftır.

<h5 align="left">Fabrika tasarım deseninin avantajları:</h5>

- Kodunuzu daha esnek ve genişletilebilir hale getirir.
- Nesne oluşturma işlemini soyutlaştırarak kodunuzun daha okunaklı ve anlaşılır olmasını sağlar.
- Yazılım geliştirme sürecini daha verimli hale getirir.

<h5 align="left"> Fabrika tasarım deseninin dezavantajları:</h5>

- Karmaşık uygulamalarda kullanımı zor olabilir.
- Daha fazla kod yazmanıza neden olabilir.

**Örnek Senaryo**

Peki bunu gerçek bir uygulamada, pakette, vb. nasıl uygulayabiliriz ? Ona bakalım. Senaryomuz gereği platforma özgü buton üretmek istiyoruz. Bunun için ilk önce **abstract** bir sınıf oluşturmaya başlıyoruz. İçinde **Widget** döndüren build ismine sahip bir **abstract** method yazıyoruz. Bu method için en temel parametre olarak **onPressed** ve **child** istiyorum. Bu senaryonuza göre değişebilir. Mevcut platformu öğrenmek için `import 'dart:io' show Platform;` ile Platform sınıfını kullanıyorum. Altarnatif olarak `Theme.of(context).platform.` kullanılabilir. Mevcut platforma göre ilgili platforma özel butonu döndüren bir abstract bir factory sınıfımız var.

```dart
abstract class PlatformButton {
  Widget build({required VoidCallback onPressed, required Widget child});

  factory PlatformButton() {
    if (Platform.isAndroid) {
      return AndroidButton();
    } else if (Platform.isIOS) {
      return IOSButton();
    } else {
      return AndroidButton();
    }
  }
}
```

IOS ve Android olmak üzere 2 platforma özel buton sınıflarımızı oluşturup **PlatformButton** sınıfımızı implemente ederek Widget içinde ilgili butonlarımızı döndürdük.

```dart
final class IOSButton implements PlatformButton {
  @override
  Widget build({required VoidCallback onPressed, required Widget child}) => CupertinoButton(
        onPressed: onPressed,
        child: child,
      );
}

final class AndroidButton implements PlatformButton {
  @override
  Widget build({required VoidCallback onPressed, required Widget child}) => ElevatedButton(
        onPressed: onPressed,
        child: child,
      );
}
```

Peki bunu UI tarafında nasıl kullanabiliriz ?

```dart
import 'dart:developer';

import 'package:design_patterns/patterns/factory/platform_button.dart';
import 'package:flutter/material.dart';

class FactoryView extends StatelessWidget {
  FactoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PlatformButton().build(
              onPressed: () => log("Platform Button Pressed"),
              child: const Text("Platform Button"),
            ),
          ],
        ),
      ),
    );
  }
}
```

[Dökümantasyonun başına dön](#head)

- <h2 align="left"><a id="abstract-factory">Abstract Factory (Creational Patterns)</h2>

Soyut fabrika tasarım deseni, birden çok aileden nesne oluşturmak için bir fabrika sınıfı kullanır. Bu desen, nesne oluşturma işlemini soyutlaştırarak kodunuzun daha okunaklı ve esnek olmasını sağlar.

<h4 align="left">Soyut fabrika tasarım deseninin iki ana bileşeni vardır:</h4>

- **Soyut fabrika:** Birden çok aileden nesne oluşturmak için kullanılan bir sınıftır.
- **Somut fabrika:** Soyut fabrikayı somutlaştıran ve belirli bir aileden nesneler oluşturmak için kullanılan bir sınıftır.

<h5 align="left">Soyut fabrika tasarım deseninin avantajları:</h5>

- Kodunuzu daha esnek ve genişletilebilir hale getirir.
- Nesne oluşturma işlemini soyutlaştırarak kodunuzun daha okunaklı ve anlaşılır olmasını sağlar.
- Yazılım geliştirme sürecini daha verimli hale getirir.

<h5 align="left"> Soyut fabrika tasarım deseninin dezavantajları:</h5>

- Karmaşık uygulamalarda kullanımı zor olabilir.
- Daha fazla kod yazmanıza neden olabilir.

**Örnek Senaryo**

Peki bunu gerçek bir uygulamada, pakette, vb. nasıl uygulayabiliriz ? Ona bakalım. İlk bakışta **Factory Method** ile karıştırılması doğal olsa da aralarında ufak bir farklılık var. Bu fark **Factory Method** aynı aile içerisinde bulunması gereken nesneleri soyutlaştırarak üretirken. Örneğin _IOS Button, Android Button, Linux Button, vb._ gibi buton ailesisini kapsayabilir. **Abstract Factory** ise farklı ailelerin nesnelerini soyutlaştırarak üretir. Örneğin _Button, Indicator, vb._ gibi farklı ailele sınıflarını kendi bünyesinde üretebilir. **Factory Method** için yaptığımız platforma özgü butona ek olarak platforma özgü indicator ekledikten sonra bu iki farklı aileye ait componentleri **Abstract Factory** ile üretelim. Bunun için 2 farklı teknik göstereceğim. 1. Teknikte **Singleton + Abstract Factory** design patterns beraber kullanılmaktadır. 2. Teknikte bir class içinde static methodlar kullanılmaktadır.

**1. Teknik (Singleton + Abstract Factory):**
Öncelikle **abstract** bir sınıf olarak **AbstractFactory** sınıfımızı oluşturuyoruz. İçinde **buildButton() ve buildIndicator()** ismine sahip 2 tane \*\*abstract method\*\* oluşturuyoruz.

```dart
abstract class AbstractFactory {
  Widget buildButton({required VoidCallback onPressed, required Widget child});
  Widget buildIndicator();
}
```

Sonrasında **AbstractFactoryImpl2** adında **Singleton** sınıf oluşturup **AbstractFactory** sınıfını implemente ediyoruz.
**AbstractFactoryImpl2** içerisinde ailelere özel Widget döndüren methodlarımızı override ediyoruz.

```dart
final class AbstractFactoryImpl2 implements AbstractFactory {
  AbstractFactoryImpl2._init() {
    log("AbstractFactoryImpl2 Private constructor ran");
  }

  static AbstractFactoryImpl2? _instance;

  static AbstractFactoryImpl2 get instance => _instance ??= AbstractFactoryImpl2._init();

  @override
  Widget buildButton({required VoidCallback onPressed, required Widget child}) {
    return PlatformButton().build(onPressed: onPressed, child: child);
  }

  @override
  Widget buildIndicator() {
    return PlatformIndicator().build();
  }
}

```

Peki bunu UI tarafında nasıl kullanabiliriz ?

```dart
import 'dart:developer';

import 'package:design_patterns/patterns/abstract_factory/abstract_factory.dart';
import 'package:flutter/material.dart';

class AbstractFactoryView extends StatelessWidget {
  const AbstractFactoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AbstractFactoryImpl2.instance.buildButton(
              onPressed: () => log("Platform Button Pressed"),
              child: const Text("Platform Button"),
            ),
            AbstractFactoryImpl2.instance.buildIndicator(),
          ],
        ),
      ),
    );
  }
}

```

**2. Teknik (Abstract Factory):**

```dart
final class AbstractFactoryImpl {
  static Widget buildButton({required VoidCallback onPressed, required Widget child}) {
    return PlatformButton().build(onPressed: onPressed, child: child);
  }

  static Widget buildIndicator() {
    return PlatformIndicator().build();
  }
}

```

Peki bunu UI tarafında nasıl kullanabiliriz ?

```dart
import 'dart:developer';

import 'package:design_patterns/patterns/abstract_factory/abstract_factory.dart';
import 'package:flutter/material.dart';

class AbstractFactoryView extends StatelessWidget {
  const AbstractFactoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AbstractFactoryImpl.buildButton(
              onPressed: () => log("Platform Button Pressed"),
              child: const Text("Platform Button"),
            ),
            AbstractFactoryImpl.buildIndicator(),
          ],
        ),
      ),
    );
  }
}
```

Hangi yöntemin kullanılacağı projenin gereksinimlerine ve diğer parametrelere bağlıdır.

[Dökümantasyonun başına dön](#head)

- <h2 align="left"><a id="singleton">Singleton (Creational Patterns)</h2>
  Singleton tasarım deseni, bir sınıftan yalnızca bir nesnenin oluşturulmasını sağlar. Bu desen, tek bir nesnenin ihtiyaç duyulduğu durumlarda kullanılır.

<h4 align="left">Singleton tasarım deseninin iki ana bileşeni vardır:</h4>

- **Singleton sınıfı:** Yalnızca bir nesnenin oluşturulmasını sağlayan sınıftır..
- **Singleton nesnesi:** Singleton sınıfından oluşturulan tek nesnedir.

<h5 align="left">Singleton tasarım deseninin avantajları:</h5>

-Tek bir nesnenin ihtiyaç duyulduğu durumlarda kullanışlıdır.
-Kodunuzu daha okunaklı ve anlaşılır hale getirir.
-Yazılım geliştirme sürecini daha verimli hale getirir.

<h5 align="left"> Fabrika tasarım deseninin dezavantajları:</h5>

- Karmaşık uygulamalarda kullanımı zor olabilir.
- Daha fazla kod yazmanıza neden olabilir.

**Örnek Senaryo**

Peki bunu gerçek bir uygulamada, pakette, vb. nasıl uygulayabiliriz ? Genelde uygulamanın network katmanı için kullanmak faydalı bir davranıştır. Aşağıda girilen konumlara göre benzer konumları getiren bir network servis katmanı vardır.

```dart
import 'dart:io';

import 'package:design_patterns/patterns/singleton/model/base_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class PredictionsNetworkManager {
  PredictionsNetworkManager._init() {
    final baseOptions = BaseOptions(baseUrl: _baseUrl);
    _dio = Dio(baseOptions);
  }
  static const String _apiKey = "APIKEY";
  static const String _baseUrl = "BASEURL";

  static PredictionsNetworkManager? _instance;
  static PredictionsNetworkManager get instance {
    _instance ??= PredictionsNetworkManager._init();
    return _instance!;
  }

  late Dio _dio;

  Future<dynamic> dioGet<T extends BaseModel>(String place, T model) async {
    try {
      final response = await _dio.get("$_baseUrl=$place&key=$_apiKey");

      switch (response.statusCode) {
        case HttpStatus.ok:
          final responseBody = response.data;
          if (responseBody is List) {
            return responseBody.map((e) => model.fromJson(e)).toList();
          } else if (responseBody is Map) {
            return model.fromJson(responseBody.cast<String, dynamic>()); //! compute will come here
          }
          return responseBody;
        // case HttpStatus.badRequest
        default:
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}

```

Peki bunu UI tarafında nasıl kullanabiliriz ?

```dart
import 'package:design_patterns/patterns/singleton/model/place_model.dart';
import 'package:design_patterns/patterns/singleton/singleton.dart';
import 'package:design_patterns/patterns/singleton/singleton_network_manager.dart';
import 'package:flutter/material.dart';

class SingletonView extends StatefulWidget {
  const SingletonView({super.key});

  @override
  State<SingletonView> createState() => _SingletonViewState();
}

class _SingletonViewState extends State<SingletonView> {
  final s1 = Singleton.instance;
  final s2 = Singleton.instance;
  final s3 = Singleton.instance;

  final s4 = SingletonWithFactory();
  final s5 = SingletonWithFactory();
  final s6 = SingletonWithFactory();

  late final response;
  @override
  void initState() {
    PredictionsNetworkManager.instance.dioGet<Place>("Ankara", Place()).then((value) => response = value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListView.builder(
              itemCount: 1,
              itemBuilder: (BuildContext context, int index) {
                if (response is Place) {
                  return Text("${(response as Place).name}");
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}

```

[Dökümantasyonun başına dön](#head)

- <h2 align="left"><a id="prototype">Prototype (Creational Patterns)</h2>
  Prototype tasarım kalıbı, nesnelerin kopyalarını oluşturmak için bir prototip nesneyi kullanan bir tasarım kalıbıdır. Bu, nesneleri doğrudan oluşturmaktan daha verimli olabilir, özellikle de nesnelerin oluşturulması karmaşık veya zaman alıcıysa.

<h4 align="left">Prototype tasarım deseninin üç ana bileşeni vardır:</h4>
- **Prototip:** Kopyalanacak nesne.
- **Kopyalayıcı:** Prototip nesneyi kopyalayan sınıf.
- **Kullanıcılar:** Kopyalanmış nesneleri kullanan sınıflar.

<h5 align="left">Prototype tasarım deseninin avantajları:</h5>
- Nesnelerin oluşturulmasını daha verimli hale getirir.
- Nesnelerin aynı özelliklerine sahip bir dizi kopya oluşturmayı kolaylaştırır.
- Nesnelerin belirli bir durumdan bağımsız olarak oluşturulmasını sağlar.

<h5 align="left"> Prototype tasarım deseninin dezavantajları:</h5>

- Prototip nesnenin değiştirilmesi, tüm kopyalanmış nesneleri de değiştirebilir.
- Prototip nesnenin özelliği değiştirildiğinde, kopyalanmış nesnelerin özelliklerini de değiştirmek gerekir.

**Örnek Senaryo**

Diyelim ki Person adında bir modelimiz olsun ve sıfırdan bir Person oluşturmadan eğer oluşturulan bir Person varsa direkt olarak ondan kopyası alınabilmek isteniyor.

```dart
import 'package:flutter/material.dart';

@immutable
final class Person {
  final String? name;
  final String? lastName;
  final int? age;
  final String? email;

  const Person({
    required this.name,
    required this.lastName,
    required this.age,
    required this.email,
  });

  Person copyWith({
    String? name,
    String? lastName,
    int? age,
    String? email,
  }) =>
      Person(
          name: name ?? this.name,
          lastName: lastName ?? this.lastName,
          age: age ?? this.age,
          email: email ?? this.email);

  Person clone() => copyWith(name: name, lastName: lastName, age: age, email: email);
}

```

Peki bunu UI tarafında nasıl kullanabiliriz ?

```dart
import 'dart:developer';

import 'package:design_patterns/patterns/prototype/prototype.dart';
import 'package:flutter/material.dart';

class PrototypeView extends StatelessWidget {
  const PrototypeView({super.key});

  @override
  Widget build(BuildContext context) {
    const person1 = Person(name: "mert", lastName: "dogan", age: 23, email: "m@gmail");
    const person2 = Person(name: "mete", lastName: "dogan", age: 35, email: "m@gmail");
    final person3 = person1.clone();
    final person4 = person2.clone();

    log("${person3.name} ${person3.lastName}  ${person3.age}  ${person3.email} ");
    log("${person4.name} ${person4.lastName}  ${person4.age}  ${person4.email} ");

    return const Scaffold(
      backgroundColor: Colors.amber,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [],
        ),
      ),
    );
  }
}

```

```terminal
Output:
[log] mert dogan  23  m@gmail
[log] mete dogan  35  m@gmail
```

[Dökümantasyonun başına dön](#head)

- <h2 align="left"><a id="adapter">Adapter (Structural Patterns)</h2>
  Adapter tasarım deseni, birbiriyle uyumlu olmayan arayüzlere sahip nesnelerin birlikte çalışabilmelerini sağlayan yapısal bir tasarım desenidir. Bu desen, mevcut bir sınıfı veya arayüz sınıfını, eldeki farklı bir arayüz sınıfına uygun hale getirerek tekrar kullanmak amacıyla uygulanır.

Adapter deseni, iki farklı sınıfın veya arayüzün arayüzlerini birbirine benzeterek, bu sınıfların veya arayüzlerin birlikte kullanılmasını sağlar. Bu sayede, mevcut bir sınıfı veya arayüz sınıfını, değiştirmek veya yeniden yazmak zorunda kalmadan, yeni bir sistemde veya projede kullanmak mümkün olur.

<h4 align="left">Adapter tasarım deseninin iki ana bileşeni vardır:</h4>

- **Adapte edilen sınıf veya arayüz:** Adaptör deseninin amacı, bu sınıf veya arayüzü, farklı bir arayüze sahip olacak şekilde uyarlamaktır.
- **Adaptör sınıfı:** Adaptör sınıfı, adapte edilen sınıf veya arayüzü, farklı bir arayüze uygun hale getiren sınıftır.
- **Müşteri sınıfı:** Adaptör sınıfının arayüzünü kullanan sınıftır.

<h5 align="left">Adapter tasarım deseninin avantajları:</h5>

- Mevcut bir sınıfı veya arayüzü değiştirmeden yeni bir sistemde veya projede kullanmayı sağlar.
- Farklı teknolojileri veya platformları bir araya getirmeyi kolaylaştırır.
- Bir sınıfın veya arayüzün işlevselliğini genişletmeyi sağlar.

<h5 align="left"> Adapter tasarım deseninin dezavantajları:</h5>

- Adaptör sınıfı, adapte edilen sınıf veya arayüzün tüm işlevselliğini desteklemek zorundadır.
- Adaptör sınıfı, adapte edilen sınıf veya arayüzün koduna bağımlı olabilir.

**Örnek Senaryo**

Peki bunu gerçek bir uygulamada, pakette, vb. nasıl uygulayabiliriz ? Ona bakalım. Senaryomuz gereği iki farklı API miz olsun.
isimleri **PostAPI1** ve **PostAPI2** olsun. **PostAPI1** Youtube videolarının başlığını (_title_) ve tanımını (_description_) getirsin. **PostAPI2** ise Mediumda bulunan postların başlığını (_header_) ve tanımını (_bio_) getirsin. Gördüldüğü üzere temelde iki API bir adet başlık ve tanım dönmesine rağmen iki API'dan dönen **Key** leri farklıdır. _title - header_, _description - bio_ şeklindedir. Amacımız bu iki apiden dönen verileri sanki tek bir apiden dönüyormuşcasına birbirine benzetmektir.

Öncelikle ilgili verinin geleceği bir model oluşturmamız gerekiyor.

```dart
@immutable
final class Post {
  final String title;
  final String bio;

  Post({
    required this.title,
    required this.bio,
  });
}
```

Sonrasında API larımızı tanımlıyoruz.

```dart
class PostAPI1 {
  String getYoutubePosts() {
    return '''
    [
      {
        "title": "Automatic code generation with Fluuter",
        "description": "Generate automatically"
      },
      {
        "title": "Twitter Clone code generation with Fluuter",
        "description": "Generate automatically"
      }
    ]
    ''';
  }
}

class PostAPI2 {
  String getMediumPosts() {
    return '''
    [
      {
        "header": "Medium header1",
        "bio": "Medium bio1"
      },
      {
        "header": "Medium header2",
        "bio": "Medium bio2"
      }
    ]
    ''';
  }
}
```

Bir adet **abstract** bir API sınıfı yaparak içine getPosts() soyut methodunu koyuyoruz. Bunu birazdan her API a ait **Adapter** sınıflarında kulanacağız.

```dart
abstract class IPostAPI {
  List<Post> getPosts();
}
```

Her API a ait **Adapter** sınıfı oluşturuyoruz.

```dart
class PostAPI1Adapter implements IPostAPI {
  final _api = PostAPI1();

  @override
  List<Post> getPosts() {
    final data = jsonDecode(_api.getYoutubePosts()) as List;

    return data
        .map(
          (e) => Post(
            title: e["title"],
            bio: e["description"],
          ),
        )
        .toList();
  }
}

class PostAPI2Adapter implements IPostAPI {
  final _api = PostAPI2();

  @override
  List<Post> getPosts() {
    final data = jsonDecode(_api.getMediumPosts()) as List;

    return data
        .map(
          (e) => Post(
            title: e["header"],
            bio: e["bio"],
          ),
        )
        .toList();
  }
}
```

Gerekli **Adapter** işlemlerini yaptıktan sonra UI tarafında kullanılacak olan **PostAPI** isimli bir sınıf oluşturuyoruz. Bu sınıfa **IPostAPI** implemente ediliyor. Senaryomuz gereği her API için **Adapter** sınıflarından birer nesne üretiliyor. getPost() override methodu ile bu API lardan dönen verilerimizi kullanıma hazır hale getirmiş oluyoruz.

Peki bunu UI tarafında nasıl kullanabiliriz ?

```dart
import 'package:design_patterns/patterns/adapter/adapter.dart';
import 'package:flutter/material.dart';

class AdapterView extends StatelessWidget {
  const AdapterView({super.key});

  @override
  Widget build(BuildContext context) {
    final postAPI = PostAPI();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: postAPI.getPosts().length,
                itemBuilder: (BuildContext context, int index) {
                  final post = postAPI.getPosts()[index];
                  return ListTile(
                    title: Text(post.title),
                    subtitle: Text(post.bio),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

```

[Dökümantasyonun başına dön](#head)

- <h2 align="left"><a id="builder">Builder (Creational Patterns)</h2>
  Builder deseni, karmaşık bir nesnenin inşasını iki sınıfa ayıran bir yapısal tasarım modelidir.

<h4 align="left">Builder tasarım deseninin iki ana bileşeni vardır:</h4>

- **Builder sınıfı:** Bu sınıf, nesnenin inşasını gerçekleştirir.
- **Nesne sınıfı:** Bu sınıf, inşa edilen nesnenin temsilini sağlar.

Builder sınıfı, nesnenin inşası için bir dizi yöntem sağlar. Bu yöntemler, nesnenin özelliklerini ayarlamak için kullanılır. Nesne inşa edildiğinde, Builder sınıfı build() yöntemini çağırır. Bu yöntem, nesnenin inşasını tamamlar ve nesneyi döndürür.

<h5 align="left">Builder tasarım deseninin avantajları:</h5>

- Karmaşık nesneleri adım adım oluşturmayı kolaylaştırır.
- Aynı nesnenin farklı temsillerinin, inşa sürecini değiştirmeden oluşturulmasına olanak tanır.
- Karmaşık nesnelerin inşa sürecini test etmeyi kolaylaştırır.
- Okunabilirlik ve Bakım Kolaylığı: Builder tasarım deseni, nesne oluşturma işlemini daha okunaklı ve bakımı daha kolay hale getirir. Her bir adım açıkça tanımlanır ve değiştirilmesi gerektiğinde sadece ilgili Builder sınıfı değiştirilir.

<h5 align="left">Builder tasarım deseninin dezavantajları:</h5>

- Basit nesneler için Builder kullanmak gereksiz bir karmaşıklık yaratabilir. Bu tasarım deseni, yalnızca karmaşık nesneleri oluşturmak gerektiğinde mantıklıdır.

- **Performans:** Builder deseninin performansı, nesnelerin inşasında kullanılan yöntemlerin sayısına bağlı olarak etkilenebilir. Çok sayıda yöntem kullanılıyorsa, bu performansı olumsuz yönde etkileyebilir.

<h5 align="left">Builder deseni, aşağıdaki durumlarda kullanılabilir:</h5>

- Nesnenin farklı temsillerinin oluşturulması gerekiyorsa.
- Nesnenin inşa sürecinin test edilmesi gerekiyorsa.

<h5 align="left">Builder desenini kullanmak için aşağıdaki adımları takip edebilirsiniz:</h5>

- Builder sınıfını oluşturun. Bu sınıf, nesnenin inşası için gerekli tüm yöntemleri içermelidir.
- Nesne sınıfını oluşturun. Bu sınıf, inşa edilen nesnenin temsilini sağlamalıdır.
- Builder sınıfını kullanarak nesneyi inşa edin.

**Örnek Senaryo**

Peki bunu gerçek bir uygulamada, pakette, vb. nasıl uygulayabiliriz ? Ona bakalım. Bir senaryo gereği çektiğimiz fotoğrafı bir butona 3 defa bastıktan sonra silmek istiyoruz ve fotoğrafın silinme tarihini doldurmak istiyoruz. Bunu yapmadan önce adım adım nesnemizi doldurmak istiyoruz. 3 defa butona bastığımızda fotoğrafın silme tarihinin dolduğunu göreceğiz. Bu işlemi builder tasarım desenini kullanarak yapmamız bize daha fazla **esneklik**, **okunabilirlik** kazandırmış oldu.

Senaryomuz gereği \_InformationsOfPhoto widget sınıfına ilgili fotoğrafı ileteceğimiz için sealed bir class oluşturuyorum. Normal şartlarda bir adet yaratılacak sınıf ve bir adet builder sınıfı yapmanız yeterli olacaktır.

```dart
sealed class Photo {
  String? name;
  Size? size;
  DateTime? createdDate;
  DateTime? deletedDate;
}
```

Ardından NotPhotoPhotoBuilder isimli bir sınıf oluşturuyoruz. Bu sınıf builder methodundan oluşturacağımız bir sınıftır. Üyelerimizi almak için Photo sınıfını implement ediyoruz.

```dart
final class PhotoBuilder implements Photo {
  @override
  String? name;
  @override
  Size? size;
  @override
  DateTime? createdDate;
  @override
  DateTime? deletedDate;

  PhotoBuilder({
    this.name,
    this.size,
    this.createdDate,
    this.deletedDate,
  });
```

Sonrasında bir adet PhotoBuilder sınıfı oluşturuyoruz ve her üye için setter methodları oluşturuyoruz. Son olarak bir adet build methodu oluşturuyoruz. Bu bize nesnemizi geri döndürecek.

```dart
final class PhotoBuilder implements Photo {
  @override
  String? name;
  @override
  Size? size;
  @override
  DateTime? createdDate;
  @override
  DateTime? deletedDate;

  PhotoBuilder({
    this.name,
    this.size,
    this.createdDate,
    this.deletedDate,
  });

  PhotoBuilder setName({required String name}) {
    this.name = name;
    return this;
  }

  PhotoBuilder setSize({required Size size}) {
    this.size = size;
    return this;
  }

  PhotoBuilder setCreatedDate({required DateTime createdDate}) {
    this.createdDate = createdDate;
    return this;
  }

  PhotoBuilder setDeletedDate({required DateTime deletedDate}) {
    this.deletedDate = deletedDate;
    return this;
  }

  NotPhotoPhotoBuilder build() => NotPhotoPhotoBuilder(
        name: name,
        size: size,
        createdDate: createdDate,
        deletedDate: deletedDate,
      );
}
```

[Dökümantasyonun başına dön](#head)

- <h2 align="left"><a id="bridge">Bridge (Structural Patterns)</h2>
  Bridge design pattern, birbirinden bağımsız iki hiyerarşik yapıyı (abstraction ve implementation)birleştirmek ve birbirinden ayrı olarak değiştirilebilmelerini sağlamak amacıyla kullanılan birtasarım desenidir. Bu desen, bir nesnenin soyutlamasını (abstraction) ve bu soyutlama üzerindeçalışan işlevselliği (implementation) ayırarak daha esnek bir yapı oluşturmayı hedefler.

Fabrika tasarım deseninin temel fikri, nesne oluşturma işlemini bir fabrika sınıfına devretmektir. Bu fabrika sınıfı, hangi nesnenin oluşturulacağını belirler.

<h4 align="left">Bridge tasarım deseninin 4 ana bileşeni vardır:</h4>

**Abstraction (Soyutlama):** Bu, istemcinin bir arayüzle etkileşim kurduğu ve işlevselliğin tam olarak gerçekleşmediği katmandır.

**Refined Abstraction (İyileştirilmiş Soyutlama):** Abstraction'ın alt sınıflarıdır ve spesifik bir durumu ele alır.

**Implementation (Uygulama):** Bu, soyutlamayı gerçekten uygulayan katmandır.

**Concrete Implementation (Somut Uygulama):** Implementation'ın alt sınıflarıdır ve spesifik bir durumu gerçekten uygular.

<h5 align="left">Bridge tasarım deseninin avantajları:</h5>

- Esneklik ve Genişletilebilirlik: Soyutlama ve uygulama, birbirinden bağımsız olarak değiştirilebilir, bu da sistemdeki değişiklikleri kolaylaştırır.

- Gizlilik (Encapsulation): Uygulama detayları soyutlamadan gizlenebilir. İstemci, yalnızca soyutlamayla etkileşimde bulunur.

- Değişiklik Yönetimi: Bir tarafın değişmesi, diğerini etkilemez. Örneğin, sadece soyutlama değişebilir ve uygulama değişmeden kalabilir ya da tam tersi.

<h5 id="bridge" align="left"> Bridge tasarım deseninin dezavantajları:</h5>

- Komplekslik: Desenin uygulanması bazen karmaşıklığa yol açabilir, özellikle projenin boyutu küçükse veya gereksinimler basitse, bu komplekslik gereksiz olabilir.

**Örnek Senaryo**

Peki bunu gerçek bir uygulamada, pakette, vb. nasıl uygulayabiliriz ? Ona bakalım. Senaryomuz gereği projemizde Youtube, Netflix, Amazon Prime, vb. gibi uygulamaların kendi video işleme teknolojisi yerine kendi video işleme teknolojisini kullanmak istiyoruz. Bunu yaparken projemize farklı video işleme teknolojisine sahip uygulamaların ileride projemize dahil olabilme potansiyelini de göz önüne almamız gerekiyor. Bu noktada **Birdge Design Pattern** devreye giriyor. Amacımız yenilenebilen ve her yenilendiğinde eski kod yapısının işleyişini devam ettirebilmesini sağlamaktır.

Senaryomuz gereği kendi **Video Processor** teknolojiz için bir **abstract** sınıf yazıyoruz. İçinde **process(String videoFile)** isimli bir method imzası barındırıyoruz.

```dart
abstract class VideoProcessor {
  void process({required String videoFile});
}
```

ardından **Video** için bir interface tanımlıyoruz. İçinde **Video Processor** teknolojimizi zorunlu olarak implemente edilmesini sağlıyoruz. Ardından video için **play(String videoFile)** isimli içi boş bir method tanımlıyoruz.

```dart
interface class Video {
  VideoProcessor processor;

  Video({required this.processor});

  void play({required String videoFile}) {}
}
```

buraya kadar implemente edilecek yapıları kurgulamış olduk. Şimdi Netflix ve Youtube için senaryomuzu işletmeye başlayalım. Hem Netflix Hem de Youtube için ayrı ayrı sınıflar oluşturup **Video** interface'inden kalıtım alıyoruz.

```dart
class NetflixVideo implements Video {
  @override
  VideoProcessor processor;

  NetflixVideo({
    required this.processor,
  });

  @override
  void play({required String videoFile}) {
    processor.process(videoFile: videoFile);
  }
}

class YoutubeVideo implements Video {
  @override
  VideoProcessor processor;

  YoutubeVideo({
    required this.processor,
  });

  @override
  void play({required String videoFile}) {
    processor.process(videoFile: videoFile);
  }
}
```

Şimdi sıra **Video Processor** teknolojimizi ilgili video/videolar için implemente etmekte. Bunun için HD VE UHD(4K) video kalitesi desteği verdiğimizi düşünelim. Her Video kalitesi için **Video Processor** **abstract** sınıfımızdan **kalıtım** alıyoruz.

```dart
class HDProcessor implements VideoProcessor {
  @override
  void process({required String videoFile}) {
    log("$videoFile is Processing HD Processor");
  }
}

class UHD4KProcessor implements VideoProcessor {
  @override
  void process({required String videoFile}) {
    log("$videoFile is Processing UHD 4K Processor");
  }
}
```

Senaryomuz gereği projemizde şimdilik 2 farklı şirket, 2 farklı video kalitesi için kendi **Video Processor** teknolojimizi kullanıyoruz.

Sonrasında Amazon Prime da uygulamamızda yer edindi ve bunu QUHD 8K video kalitesi ile beraber yapmak istediğimizi varsayalım.

```dart
class AmazonPrimeVideo implements Video {
  @override
  VideoProcessor processor;

  AmazonPrimeVideo({
    required this.processor,
  });

  @override
  void play({required String videoFile}) {
    processor.process(videoFile: videoFile);
  }
}

class QUHD8KProcessor implements VideoProcessor {
  @override
  void process({required String videoFile}) {
    log("$videoFile is Processing UHD 8K Processor");
  }
}

```

Peki bunu UI Tarafında nasıl kullanabiliriz ?

```dart
import 'package:design_patterns/patterns/bridge/bridge.dart';
import 'package:flutter/material.dart';

class BridgeView extends StatefulWidget {
  const BridgeView({super.key});

  @override
  State<BridgeView> createState() => _BridgeViewState();
}

class _BridgeViewState extends State<BridgeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bridge Design Pattern"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
              onPressed: () {
                Video youtubeVideo = YoutubeVideo(processor: HDProcessor());
                youtubeVideo.play(videoFile: "abc.mp4");

                const text = "The video playing as HD Quality in Youtube";
                const snackbar = SnackBar(content: Text(text));

                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(snackbar);
              },
              child: const Text("Watch a HD Video in Youtube"),
            ),
            OutlinedButton(
              onPressed: () {
                Video netflixVideo = NetflixVideo(processor: UHD4KProcessor());
                netflixVideo.play(videoFile: "abc.mp4");

                const text = "The video playing as UHD 4K Quality in Netflix";
                const snackbar = SnackBar(content: Text(text));

                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(snackbar);
              },
              child: const Text("Watch a UHD 4K Video in Netflix"),
            ),
            OutlinedButton(
              onPressed: () {
                Video amazonPrimeVideo = AmazonPrimeVideo(processor: QUHD8KProcessor());
                amazonPrimeVideo.play(videoFile: "abc.mp4");

                const text = "The video playing as QUHD 8K Quality in Amazon Prime";
                const snackbar = SnackBar(content: Text(text));

                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(snackbar);
              },
              child: const Text("Watch a QUHD 8K Video in Amazon Prime"),
            ),
          ],
        ),
      ),
    );
  }
}

```

<img src="https://user-images.githubusercontent.com/78795973/282323920-b934655b-f8c4-4fe7-b12b-5b0034b67ba5.png" width="250"> <img src="https://user-images.githubusercontent.com/78795973/282323923-7b57245f-f14f-40e3-9758-a4db458fce52.png" width="250"> <img src="https://user-images.githubusercontent.com/78795973/282323927-2cbcd660-b69f-42a1-ae8a-8b223fb60eda.png" width="250">

[Dökümantasyonun başına dön](#head)

- <h2 align="left"><a id="composite">Composite (Structural Patterns)</h2>
  Kompozit tasarım deseni, tek tek nesneleri ve nesne bileşimlerini aynı şekilde ele almanızı sağlayan güçlü bir yapısal desendir. Hem parçaları (tek tek nesneler) hem de bütünleri (bileşik nesneler) aynı şekilde ele alabileceğiniz nesne hiyerarşileri oluşturmanıza yardımcı olur.

<h4 align="left">Composite tasarım deseninin üç ana bileşeni vardır:</h4>

- **Abstract Interface:** Bu modelin temelidir. Hiyerarşideki hem bireysel hem de bileşik tüm nesnelerin uyması gereken ortak davranışı tanımlar.
- **Concrete Classes:** Bunlar, belirli nesne türlerini temsil eden soyut arayüzün uygulamalarıdır. Her sınıf arayüz yöntemleri için kendi davranışını tanımlar.
- **Client Code:** Bu, hiyerarşideki nesnelerle etkileşime giren koddur. İstemciler yalnızca soyut arabirimi görür ve hem tek tek nesnelere hem de kompozitlere aynı şekilde davranmalarına izin verir

<h5 align="left">Composite tasarım deseninin avantajları:</h5>

- İstemcilerin farklı nesne türlerini farklı şekilde işlemeleri gerekmez.
- Daha esnek ve yeniden kullanılabilir kod Ortak arayüze uyan yeni öğe türlerini kolayca ekleyebilirsiniz.
- Daha kolay bakım bir öğe türündeki değişiklikler mutlaka diğerlerini etkilemez.
- Geliştirilmiş kod okunabilirliği: Kod, verilerinizin gerçek dünya yapısını yansıtır.

<h5 align="left"> Composite tasarım deseninin dezavantajları:</h5>

- Büyük bir hiyerarşik tarama yapmayalım, performans etkileyici olabilir.

**Örnek Senaryo**

Örneğin aynı gruba ait olduğunu hissettiğiniz belli kategoriler var. Mesela bir e-ticaret uygulamasında belli kategoriler olur. Bu kategorilerin altında ilgili kategoriyle ilgili alt kategori veya başlıklar bulunur. Bu yapıları daha kolay ve esnek bir şekilde inşa etmek için devreye **Composite Design Pattern** giriyor. İster ilgili nesneleri tek tek ele alın, ister kategorileri çoklu olarak ele alıp hiyerarşiyi insa edebiliriz. Amacımız bu esnekliği sağlamak olacak.

Şimdi senaryomuz gereği ilk inşa edeceğimiz şey ortak yapıyı sağlayacak olan **Abstract Class** olacaktır.

```dart

import 'package:flutter/material.dart';

/// Abstract class representing an item that can be added to a shopping cart.
abstract class CartItem<T extends dynamic> {
  /// Returns the name of the item.
  String getName();

  /// Returns the price of the item.
  double getPrice();

  /// Builds and returns the widget representation of the item.
  T buildItemWidget();
}

```

Sonrasında herhangi bir ürün için **Product** isimli bir class yaratıyoruz. Bu class oluşturmuş olduğumuz **CartItem** isimli **Abstract** sınıftan kalıtım alarak tek bir ürün için yapıyı inşa etmeye başlıyoruz. İçinde ilgili ürünle ilgili bilgiler tutacağından gerekli değişkenleri yazıyoruz. Unutmayın senaryomuz bir E-ticaret uygulaması olacak. **buildItemWidget()** methodu generic şekilde döndüğünden ürün için bir **Card** yazmayı tercih ediyoruz.

```dart
/// Represents a single product that can be added to a shopping cart.
final class Product implements CartItem<dynamic> {
  final String title;
  final String description;
  final String imageUrl;
  final double price;
  int quantity;

  /// Constructs a new instance of the [Product] class.
  Product({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.price,
    this.quantity = 0,
  });

  @override
  String getName() => title;

  @override
  double getPrice() => price * quantity;

  @override
  dynamic buildItemWidget() => Card(
        child: ListTile(
          leading: Image.network("https://picsum.photos/200", width: 60, height: 60),
          title: Text(title),
          subtitle: Text(description),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Quantity: $quantity'),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {}, // Implement quantity increment
              ),
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () {}, // Implement quantity decrement
              ),
            ],
          ),
        ),
      );
}
```

Sıra toplu olarak bir ürün ağacı inşa etmeye geldi. Senaryomuzda **Araba** ve **Masaüstü Bilgisayar** kategorilerini ele alacağız. Bu kategoriler kendi içinde bir çok parçaya(teker, anakart, vb.) ayrılabileceğinden
ilgili yapıları ortak bir şekilde yönetmek için **Category** isimli **CartItem** **Abstract** sınıfından kalıtım alan bir sınıf oluşturuyoruz. **buildItemWidget()** methodu **ExpansionPanel** dönerek **final List<CartItem<dynamic>> children** listesinde bulunan diğer benzer ürünleri tek ortak kategori başlığı adı altında topluyoruz.

```dart
final class Category implements CartItem<dynamic> {
  final String name;
  final List<CartItem<dynamic>> children;
  bool isExpanded; // Track if category is expanded to show children

  /// Constructs a new instance of the [Category] class.
  Category({
    required this.name,
    required this.children,
    this.isExpanded = false,
  });

  @override
  String getName() => name;

  @override
  double getPrice() => children.fold(0, (sum, child) => sum + child.getPrice());

  @override
  dynamic buildItemWidget() => ExpansionPanel(
        headerBuilder: (context, isExpanded) => Text(name),
        body: Column(
          children: children.map((child) => child.buildItemWidget() as Widget).toList(),
        ),
        isExpanded: isExpanded,
      );
}
```

UI tarafında nasıl bir kullanım senaryosu olabilir hadi beraber bakalım. Öncelikle ilgili kategori ve tekli ürünlerimizi ayarlamak için bir liste oluşturuyoruz. Daha önce söylediğim gibi kategorilerimiz **Desktop Computer** ve **Car** şeklinde olacak. Alt ürünlerinde ilgili ürünler olacak.

```dart
final List<Category> categories = [
    Category(
      name: "Desktop Computer",
      children: [
        Product(
          title: "Main Board",
          description: "Part of the computer",
          imageUrl: "imageUrl#1",
          price: 1000,
        ),
        Product(
          title: "CPU",
          description: "Part of the computer",
          imageUrl: "imageUrl#2",
          price: 2000,
        )
      ],
    ),
    Category(
      name: "Car",
      children: [
        Product(
          title: "Electiric car",
          description: "type of the cars",
          imageUrl: "imageUrl#1",
          price: 9000,
        ),
        Product(
          title: "wheel",
          description: "Part of the cars",
          imageUrl: "imageUrl#2",
          price: 1000,
        )
      ],
    ),
  ];
```

Kategorileri ve tekli ürünü **ExpansionPanelList** kullanarak görüntülüyoruz.

```dart
Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            ExpansionPanelList(
              expansionCallback: (int index, bool isExpanded) {
                setState(() {
                  categories[index].isExpanded = !categories[index].isExpanded;
                });
              },
              children: [
                categories[CategoryType.desktopComputer.index].buildItemWidget(),
                categories[CategoryType.car.index].buildItemWidget(),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: product.buildItemWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
```

<img src="https://user-images.githubusercontent.com/78795973/287830530-ea687dcd-3c1a-4541-b034-6e5a34dcf0ac.png" width="250"> <img src="https://user-images.githubusercontent.com/78795973/287832109-fa70e1ec-4af4-445a-925f-e1d6eba93576.png" width="250">

[Dökümantasyonun başına dön](#head)

- <h2 align="left"><a id="decorator">Decorator (Structural Patterns)</h2>
  Decorator tasarım deseni, bir nesneye dinamik olarak yeni özellikler eklemek için kullanılan bir tasarım desenidir. Bu, temel nesnenin işlevselliğini değiştirmeden veya genişletmeden yapılır. Decorator tasarım deseni, doğru bir şekilde kullanıldığında esneklik ve sürdürülebilirlik sağlar. Ancak, her tasarım deseni gibi, uygulama gereksinimlerinize uygun olup olmadığını değerlendirmek önemlidir.

<h4 align="left">Decorator tasarım deseninin 3 ana bileşeni vardır:</h4>

- **Abstract Component Interface(OPTIONAL):** Bu interface tamamen opsiyonel olarak kullanılabilir. Dekore edilecek component için **abstract** bir davranış sergiletebilirsiniz..
- **Concrete Component:** Dekore edilecek componentin saf halidir. İsteğe göre **abstract component interface** implemente edilebilir.
- **Abstract Decorator Class:** Dekore edilecek component için dekor sınıflarına bir **abstract** katman sağlar. Kullanılacak dekor sınıfları bu sınıftan kalıtım alırlar.
- **Decorator Class:** Dekore edilecek componenti dekore eder. Dekore edilecek component için birden fazla **dekoratör** sınıfı yapılabilir.

<h5 align="left">Decorator tasarım deseninin avantajları:</h5>

- Esneklik (Flexibility): Decorator deseni, nesnelere dinamik olarak davranış eklemenin esnek bir yolunu sağlar. Yeni sorumluluklar eklemek veya var olanları kaldırmak, sınıfları değiştirmeden yapılabilir.
- Açık Kapalı Prensibi (Open-Closed Principle): Decorator deseni, sınıfların açık olmasını (yeni davranışları eklemeye izin vermesi) ve kapalı olmasını (mevcut kodu değiştirmemesi) sağlar. Bu, kodunuzun daha sürdürülebilir olmasına yardımcı olur.
- Birleşik Nesneler (Composite Objects): Decorator deseni, bir nesnenin üzerine başka nesneleri birleştirebilmenizi sağlar. Bu, bir nesneyi farklı kombinasyonlarda birleştirerek karmaşık yapılar oluşturmanıza olanak tanır.

<h5 align="left"> Decorator tasarım deseninin dezavantajları:</h5>

- Kod Karmaşası (Code Complexity): Decorator deseni kullanıldığında, bir nesnenin üzerine ek sorumluluklar eklemek için bir dizi sınıf oluşturulur. Bu durum zamanla kod karmaşıklığına yol açabilir.
- Fazla Sayıda Küçük Nesne (Lots of Small Objects): Decorator deseni, her dekoratör sınıfı için bir sınıf yaratılmasını gerektirir. Bu durum, çok sayıda küçük nesnenin oluşmasına ve proje boyutunda artışa neden olabilir.
- Mantıksal Sıralama (Ordering of Wrappers): Decorator deseninde dekoratörlerin sırasının önemi vardır. Bazı durumlarda dekoratörlerin sırasının yanlış belirlenmesi, beklenmeyen sonuçlara yol açabilir.
- Birleşik Nesnelerin Karmaşıklığı (Complexity of Composite Objects): Birleşik nesnelerin karmaşıklığı, birden çok dekoratör eklenerek artabilir. Bu durum, anlaması ve bakımı zor bir yapıya yol açabilir.

**Örnek Senaryo**

Örnek senaryomuzda yine bir E-ticaret uygulamasını ele alalım. Bu E-ticaret uygulamasında bir ürünün birden fazla davranışı(UI bakımından görünüşü veya mantıksal olarak) olabilir. Örneğin bir ürünün stoğu bitebilir, satışta olabilir veya o ürünün yeni bir ürün olduğu belirtilebilir. İşte bu durumlarda aynı nesne için farklı dekorlar üreterek kodumuzu iyileştirirken, feature bir düşünce katacağız. Bunun için **Decorator Design Pattern**'i kullanacağız.

İlk olarak bir ProductCard isimli **Abstract Component Interface** yapıyorum.

```dart
/// Abstract component class
/// [ProductCard] is the base class for all concrete components, including
abstract class ProductCard extends StatelessWidget {
  const ProductCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context);
}
```

Sonrasında **ProductCard**'ı kalıtım alan **Concrete Component** sınıfını tasarlıyorum. Bu sınıf Ürünümüzün saf hali olacaktır. Ürünümüzün bir resmi, ismi ve fiyatı olacak.

```dart
/// Concrete component class
/// [SimpleProductCard] is a simple product card with an image, name, and price.
base class SimpleProductCard extends ProductCard {
  final String imageUrl;
  final String productName;
  final double price;

  const SimpleProductCard({
    Key? key,
    required this.imageUrl,
    required this.productName,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Image.network(imageUrl, height: 150, width: 150),
          Text(productName),
          Text("$price"),
        ],
      ),
    );
  }
}
```

Sonrasında en önemli aşama olan dekoratör sınıfları tarafından kalıtım alınacak **Abstract Decorator** sınıfını yapıyoruz. Bu sınıf 1 adet **ProductCard** alıyor ve aldığı componentin **build()** methodunu çağırıyor. Bu aşama kritik, çünkü birden fazla dekoratörün uygulanması sırasında her dekoratörün diğer dekoratörlerden bağımsız çalışmasını sağlıyoruz.

```dart
/// Decorator abstract class
/// [ProductCardDecorator] is the base class for all concrete decorators,
abstract class ProductCardDecorator extends ProductCard {
  final ProductCard productCard;

  const ProductCardDecorator({required this.productCard, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return productCard.build(context);
  }
}
```

Sıra **Decorator** sınıflarımızı yazmaya geldi. Senaryomuz gereği bir ürünün stokta yok, yeni ürün veya satışta olması bekleniyor. Her olasılık için 1 adet **Decorator** tasarlıyoruz. İlk olarak **OnSaleDecorator(Satışta)** Dekoratörünü tasarlıyoruz. Bu dekoratör ilgili ürünün sol üst köşesine basit bir **On Sale** yazısı ekliyoruz.

```dart
/// Concrete decorator class for on sale products
/// [OnSaleDecorator] adds a red "On Sale!" label to the top left corner of the
final class OnSaleDecorator extends ProductCardDecorator {
  const OnSaleDecorator({required ProductCard productCard, Key? key})
      : super(productCard: productCard, key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        super.build(context),
        const Positioned(
          left: 10,
          top: 10,
          child: Text(
            "On Sale!",
            style: TextStyle(
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }
}
```

Aynı benzerlikte işlemleri **OutOfStockProductDecorator** Dekoratörü içinde uyguluyoruz. Bu dekoratördeki amacımız ürünün resminin hafif bir opacity ye sahip olmasıdır. Bu sayede kullanıcı ürünün stokta olmadığını anlayacaktır.

```dart
/// Concrete decorator class for featured products
/// [OutOfStockProductDecorator] adds a 50% opacity to the product card.
final class OutOfStockProductDecorator extends ProductCardDecorator {
  const OutOfStockProductDecorator({required ProductCard productCard, Key? key})
      : super(productCard: productCard, key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.5,
      child: super.build(context),
    );
  }
}
```

Son olarak ilgili ürün yeni bir ürünse, ürünün sağ üst köşesinde bir ikon çıkartıyoruz.

```dart
/// Concrete decorator class for new products
/// [NewProductDecorator] adds a yellow "New!" label to the top right corner of
final class NewProductDecorator extends ProductCardDecorator {
  const NewProductDecorator({required ProductCard productCard, Key? key})
      : super(productCard: productCard, key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        super.build(context),
        const Positioned(
          top: 0,
          right: 0,
          child: Icon(
            Icons.new_releases,
            color: Colors.orange,
            size: 30,
          ),
        ),
      ],
    );
  }
}
```

Peki bunu UI tarafında nasıl kullanabiliriz ? Örnek olarak birden fazla dekoratörü de mantık çerçevesinde kullanabiliriz.

```dart
class DecoratorView extends StatefulWidget {
  const DecoratorView({super.key});

  @override
  State<DecoratorView> createState() => _DecoratorViewState();
}

final class _DecoratorViewState extends State<DecoratorView> {
  @override
  Widget build(BuildContext context) {
    // simpleCard is a simple product card with an image, name, and price.
    const ProductCard simpleCard = SimpleProductCard(
      imageUrl: "https://picsum.photos/200",
      productName: "Example Product",
      price: 19.99,
    );

    // complesCard combines multiple decorators to create a complex product card.
    const ProductCard complexCard = OnSaleDecorator(
      productCard: NewProductDecorator(
        productCard: simpleCard,
      ),
    );

    // featureCard is a featured product card with opacity and a shadow.
    const ProductCard featureCard = OutOfStockProductDecorator(
      productCard: simpleCard,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        children: <Widget>[
          simpleCard.build(context),
          complexCard.build(context),
          featureCard.build(context),
        ],
      ),
    );
  }
}

```

<img src="https://user-images.githubusercontent.com/78795973/290292483-048dd72f-eb9c-49d9-bf5c-aa2f473e64b3.png" width="250">

[Dökümantasyonun başına dön](#head)

- <h2 align="left"><a id="fecade">Fecade (Structural Patterns)</h2>
  Facade tasarım kalıbı, karmaşık sistemleri basit bir arayüzle yönetmek için kullanılan biryapısal tasarım kalıbıdır. Bu kalıp, sistemlerin kullanımını kolaylaştırmak ve karmaşıklığınıgizlemek amacıyla kullanılır. Facadetasarım kalıbı, özellikle büyük yazılım sistemlerinde, altsistemlerin doğrudan erişimini sınırlayarak ve bir dizi alt sistem işlevini tek bir, yüksekseviyeli arayüzle birleştirerek kodun anlaşılabilirliğini ve kullanımınıkolaylaştırır.

Facade, karmaşık alt sistemlerin basitleştirilmiş bir arayüzle dış dünyaya sunulmasını sağlar. Kullanıcılar, alt sistemlerin karmaşık yapıları ve işleyişleri hakkında derinlemesine bilgi sahibi olmadan, bu sistemleri kullanabilirler.

<h4 align="left">Fecade tasarım deseninin iki ana bileşeni vardır:</h4>

- **Fecade:** Dış dünyaya sunulan basitleştirilmiş arayüzü sağlar. Alt sistemlerin işlevlerini birleştirir ve kullanıcıya sunar.
- **Alt Sistemler:** Facade arayüzü tarafından kapsanan karmaşık işlevselliği barındıran sınıflar. Bunlar doğrudan kullanıcı tarafından çağrılmaz, ancak Facade sınıfı tarafından yönetilir.

<h5 align="left">Fecade tasarım deseninin avantajları:</h5>

- Karmaşık sistemlerin daha basit bir arayüzle kullanılmasını sağlar.
- Alt sistemlerle doğrudan etkileşimi azaltır, böylece kodun bakımı ve güncellenmesi kolaylaşır.
- Alt sistemlerin ayrı ayrı test edilmesini kolaylaştırır.

<h5 align="left"> Fecade tasarım deseninin dezavantajları:</h5>

- Ekstra bir soyutlama katmanı, bazen performans kaybına yol açabilir.
- Çok basitleştirilmiş bir arayüz, bazı durumlarda alt sistemlerin tüm özelliklerine erişimi kısıtlayabilir.

**Örnek Senaryo**

Peki bunu gerçek bir uygulamada, pakette, vb. nasıl uygulayabiliriz ? Ona bakalım. Senaryomuz gereği teknik alt yapımızda birden fazla alt sistemizin (Network katmanımızın) olduğunu varsayalım. Bunlar Hava durumu için **WeatherService**, haberler için **NewsService**, Kullanıcı için **UserProfileService** olsun. Bu katmanları tek bir katmanda toplayarak kullanabiliriz. Bu katmanımızın ismi **ApiFacadeService** olsun. **ApiFacadeService** katmanını kullanarak diğer alt sistemlere erişerek işlemlerimizde kullanacağız. Gerçek veriden kaçınarak ana mantığı kod üzerinde oturtalım.

**WeatherService** `Future<Weather> getWeather()` method imzasına sahip bir methoda sahiptir ve bize **Weather** modelini döner.

```dart
import 'package:design_patterns/patterns/fecade/model/weather.dart';

final class WeatherService {
  Future<Weather> getWeather() {
    return Future.value(Weather());
  }
}

```

**NewsService** `Future<List<News>> getLatestNews()` method imzasına sahip bir methoda sahiptir ve bize **News** modelinin listesini döner döner.

```dart
import 'package:design_patterns/patterns/fecade/model/news.dart';

final class NewsService {
  Future<List<News>> getLatestNews() {
    return Future.value(
      List.generate(
        10,
        (index) => News(),
      ),
    );
  }
}
```

**UserProfileService** `final class UserProfileService` method imzasına sahip bir methoda sahiptir ve bize **UserProfile** modelini döner.

```dart
import 'package:design_patterns/patterns/fecade/model/user_profile.dart';

final class UserProfileService {
  Future<UserProfile> getUserProfile() {
    return Future.value(UserProfile());
  }
}

```

Sıra **ApiFacadeService** katmanını oluşturmaya geldi. Bu katmanda kullanmak istediğimiz alt katmanları kullanıyoruz. Bu sayede alt katmanlara erişimi sınırlayarak kullanabiliyoruz.

```dart
final class ApiFacadeService {
  final WeatherService _weatherService = WeatherService();
  final NewsService _newsService = NewsService();
  final UserProfileService _userProfileService = UserProfileService();

  Future<Weather> getWeather() => _weatherService.getWeather();
  Future<List<News>> getNews() => _newsService.getLatestNews();
  Future<UserProfile> getUserProfile() => _userProfileService.getUserProfile();
}
```

Peki bunu UI tarafında nasıl kullanabiliriz ? Örnek olması açısından **FutureBuilder** vb. yapılarda kullanabilirsiniz.

```dart
final class FecadeView extends StatefulWidget {
  const FecadeView({super.key});

  @override
  State<FecadeView> createState() => _FecadeViewState();
}

class _FecadeViewState extends State<FecadeView> {
  ApiFacadeService? _apiFacadeService;

  @override
  void initState() {
    super.initState();
    _apiFacadeService = ApiFacadeService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _apiFacadeService != null
            ? FutureBuilder(
                future: _apiFacadeService!.getNews(),
                //! future: _apiFacadeService!.getUserProfile(),
                //! future: _apiFacadeService!.getWeather(),
                builder: (context, snapshot) => const Text("data"),
              )
            : const Text('an error occured'),
      ),
    );
  }
}
```

[Dökümantasyonun başına dön](#head)

- <h2 align="left"><a id="flyweight">Flyweight (Structural Patterns)</h2>
  Flyweight tasarım kalıbı, bellek kullanımını optimize etmek amacıyla kullanılan bir yapısal tasarım kalıbıdır. Bu kalıp, nesneler arasında paylaşılabilir durumları (intrinsic state) ve paylaşılamayan durumları (extrinsic state) ayırarak, tekrar eden durumları azaltmayı ve böylece bellek kullanımını verimli bir şekilde azaltmayı hedefler. Özellikle birçok benzer nesnenin oluşturulduğu durumlarda önem kazanır. Flutter'da Flyweight tasarım kalıbını kullanmanın bir örneği, özellikle widget ağaçlarında tekrar eden widget'ları optimize etmek olabilir. Flutter uygulamalarında, bazı widget'lar özellikle liste veya ızgara görünümlerinde tekrar tekrar kullanılır. Bu durumda, Flyweight kalıbını uygulayarak, bellek kullanımını optimize edebilir ve uygulamanın performansını artırabiliriz.

<h4 align="left">Flyweight tasarım deseninin 4 ana bileşeni vardır:</h4>

- **Flyweight Interface:** Paylaşılan nesnelerin ortak bir arayüzünü tanımlar.
- **Concrete Flyweight:** Flyweight interface'ini uygulayan ve iç durumu (intrinsic state) saklayan sınıf.
- **Flyweight Factory:** Flyweight nesnelerini yaratır ve yönetir. Aynı nesne önceden yaratılmışsa, yeniden kullanılmasını sağlar.
- **Client:** Flyweight nesnelerini kullanır. Dış durumu (extrinsic state) sağlar ve onu Flyweight ile birleştirir.

<h5 align="left">Flyweight tasarım deseninin avantajları:</h5>

- Benzer nesnelerin tekrar tekrar yaratılmasını engelleyerek bellek kullanımını azaltır.
- Daha az nesne yaratıldığı için performans artar.

<h5 align="left"> Flyweight tasarım deseninin dezavantajları:</h5>

- Tasarım karmaşıklaşabilir.
- İç ve dış durumların yönetimi zorlaşabilir.

**Örnek Senaryo**

Peki bunu gerçek bir uygulamada, pakette, vb. nasıl uygulayabiliriz ? Ona bakalım. Senaryomuz gereği bir sosyal medya uygulaması yapmak istiyoruz. Bu uygulamada gönderileri gösteren bir liste düşünelim. Her gönderide yorum, beğeni ve paylaşım gibi işlemler için aynı ikonlar, tekrar tekrar oluşturmak yerine **Flyweight** tasarım kalıbı ile optimize edeceğiz.

İlk olarak **Flyweight Interface** katmanını yapmakla başlıyoruz. İçinde **Widget** dönen **Widget createWidget(Color color, double size)** method imzasına sahip bir method yerleştiriyoruz.

```dart
abstract class Flyweight {
  Widget createWidget(Color color, double size);
}
```

Sonrasında sıra, **Concrete Flyweight** katmanına geliyor. Bu katmanda **iç durum(intrinsic state)** i saklayacağız. Bizim durumumuzda bu bir icon olacak. Aynı zamanda **Flyweight** katmanını **implement** ederek **createWidget** methodunu **@override** ediyoruz.

```dart
final class IconFlyweight implements Flyweight {
    final IconData iconData;

    IconFlyweight(this.iconData);

    @override
    Widget createWidget(Color color, double size) {
        return Icon(iconData, color: color, size: size);
    }
}
```

Sıra **Flyweight Factory** katmanında **Flyweight** nesnelerini yaratmaya geldi. Burada eğer daha önce yaratılmış bir nesne varsa **\_icons** map içinden çekiliyor. Eğer ilk defa gelen bir nesneyse map'e ekleniyor.

```dart
final class IconFactory {
    final Map<IconData, IconFlyweight> _icons = {};

    IconFlyweight getIcon({required IconData iconData}) {
        if (!_icons.containsKey(iconData)) {
            _icons[iconData] = IconFlyweight(iconData);
        }
        return _icons[iconData];
    }
}
```

Peki bunu UI (**Client**) tarafında nasıl kullanabiliriz ?

```dart
final class FlyWeightView extends StatelessWidget {
  final IconFactory iconFactory = IconFactory();

  FlyWeightView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverList.builder(
              itemBuilder: (context, index) {
                final post = SocialMediaPost(
                  title: 'Post $index',
                  content:
                      '-$index Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                );

                return ListTile(
                  leading: iconFactory
                      .getIcon(iconData: Icons.account_circle)
                      .createWidget(Colors.blue, 24.0),
                  title: Text(post.title),
                  subtitle: Text(post.content),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      iconFactory
                          .getIcon(iconData: Icons.comment)
                          .createWidget(Colors.grey, 20.0),
                      const SizedBox(width: 8),
                      iconFactory
                          .getIcon(iconData: Icons.thumb_up)
                          .createWidget(Colors.grey, 20.0),
                      const SizedBox(width: 8),
                      iconFactory
                          .getIcon(iconData: Icons.share)
                          .createWidget(Colors.grey, 20.0),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

```

10 tane listtileın her biri 4 farklı icon içermekte. Normal koşullarda 4x10 dan 40 tane icon nesnesi üretilecekti fakat **Flyweight** sayesinde bu sayı farklı icon sayısı kadar yani 4 e düştü.

<img src="https://github.com/Deatsilence/flutter-design-patterns/assets/78795973/72f1007d-a5fc-4f1d-b3f9-215dc7bcf365" width="250"> <img src="https://github.com/Deatsilence/flutter-design-patterns/assets/78795973/b5a1d964-e308-4445-8a8e-6f2965cb140a" width="250">

[Dökümantasyonun başına dön](#head)

- <h2 align="left"><a id="proxy">Proxy (Structural Patterns)</h2>
  Proxy tasarım kalıbı, bir nesneye erişimi kontrol etmek veya bu erişimi başka bir nesne üzerinden yapmak için kullanılan yapısal bir tasarım kalıbıdır. Bu kalıp, bir nesnenin işlevselliğini genişletmek veya değiştirmek için kullanılırken, orijinal nesnenin yapısını değiştirmeden çalışır. Proxy, gerçek nesneye bir tür arayüz ya da temsilci olarak hizmet eder.

<h4 align="left">Proxy tasarım deseninin üç ana bileşeni vardır:</h4>

- **Subject Interface:** Gerçek nesne ve proxy'nin uygulaması gereken arayüz.
- **Real Subject:** İstemcinin erişmek istediği asıl nesne.
- **Proxy:** Gerçek nesneye erişimi kontrol eden ya da onun yerine geçen nesne.

<h5 align="left">Proxy tasarım deseninin avantajları:</h5>

- Proxy, gerçek nesnelere erişimi kontrol etmenize olanak tanır. Örneğin, güvenlik kontrolleri veya erişim izinleri ekleyebilirsiniz.
- Pahalı kaynakların yüklenmesini erteleyerek uygulamanın performansını artırabilir. Özellikle büyük nesneler veya ağ üzerinden gelen veriler için faydalıdır.
- Özellikle uzak sunuculardan veri çekme işlemlerinde, gereksiz ağ trafiğini azaltarak performansı artırabilir. Örneğin, verileri önbelleğe alarak (caching) aynı verinin tekrar tekrar yüklenmesini önleyebilir.
- Proxy, gerçek nesne üzerinde yapılan işlemleri loglayabilir ve ekstra güvenlik katmanları ekleyebilir.
- Kullanıcılar veya diğer nesneler, proxy'nin varlığından habersiz olarak gerçek nesnelerle etkileşimde bulunabilir.

<h5 align="left"> Proxy tasarım deseninin dezavantajları:</h5>

- Proxy kalıbının uygulanması, sistemin genel karmaşıklığını artırabilir. Basit durumlar için, bu ekstra karmaşıklık gereksiz olabilir.
- Proxy sınıfı, bazı durumlarda ekstra işlem yükü oluşturabilir. Özellikle, her istekte proxy üzerinden geçmek, işlem süresini artırabilir.
- Proxy'nin doğru şekilde yönetilmesi gereklidir, özellikle caching veya güvenlik gibi özellikler eklenmişse. Yanlış yönetilen bir proxy, veri tutarsızlığına veya güvenlik açıklarına yol açabilir.
- Proxy kalıbını doğru bir şekilde uygulamak, bazı durumlarda tasarımın anlaşılmasını ve genişletilmesini zorlaştırabilir.
- Proxy'nin eklediği katmanlar, bazı durumlarda test süreçlerini daha karmaşık hale getirebilir.

**Örnek Senaryo**

Peki bunu gerçek bir uygulamada, pakette, vb. nasıl uygulayabiliriz ? Ona bakalım. Flutter'da bir gerçek hayat senaryosu olarak, uzak bir API'ye erişim sağlamak için bir proxy kullanılabilir. Örneğin, bir uygulama, uzak bir sunucudan veri çekerken, bu istekleri yönetmek ve gerekirse cache mekanizması eklemek için bir proxy kullanabilir. Bu senaryoda bir **Weather** API kullandığımızı varsayalım.

Öncelikle **Subject Interface** olarak **WeatherSerice** isimli bir **interface** oluşturuyoruz. Bu interface API'den verileri çekmek için **getWeatherData** isimli bir method'a sahip. Bu katmanı orijinal nesneye ve proxy katmanına implemente edeceğiz.

```dart
abstract class WeatherService {
    Future<String> getWeatherData();
}
```

akabinde **WeatherApiService** isminde bir **Real Subject** katmanını yazarken **Subject Interface** i implemente ediyoruz.

```dart
final class WeatherApiService implements WeatherService {
    @override
    Future<String> getWeatherData() async => 'Sunny, 25°C';
}
```

Sıra **Proxy Design Pattern**'in kilit noktası olan **Proxy** katmanına geldi. Proxy katmanı API isteklerini yakalar ve gerekirse cache mekanizması ekler veya istekleri loglar.

```dart
final class WeatherServiceProxy implements WeatherService {
    final WeatherApiService _weatherApiService = WeatherApiService();
    String _cachedData;

    @override
    Future<String> getWeatherData() async {
        if (_cachedData == null) {
            print('Fetching data from API...');
            _cachedData = await _weatherApiService.getWeatherData();
        } else {
            print('Returning cached data...');
        }
        return _cachedData;
    }
}

```

Peki bunu nasıl kullanabiliriz ? Bu örnekte, WeatherServiceProxy sınıfı, API'den veri çekme işlemini kontrol eder ve veriyi cache'ler. İlk istekte gerçek API'ye erişir ve veriyi alır, sonraki isteklerde ise cache'lenmiş veriyi kullanır. Bu yaklaşım, özellikle sık sık aynı veriye ihtiyaç duyulan durumlarda performansı artırabilir ve ağ trafiğini azaltabilir. Proxy tasarım kalıbı, bu tür senaryolarda verimli bir çözüm sunar. Bizim durumumuzda 5 defa çekilen verinin ilk kez çekildikten sonra cache e atanarak geriye kalan 4 isteğin cevabını cache den hızlıca elde edeceğiz. Bu sayede gereksiz yere ağ trafiğine yüklenmeyeceğiz.

```dart

final class ProxyView extends StatelessWidget {
  final IWeatherService _weatherService = WeatherServiceProxy();

  ProxyView({super.key});

  Future<String> getWeatherFiveTimes() async {
    var results = [];

    for (var i = 0; i < 5; i++) {
      var data = await _weatherService.getWeatherData();
      results.add(data);
    }
    return results.join('\n');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
      ),
      body: Center(
        child: FutureBuilder<String?>(
          future: getWeatherFiveTimes(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              // Veriyi ekranda göster
              return Text('Weather: ${snapshot.data}');
            }
          },
        ),
      ),
    );
  }
}
```

[Dökümantasyonun başına dön](#head)

<img src="https://github.com/Deatsilence/flutter-design-patterns/assets/78795973/8db12fb1-b5ba-44b7-be36-8040afe72990" width="250">
<img src="https://github.com/Deatsilence/flutter-design-patterns/assets/78795973/27fed6e3-eb3a-4161-a893-cee09d291f27" width="250">

- <h2 align="left"><a id="chainofresponsibility">Chain of Responsibility (Behavioral Patterns)</h2>
  Flutter'da Sorumluluk Zinciri tasarım desenini daha detaylı bir şekilde ele alalım. Bu desen, özellikle büyük ve modüler Flutter uygulamalarında, farklı widget'lar veya ekranlar arasında gelen istekleri veya komutları yönetmek için kullanışlıdır.

<h4 align="left">Chain of Responsibility tasarım deseninin üç ana bileşeni vardır:</h4>

- **Handler:** İsteği nasıl işleyeceğini ve isteği zincirdeki bir sonraki işleyiciye nasıl geçireceğini tanımlayan bir arayüz.
- **Concrete Handlers:** Handler arayüzünü uygulayan sınıflar. Her işleyici, isteği işleyip işlemeyeceğine veya onu zincirdeki bir sonraki işleyiciye geçireceğine karar verir.
- **Client:** İsteği başlatan ve zincirin ilk işleyicisine gönderen kişi veya sistem.

<h5 align="left">Çalışma Mekanizması:</h5>

- Müşteri, isteği zincirdeki ilk işleyiciye gönderir.
- Her işleyici, isteği kontrol eder ve onu işleyip işlemeyeceğine karar verir.
- Eğer bir işleyici isteği işleyebilirse, işlemi yapar ve süreç sona erer.
- Eğer işleyici isteği işleyemezse, onu zincirdeki bir sonraki işleyiciye iletir.
- Bu süreç, bir işleyicinin isteği işleyene kadar veya zincir sona erene kadar devam eder.

<h5 align="left">Chain of Responsibility tasarım deseninin avantajları:</h5>

- Gönderen ve alıcı bağımsız hale gelir, sistemde gevşek bağlantıyı teşvik eder.
- Yeni işleyiciler eklemek veya mevcut olanların sırasını değiştirmek kolaydır.
- Her işleyicinin tek bir sorumluluğu vardır, bu da kodun bakımını kolaylaştırır.

<h5 align="left"> Proxy tasarım deseninin dezavantajları:</h5>

- İstek, birden fazla işleyiciden geçebilir, bu da performansı etkileyebilir.
- İstek çeşitli işleyicilerden geçtiği için hata ayıklaması zor olabilir.

**Örnek Senaryo**

Peki bunu gerçek bir uygulamada, pakette, vb. nasıl uygulayabiliriz ? Ona bakalım. Farklı türde kullanıcı girdilerini (jestler, buton tıklamaları, metin girişleri) işleyen bir Flutter uygulamasını düşünün. Uygulama, bu girdileri işlemek için Sorumluluk Zinciri modelini kullanabilir.

Sorumluluk Zinciri deseninin temelini oluşturan **Handler (İşleyici)** arayüzü, her bir **Concrete Handlers** sınıfın uygulaması gereken temel metotları tanımlar. Flutter'da bu, genellikle bir abstract class şeklinde yapılır. Bizim durumumuzda **InteractionHandler** bizim **Handler** **abstarct** sınıfımız olacak. Bu soyut sınıf **Concrete Handlers**'ler tarafından kalıtım alınacak. **setNextHandler** zincirler arasında bağlantı kurmaya yarayan bir method olacak. Bu sayede uyumsuz bir durum oluştuğunda bir sonraki zincir çalışacak.

```dart
/// [CommandHandler] is the abstract class for all the handlers.
abstract class InteractionHandler {
  InteractionHandler? nextHandler;

  void handleInteraction(String interactionType, BuildContext context);

  void setNextHandler(InteractionHandler handler) {
    nextHandler = handler;
  }
}
```

akabinde **Concrete Handlers** sınıflarımızı tanımlıyoruz. Bizim durumumuzda örnek olması açısından **ButtonInteractionHandler** ve **FormInteractionHandler** olmak üzere 2 farklı **Concrete Handlers** sınıfımızı yazıyoruz. Bu sınıflardan **ButtonInteractionHandler** kullanılrsa senaryo gereği ekranda bir **AlertBox** çıkartmak istiyoruz. Eğer **FormInteractionHandler** sınıfı kullanılırsa submit yaparak _Form submitted_ logunu yazdırmak istiyoruz. **interactionType** Bulunamazsa **handleUnrecognizedInteraction** methodu çalışarak ilgili bilgilendirmeyi yapıyoruz.

```dart
/// [ButtonInteractionHandler] is a concrete handler.
final class ButtonInteractionHandler extends InteractionHandler {
  @override
  void handleInteraction(String interactionType, BuildContext context) {
    if (interactionType == 'buttonClick') {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const AlertDialog(
            title: Text("Button Clicked"),
            content: Text("Button interaction handled."),
          );
        },
      );
    } else if (nextHandler != null) {
      nextHandler!.handleInteraction(interactionType, context);
    } else {
      handleUnrecognizedInteraction(interactionType, context);
    }
  }
}

/// [FormInteractionHandler] is a concrete handler.
final class FormInteractionHandler extends InteractionHandler {
  @override
  void handleInteraction(String interactionType, BuildContext context) {
    if (interactionType == 'formSubmit') {
      // Form submit logic
      log("Form submitted.");
    } else if (nextHandler != null) {
      nextHandler!.handleInteraction(interactionType, context);
    } else {
      handleUnrecognizedInteraction(interactionType, context);
    }
  }
}
```

Peki bunu UI tarafında nasıl bir senaryoda kullanabiliriz ? **Click Me**, **Submit Form** ve **Unknown** olmak üzere 3 adet butonumuzun olduğunu varsayalım. Öncelikle bir adet **ButtonInteractionHandler** oluşturuyoruz ve **interactionType** ını **buttonClick** yapıyoruz. Bu butonun amacı eğer **buttonClick** mevcutsa bir **AlertDialog** göstermektir. Eğer mevcut handlerda **interactionType** teknik olarak desteklenmiyorsa bir sonraki handler işlenecektir. **interactionType** hiç bir şekilde desteklenmiyorsa bunu kullanıcıya **handleUnrecognizedInteraction** ile bildiriyoruz.

```dart
/// [ChainOfResponsibilityView] is the view that shows the Chain of Responsibility Pattern.
final class ChainOfResponsibilityView extends StatefulWidget {
  const ChainOfResponsibilityView({super.key});

  @override
  State<ChainOfResponsibilityView> createState() => _ChainOfResponsibilityViewState();
}

class _ChainOfResponsibilityViewState extends State<ChainOfResponsibilityView> {
  @override
  Widget build(BuildContext context) {
    var buttonHandler = ButtonInteractionHandler();
    var formHandler = FormInteractionHandler();

    buttonHandler.setNextHandler(formHandler);

    return Scaffold(
      appBar: AppBar(title: const Text("Chain of Responsibility in Flutter")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => buttonHandler.handleInteraction('buttonClick', context),
              child: const Text('Click Me'),
            ),
            ElevatedButton(
              onPressed: () => buttonHandler.handleInteraction('formSubmit', context),
              child: const Text('Submit Form'),
            ),
            ElevatedButton(
              onPressed: () => buttonHandler.handleInteraction('unknown', context),
              child: const Text('unknown'),
            ),
          ],
        ),
      ),
    );
  }
}
```

Butonların yukarıdan aşağıya göre tıklanılması

<img src="https://github.com/Deatsilence/flutter-design-patterns/assets/78795973/a7c5ad17-3eca-4382-84cb-3350ca789a70" width="250"> <img src="https://github.com/Deatsilence/flutter-design-patterns/assets/78795973/9549a990-f535-47ba-a93c-9acd0cf8983e" width="250"> <img src="https://github.com/Deatsilence/flutter-design-patterns/assets/78795973/78626739-f4df-4929-8c2c-3c47bb45643c" width="250">

[Dökümantasyonun başına dön](#head)

- <h2 align="left"><a id="iterator">Iterator(Creational Patterns)</h2>
  Iterator deseni, davranışsal bir tasarım desenidir ve bir koleksiyonun (liste veya ağaç gibi) elemanlarına, altında yatan yapısını açığa çıkarmadan sıralı bir şekilde erişim sağlar. Bu desen, yineleme mantığını koleksiyondan ayırarak, koleksiyonu dolaşmak için standart bir yol sunar.

<h4 align="left">Iterator tasarım deseninin 4 ana bileşeni vardır:</h4>

- **Iterator:** next(), hasNext() gibi yineleme için gerekli standart operasyonları tanımlar.
- **Concrete Iterator:** Iterator arayüzünü uygular ve koleksiyondaki mevcut pozisyonun takibini yapar.
- **Aggregate:** Bir Iterator nesnesi oluşturmak için bir arayüz tanımlar.
- **Concrete Aggregate:** Aggregate arayüzünü uygular ve ilgili Somut Iterator'ın bir örneğini döndürür.

<h5 align="left">Iterator tasarım deseninin avantajları:</h5>

- Tek Sorumluluk İlkesi: Bir koleksiyon üzerinde yineleme yapma sorumluluğunu koleksiyondan ayırır.
- Esneklik: Farklı yineleme stratejilerini desteklemek için farklı türlerde iterator'lar uygulanabilir.
- Bağımsızlık: Müşteri kodu, koleksiyonla iterator arayüzü üzerinden etkileşimde bulunur ve koleksiyonun formuna bağımlılığı azalır.

<h5 align="left"> Iterator tasarım deseninin dezavantajları:</h5>

- Özellikle basit döngüler kullanılarak yinelenebilecek basit koleksiyonlar için kodu karmaşıklaştırabilir.
- Etkin bir şekilde uygulanmazsa, performans üzerinde ek yük oluşturabilir.

**Örnek Senaryo**

Örneğin, bir fotoğraf galerisi uygulamasını düşünün, bu uygulama resimleri bir k carousel'de gösteriyor. Resimler bir listede saklanabilir ve her bir resmi göstermek için bir iterator kullanılabilir. Biz bu durumda **Iterator Design Pattern** kullanarak resimleri **moveNext()** kullanarak kullanıcıya göstereceğiz.

Öncelikle galeride göstereceğimiz fotoğraf modelini oluşturuyoruz ve her fotoğrafın bir url si olduğunu varsayalım.

```dart
/// [Photo] is a simple model class that holds the url of a photo.
@immutable
final class Photo {
  final String url;
  const Photo(this.url);
}
```

Sonrasında **PhotoCollection** isimli, **Aggregate** bileşenini yazıyoruz.
**PhotoCollection**, koleksiyonun kendisini, **getIterator**() **Iterator** bileşenini, Iterator oluşturma yeteneğini temsil eder.

```dart
/// [PhotoCollection] is the Concrete Aggregate.
final class PhotoCollection {
  final List<Photo> _photos = [];

  void addPhoto(Photo photo) {
    _photos.add(photo);
  }

  /// [getIterator] returns an iterator for the collection.
  Iterator<Photo> getIterator() => _photos.iterator;

  int get length => _photos.length;
}
```

Akabinde **Concrete Iterator** bileşenimize **Iterator<Photo>** sınıfını implemente ederek somut bir uygulama elde etmiş oluyoruz. Bunun sonucunda koleksiyon üzerinde gezinmek için gerekli mantığı içererek fotoğrafları görüntülememizi sağlıyoruz.

```dart
/// [PhotoIterator] is Concrete Iterator
final class PhotoIterator implements Iterator<Photo> {
  final List<Photo> _photos;
  int _current = 0;

  PhotoIterator(this._photos);

  @override
  Photo get current => _photos[_current];

  @override
  bool moveNext() {
    if (_current < _photos.length - 1) {
      _current++;
      return true;
    }
    return false;
  }
}

```

Peki bunu UI tarafında nasıl kullanabiliriz ? Öncelikle **IteratorView** isimli bir view sayfası oluşturuyoruz. İçinde GridView.builder kullanarak resimlerimizi iterate ederek görüntülüyoruz.

```dart
/// [IteratorView] is Iterator View.
final class IteratorView extends StatelessWidget {
  final PhotoCollection photos;

  const IteratorView({required this.photos, super.key});

  @override
  Widget build(BuildContext context) {
    var iterator = photos.getIterator();

    return Scaffold(
      appBar: AppBar(title: const Text("Iterator in Flutter")),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
        ),
        shrinkWrap: true,
        itemCount: photos.length,
        itemBuilder: (context, index) {
          if (iterator.moveNext()) {
            return Image.network(iterator.current.url);
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}

```

**IteratorView** _PhotoCollection_ parametresi aldığı için öncesinde resimlere ait url leri ekliyoruz.

```dart
PhotoCollection()
          ..addPhoto(
            const Photo('https://picsum.photos/200'),
          )
          ..addPhoto(
            const Photo('https://picsum.photos/200'),
          )
          ..addPhoto(
            const Photo('https://picsum.photos/200'),
          )
          ..addPhoto(
            const Photo('https://picsum.photos/200'),
          ),
```

<img src="https://github.com/Deatsilence/flutter-design-patterns/assets/78795973/2d48efc0-9950-491b-a060-5fd7f192e384" width="250">

[Dökümantasyonun başına dön](#head)

- <h2 align="left"><a id="interpreter">Interpreter (Behavioral Patterns)</h2>
  Interpreter tasarım deseni, bir dil için dilbilgisi tanımlamamızı ve bu dildeki ifadeleri işleyen bir yorumlayıcı sağlamamızı sağlayan bir davranışsal tasarım desenidir.

<h4 align="left">Interpreter tasarım deseninin 4 ana bileşeni vardır:</h4>

- **Expression Interface:** Bu arayüz, belirli bir bağlamı yorumlama yöntemini bildirir. Interpreter deseninin çekirdeğidir.
- **Concrete Expression Classes:** Bu sınıflar İfade arayüzünü uygular ve dildeki özel kuralları yorumlar.
- **Context Class(optional):** Bu sınıf, yorumlayıcının geneline ait bilgileri içerir.
- **Client:** İstemci, dilin dilbilgisini tanımlayan belirli bir cümleyi temsil eden sözdizimi ağacını oluşturur. Ağaç, Somut İfade sınıflarının örneklerinden oluşur.

<h5 align="left">Interpreter tasarım deseninin avantajları:</h5>

- Dilbilgisi kuralları ve yorumlayıcı, ihtiyaç duyulduğunda kolayca değiştirilebilir ve yeni ifadeler eklenebilir.
- Kodun modüler ve tekrar kullanılabilir olmasını sağlar.
- Karmaşık ifadelerin işlenmesi için optimize edilebilir.

<h5 align="left"> Interpreter tasarım deseninin dezavantajları:</h5>

- Karmaşık diller için yorumlayıcı geliştirmek zor olabilir.
- Basit ifadeler için yorumlayıcı, doğrudan koddan daha yavaş olabilir.

**Örnek Senaryo**

Normal koşullarda **Interpreter Design Pattern** _programlama dillerinde_, _SQL sorgularında_, _Matematiksel ifadelerde_, _Oyun motorlarında_ daha çok kullanılır fakat bizim şu anki odağımız **Flutter** olduğu için **Flutter Framework** ü üzerinde **Interpreter Design Pattern** i kullanmaya çalışacağız. Senaryomuz gereği kullanıcıların metin tabanlı bir dil kullanarak özelleştirilebilir widget yapılarını tanımlamasına olanak tanıyan bir mobil uygulama düşünelim. Kullanıcılar, belirli widget türlerini, özelliklerini ve düzenlerini belirten basit bir dili kullanarak arayüzlerini dinamik olarak oluşturabilirler. Örneğin, kullanıcı `"Text: Deatsilence"` gibi bir ifade yazarak bir yazı göstermek isteyebilir veya `"Image: https://picsum.photos/200"` yazarak bir resim göstermek isteyebilir.

İlk olarak **WidgetExpression** isminde bir **Expression Interface** tanımlıyoruz. **WidgetExpression** içinde Widget döndüren _interpret()_ isimli bir method imzası yazıyoruz. Bu interface **Concrete Expression** sınıfları tarafından implemente edilecek.

```dart
/// [WidgetExpression] is the interface for the expression
abstract class WidgetExpression {
  Widget interpret();
}
```

Sonrasında **ConcreteExpressionText** ve **ConcreteExpressionImage** isimli iki adet **Concrete Expression Class** oluşturuyoruz ve **WidgetExpression** isimli soyut sınıfı implemente ediyoruz. **Concrete Expression** sınıflarının içerisinde _interpret_ methodunu _override_ ediyoruz ve kullanıcıdan gelen text scriptine göre **Text veya Image** döndürüyoruz. Bunu başka Widgetlar için de yapabiliriz ama senaryomuz gereği bu ikisi özelinde devam ediyoruz.

```dart
/// [ConcreteExpressionText] is the concrete expression for the text
final class ConcreteExpressionText implements WidgetExpression {
  final String text;
  final TextStyle style;

  ConcreteExpressionText({required this.text, required this.style});

  @override
  Widget interpret(BuildContext? context) => Text(text, style: style);
}

/// [ConcreteExpressionButton] is the concrete expression for the button
final class ConcreteExpressionImage implements WidgetExpression {
  final String url;

  ConcreteExpressionImage({
    required this.url,
  });

  @override
  Widget interpret(BuildContext? context) => Image.network(url, width: 100, height: 100);
}
```

akabinde kullanıcıdan gelen scriptleri yorumlamak için **WidgetParser** sınıfının içine **parseScript()** isimli bir method ekliyoruz.

```dart
final class WidgetParser {
  List<WidgetExpression> parseScript(String script) {
    List<WidgetExpression> expressions = [];
    for (String line in script.split('\n')) {
      line = line.trim();
      if (line.isEmpty) continue;

      /// for example: Text("Hello World")
      if (line.startsWith("Text:")) {
        String text = line.substring(5, line.length);
        expressions.add(
          ConcreteExpressionText(
            text: text,
            style: const TextStyle(fontSize: 20),
          ),
        );
        continue;
      }

      /// for example: Image:https://example.com/image.png
      if (line.startsWith("Image:") && line.contains("https://")) {
        String url = line.substring(6, line.length);
        debugPrint(url);
        List<String> parts = url.split(',');
        String urlTrimmed = parts[0].trim();
        expressions.add(ConcreteExpressionImage(url: urlTrimmed));
        continue;
      }
    }
    return expressions;
  }
}
```

Son olarak bunları UI tarafında nasıl kullanabiliriz ? Ona bakalım. Örneğin bir **TextField** üzerinden kullanııcdan bazı scriptler alarak yorumlayalım. Yorumlama sonucunda kullanıcıya image veya text gösterelim.

```dart

final class InterpreterView extends StatefulWidget {
  const InterpreterView({super.key});

  @override
  State<InterpreterView> createState() => _InterpreterViewState();
}

class _InterpreterViewState extends State<InterpreterView> {
  String? _script;
  List<WidgetExpression>? _expressions;

  @override
  void initState() {
    super.initState();
    _script = "";
    _expressions = WidgetParser().parseScript(_script ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Interpreter Pattern"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: TextEditingController(text: _script),
              onChanged: (value) {
                _script = value;
              },
              decoration: const InputDecoration(
                labelText: "Command Script",
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _expressions = WidgetParser().parseScript(_script ?? "");
                setState(() {});
              },
              child: const Text("Comment the script"),
            ),
            const SizedBox(height: 16.0),
            if (_expressions != null && _expressions!.isNotEmpty)
              _expressions!.first.interpret(context),
          ],
        ),
      ),
    );
  }
}

```

- Kullanıcı text göstermek için **Text:** keywordunun ardından herhangi bir yazı gelince ilgili yazıyı ekranda gösterecektir.

- Kullanıcı bir image göstermek için **Image:** keywordunun ardından bir url vermek zorundadır. Url de bulunan resmi ekranda gösterecektir

<img src="https://github.com/Deatsilence/flutter-design-patterns/assets/78795973/1323d690-0800-4599-b4a0-520d6827c655" width="250"> <img src="https://github.com/Deatsilence/flutter-design-patterns/assets/78795973/5cf8b3ba-e99f-43e9-8ece-596b4daf9459" width="250">

[Dökümantasyonun başına dön](#head)

- <h2 align="left"><a id="observer">Observer(Behavioral Patterns)</h2>
  Observer tasarım deseni, Flutter uygulamalarınızda durum değişikliklerini yönetmek için güçlü bir araçtır. Bir nesnenin (Konu) durumunda bir değişiklik olduğunda, bağlı birden fazla nesneyi (Gözlemciler) bilgilendiren iletişim sistemi kurarak reaktif ve verimli bir sistem oluşturur.

<h4 align="left">Observer tasarım deseninin iki ana bileşeni vardır:</h4>

- **Subject:** Bu bileşen, gözlemcilerin abone olduğu ve durum değişiklikleri hakkında onları bilgilendiren nesnedir. Konu, içerdiği verilerdeki herhangi bir değişikliği takip eden ve bu değişiklikleri gözlemcilere bildiren bir arayüz sağlar.
- **Observer:** Gözlemci, konunun durumundaki değişiklikleri takip eden ve buna tepki veren nesnelerdir. Bu nesneler, genellikle bir arayüzü (Observer Interface) uygular ve bu arayüz, konunun durumu değiştiğinde çağrılan metodları içerir.
- **Client:** Bu bileşen, Observer tasarım kalıbını kullanarak uygulama mantığını yönetir. Müşteri, genellikle konu nesnelerini oluşturur, gözlemcileri bu konulara abone eder ve konunun durumunu günceller.

<h5 align="left">Observer tasarım deseninin avantajları:</h5>

- Observer kalıbı, konu ve gözlemciler arasında zayıf bir bağlantı sağlar. Bu, birinin değiştirilmesinin diğerini doğrudan etkilememesi anlamına gelir, böylece uygulamanın bakımı ve genişletilmesi kolaylaşır.
- Aynı gözlemci, farklı konuları takip edebilir ve bir konu birden fazla gözlemciye sahip olabilir. Bu esneklik, kodun yeniden kullanılabilirliğini artırır.
- Gözlemciler, çalışma zamanında konulara abone olabilir ve abonelikten çıkabilirler. Bu, dinamik ve değişken uygulama gereksinimlerini destekler.
- Observer kalıbı, uygulamanın farklı bölümlerini soyutlayarak modülerlik sağlar. Bu, kodun okunabilirliğini ve yönetilebilirliğini artırır.

<h5 align="left"> Observer tasarım deseninin dezavantajları:</h5>

- Eğer gözlemciler ve konular arasındaki bağlantılar düzgün bir şekilde yönetilmezse, hafıza sızıntılarına yol açabilir. Özellikle, gözlemcilerin kaydını silmeyi unutmak bu soruna sebep olabilir.
- Çok sayıda gözlemci varsa veya bildirimler çok sık yapılıyorsa, performans sorunları ortaya çıkabilir. Her bildirim, tüm gözlemcilerin tepki vermesini gerektireceğinden, işlem yükü artabilir.
- Eğer bir konu kısa süre içinde çok sayıda güncelleme yaparsa, gözlemcilerin bu güncellemelere sürekli tepki vermesi gerekir. Bu durum, beklenmedik davranışlara yol açabilir.

**Örnek Senaryo**

Peki bunu gerçek bir uygulamada, pakette, vb. nasıl uygulayabiliriz ? Ona bakalım. Senaryomuz gereği sepette 2 farklı yemek türünden varsayılan olarak daha önce 1 tane **Food1**, 1 tane **Food2** olduğunu varsayalım ve bu yemeklerin sepetteki sayısını arttırıp azalttığımı hayal edelim. Duruma göre **Total Price** artabilir veya azalabilir olacaktır.

İlk önce **Subject** bileşenimizi yani Flutter tarafında **Mobx** paketiyle birlikte **Observer** in dinleyeceği **State** bileşenlerini ve methodlarını tanımlıyoruz. Her yemek için adet arttırma ve azaltma methodlarını yazıyoruz. UI tarafında **Observer** in dinleyeceği değişkenleri **@observable** annotation ile dinleyeceğimiz değişkenleri, **@action** ile **@observable** ile etiketlenmiş değişkenleri değiştirerek UI tarafında **Observer** ile çevrili kısımların yeniden çizilmesini sağlıyoruz.

```dart

@immutable
final class Item {
  final String id;
  final String name;
  final double price;
  final String image;
  final int quantity;

  const Item({
    required this.id,
    required this.image,
    required this.name,
    required this.price,
    this.quantity = 1,
  });

  Item copyWith({
    String? id,
    String? image,
    String? name,
    double? price,
    int? quantity,
  }) {
    return Item(
      id: id ?? this.id,
      image: image ?? this.image,
      name: name ?? this.name,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }
}

```

```dart
import 'package:design_patterns/patterns/observer/model/item.dart';
import 'package:mobx/mobx.dart';

part 'observer.g.dart';

final class ShoppingItemsStore = ShoppingItemsStoreBase with _$ShoppingItemsStore;

abstract class ShoppingItemsStoreBase with Store {
  /// The list of items that the user had added to the cart.
  @observable
  ObservableList<Item> items = ObservableList.of(
    [
      const Item(
        id: '1',
        image: 'https://picsum.photos/200',
        name: 'Food 1',
        price: 10.0,
      ),
      const Item(
        id: '2',
        image: 'https://picsum.photos/200',
        name: 'Food 2',
        price: 20.0,
      ),
    ],
  );

  @observable
  double totalPrice = 30.0;

  /// [increase] Increases the quantity of the item by 1.
  @action
  void increase(Item item, int index) {
    if (!items.contains(item)) {
      items.add(item);
    }

    items[index] = item.copyWith(quantity: item.quantity + 1);
    totalPrice += item.price;
  }

  /// [decrease] Decreases the quantity of the item by 1.
  @action
  void decrease(Item item, int index) {
    if (items.contains(item) && items[index].quantity >= 1 && totalPrice >= item.price) {
      totalPrice -= item.price;

      items[index] = item.copyWith(quantity: item.quantity - 1);
      if (items[index].quantity == 0) {
        items.remove(item);
      }
    }
  }
}

```

Peki bunu UI tarafında nasıl kullanabiliriz ? Daha önce bahsettiğim gibi sepetteki yemeklerin sayısını arttırıp, azaltmaya yarayan ve buna bağlı olarak toplam tutarın güncellenmesini sağlıyoruz. Eğer **@observable** ile etiketlenmiş değişkenler **@action** ile güncellenirse UI tarafında **Observable** ile sarışmış widget ağacını yeniden çizer.

```dart
final class ObserverView extends StatefulWidget {
  const ObserverView({super.key});

  @override
  State<ObserverView> createState() => _ObserverViewState();
}

class _ObserverViewState extends State<ObserverView> {
  late final ShoppingItemsStore _store;

  @override
  void initState() {
    super.initState();
    _store = ShoppingItemsStore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Observer'),
      ),
      body: Center(
        child: SizedBox(
          width: 300,
          height: double.infinity,
          child: Observer(builder: (context) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: _store.items.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _Food(store: _store, index: index);
                  },
                ),
                const SizedBox(height: 20),
                Text('Total Price: ${_store.totalPrice}'),
              ],
            );
          }),
        ),
      ),
    );
  }
}


final class _Food extends StatelessWidget {
  const _Food({
    super.key,
    required ShoppingItemsStore store,
    required this.index,
  }) : _store = store;

  final ShoppingItemsStore _store;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(_store.items[index].name),
      subtitle: Text("Price: ${_store.items[index].price}"),
      leading: Image.network(_store.items[index].image),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed: () {
              _store.decrease(_store.items[index], index);
            },
          ),
          Text('${_store.items[index].quantity}'),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _store.increase(_store.items[index], index);
            },
          ),
        ],
      ),
    );
  }
}
```

<img src="https://github.com/Deatsilence/flutter-design-patterns/assets/78795973/8a57831f-5c57-4c7d-a253-0c0d2558a1e7" width="250"> <img src="https://github.com/Deatsilence/flutter-design-patterns/assets/78795973/ce28b883-156c-4369-a45b-fe946b390af4" width="250"> <img src="https://github.com/Deatsilence/flutter-design-patterns/assets/78795973/1b82506b-b915-4427-968f-3b9ea43f67c7" width="250">

[Dökümantasyonun başına dön](#head)

<h1 align="center">Design Patterns with Flutter</h1>

- <h2 align="left">Kısaca Design Patterns nedir ?</h2>
  Tasarım desenleri, yazılım geliştirmede yaygın olarak kullanılan önemli araçlardır. Bu desenler, nesnelerin oluşturulmasını, bir araya getirilmesini ve iletişim kurmasını kontrol ederek kod kalitesini, tutarlılığını ve yeniden kullanılabilirliğini artırabilir

- Creational Patterns
  - Factory Method
  - Abstract Factory
  - Singleton
  - Builder
  - Prototype
- Structural Patterns
  - Adapter
  - Bridge
  - Composite
  - Decorator
  - Facade
  - Flyweight
  - Proxy
- Behavioral Patterns

  - Chain of Responsibility
  - Iterator
  - Interpreter
  - Observer
  - Command
  - Mediator
  - State
  - Strategy
  - Template Method
  - Visitor
  - Memento

- <h2 align="left">Factory Method (Creational Patterns)</h2>
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

- <h2 align="left">Abstract Factory (Creational Patterns)</h2>

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

- <h2 align="left">Singleton (Creational Patterns)</h2>
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

- <h2 align="left">Prototype (Creational Patterns)</h2>
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

- <h2 align="left">Adapter (Structural Patterns)</h2>
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

- <h2 align="left">Builder (Creational Patterns)</h2>
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

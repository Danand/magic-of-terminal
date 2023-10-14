---
layout: post
title:  "bydlocoding"
---

<span class="hidden">Про быдлокод/говнокод.</span>

## Предисловие

Слово "говнокод" никогда не было каким-то ругательным. По крайней мере, для меня.

Наверно, даже "легаси" — обиднее. Не в том плане, что оно insulting, а в том плане, что вызывает больше сожаления: об упущенном времени, потраченных силах, истрёпанных нервах и т.д.

"Говнокод" же — это просто часть общего, это просто способ создания легаси в тот момент времени, когда легаси, хронологически — ещё не является "легаси".

<img src="{{ site.baseurl }}/assets/images/auf.jpg"
     height="480px"
     alt="Ауф!" />

Но что же такое "быдлокод"?

## Контекст

Больше десятка лет назад, у меня на фрилансе было много проектов парсеров: это были десктопные приложение на **Windows Forms**, написанные на **C#**.

Все частоиспользуемые утилиты для этих парсеров, тогда же — были вынесены мной в либу, гордо названную [**Bydlo Tools**](https://github.com/Danand/Bytloos).

Недавно мне захотелось устроить аттракцион жалости к себе, и просто, по рофлу, накатать код-ревью в гопническом стиле, с полным разбором по частям всего мною написанного. Но почему-то это показалось мне невыносимо глупым (как, в принципе, и всё то, что я вообще делаю), и вспомнилось, что когда-то у этого кода было более-менее сносное оправдание.

**Тот код делал то, что от него требовалось.**

## Примеры

### Отключалка валидации сертификатов

```csharp
internal static class SSLValidator
{
    private static bool OnValidateCertificate(
        object          sender,
        X509Certificate certificate,
        X509Chain       chain,
        SslPolicyErrors sslPolicyErrors)
    {
        return true;
    }

    internal static void OverrideValidation()
    {
        ServicePointManager.ServerCertificateValidationCallback = OnValidateCertificate;
        ServicePointManager.Expect100Continue = true;
    }
}
```

Выглядит преступно, по меркам энтерпрайз практик:

- чёткая несекьюрность
- дерзкая запись глобального состояния

Но. Всем. Было. Пофиг.<br />
Это было быстрым и по-своему изящным решением, для того уровня задач.

### Захардкоженный User-Agent

```csharp
private const string DEFAULT_USER_AGENT = "Mozilla/5.0 (Windows NT 10.0; WOW64) " +
                                          "AppleWebKit/537.36 (KHTML, like Gecko) " +
                                          "Chrome/69.0.3497.100 " +
                                          "Safari/537.36 " +
                                          "OPR/56.0.3051.116";
```

Выглядит просто как плохой код — какой-то непонятный лонгрид. Но, по факту, эта магическая строка когда решала судьбу большинства моих парсеров: берегла их от бана. Парсинг, как бы — не совсем желательное мероприятие, с точки зрения тех, кого парсят. Поэтому, нужно было, по возможности, как можно лучше маскировать парсеры под браузер, с которым работает человек.

### Обёртка для установки HTTP-хэдеров

```csharp
foreach (var header in headers)
{
    switch (header.PresetKey)
    {
        default:                            request.Headers.Add(header.CustomKey, header.Value);
            break;
        case HTTPHeaderKey.UserAgent:       request.UserAgent = header.Value;
            break;
        case HTTPHeaderKey.Accept:          request.Accept = header.Value;
            break;
        case HTTPHeaderKey.Host:            request.Host = header.Value;
            break;
        case HTTPHeaderKey.Referer:         request.Referer = header.Value;
            break;
        case HTTPHeaderKey.ContentType:     request.ContentType = header.Value;
            break;
        case HTTPHeaderKey.ContentLength:   request.ContentLength = long.Parse(header.Value);
            break;
        case HTTPHeaderKey.Connection:
            if (header.Value != "keep-alive" && header.Value != "close")
                request.Connection = header.Value;
            else
                request.KeepAlive = header.Value == "keep-alive";
            break;
    }
}
```

Тоже очень странная и многословная конструкция, уже издалека напоминающая велосипед из костылей. Но это было удобно.

Для того, чтобы парсер мог притвориться браузером, нужно было:

1. Проделать нужное действие сначала браузером.
2. Засниффить запрос.
3. Скопировать хэдеры.
4. Вставить прямо в код.

Чтобы последний шаг быстро сработал, нужно было сделать эту самую обёртку, которая обошла бы некоторые типовые ограничения API [`HttpWebRequest`](https://learn.microsoft.com/ru-ru/dotnet/api/system.net.httpwebrequest?view=netframework-4.0), а именно — попытку указать в качестве хэдера (`HttpWebRequest.Headers`) то, что нужно присваивать в отдельную проперти (например, `HttpWebRequest.Accept`).

### Чистилка названий файлов

```csharp
public static string RemoveInvalidFileNameChars(string source)
{
    foreach (var character in Path.GetInvalidFileNameChars())
        source = source.Replace(character.ToString(), string.Empty);

    source = source.Length < MAX_PATH_LENGTH ? source : source.Substring(0, MAX_PATH_LENGTH);

    return source;
}
```

А это — вообще что-то скопированное со **StackOverflow**, но только слегка причёсанное. Вполне себе must have, когда сохраняешь файлы с названиями из описаний товаров.

### Обёртка для `.ini`-файлов

Помните такие? Вот и я не помню, давно это было... А когда-то `.ini`-файлы были _стандартом индустрии_ быдлокодинга для хранения конфигов. Заказчики не знали никаких JSON и YAML.

```csharp
[DllImport(KERNEL_LIB_NAME)]
private static extern long WritePrivateProfileString(
    string  section,
    string  key,
    string  value,
    string  filePath);

[DllImport(KERNEL_LIB_NAME)]
private static extern int GetPrivateProfileString(
    string          section,
    string          key,
    string          defaultValue,
    StringBuilder   outValue,
    int             size,
    string          filePath);
```

### Бессмертная классика использования `BinaryFormatter`

```csharp
public static void SaveObject(object target, string pathToBinaryData)
{
    var targetDirectory = Path.GetDirectoryName(pathToBinaryData);

    if (targetDirectory != null && !Directory.Exists(targetDirectory))
        Directory.CreateDirectory(targetDirectory);

    using (var fs = new FileStream(pathToBinaryData, FileMode.Create, FileAccess.Write, FileShare.ReadWrite))
        new BinaryFormatter().Serialize(fs, target);
}

public static T LoadObject<T>(string pathToBinaryData)
{
    if (!File.Exists(pathToBinaryData))
        throw new FileNotFoundException();

    using (var fs = new FileStream(pathToBinaryData, FileMode.Open, FileAccess.Read, FileShare.Read))
        return (T) new BinaryFormatter().Deserialize(fs);
}

public static T DeepClone<T>(this T source)
{
    using (var ms = new MemoryStream())
    {
        var bf = new BinaryFormatter();
        bf.Serialize(ms, source);
        ms.Position = 0;
        return (T)bf.Deserialize(ms);
    }
}
```

Тут комментарии излишни. Некрасиво, ненадёжно, но жесть как удобно (в краткосрочной перспективе).

### Хак приватных полей

```csharp
public static TValue GetFieldValue<TObject, TValue>(this TObject source, string fieldName)
{
    var fieldInfo
        = typeof(TObject).GetField(
            name:           fieldName,
            bindingAttr:    BindingFlags.Instance | BindingFlags.NonPublic);

    var result = (TValue)fieldInfo.GetValue(source);

    return result;
}

public static void SetFieldValue<TObject, TValue>(this TObject source, string fieldName, TValue value)
{
    var fieldInfo
        = typeof(TObject).GetField(
            name:           fieldName,
            bindingAttr:    BindingFlags.Instance | BindingFlags.NonPublic);

    fieldInfo.SetValue(source, value);
}
```

У всех же бывали ситуации, когда приходилось использовать зависимость, разработчик которой зачем-то спрятал нужное поле за `private`/`protected`/`internal` доступом? Вот и у меня такое бывало. Честно говоря, даже значительно позже времён "быдлокодинга", чё уж скрывать.

### Разрезание списка на списки поменьше

```csharp
public static List<List<T>> Batch<T>(this List<T> source, int size)
{
    return source
        .Select((item, index) => new { item, index })
        .GroupBy(item => item.index / size)
        .Select(group => group.Select(x => x.item).ToList())
        .ToList();
}
```

<img src="{{ site.baseurl }}/assets/images/pomenbshe-list.jpg"
     height="480px"
     alt="List<T> поменьбше" />

Что тут говорить:

- некрасиво
- неоптимизированно
- охренеть, как неоптимизированно
- видно незнание алгоритмов и нежелание тренироваться в их использовании
- **УДОБНО**
- было вообще пофиг, насколько быстро это работает

## Послесловие

Слово "быдлокод" устарело. И не из-за того, что оно какое-то неполиткорректное. И не из-за того, что оно выдаёт горькое пренебрежение человека к своему труду (мол, _"я мог(ла) бы делать великие программные продукты, а мне подсовывают какие-то парсеры"_). Не только поэтому. А скорее потому, что сейчас на рынке стало гораздо меньше задач, подпадающих под описание этим словом.

Молодёжь учится работать с криптой, нейронками; учится на курсах по всяким модным направлениям. Да, там тоже много всякой мути, много мошеничества. Но точно таких же задач, что были раньше — уже нет (наверно).

Ваш код — говно! Не обесценивайте свой труд. 🧡
